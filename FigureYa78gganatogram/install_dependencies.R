#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(requireNamespace(package_name, quietly = TRUE))
}

# Function to install CRAN packages
install_cran_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing CRAN package:", package_name, "\n")
    tryCatch({
      install.packages(package_name, dependencies = TRUE, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

# Function to install GitHub packages
install_github_package <- function(repo) {
  package_name <- basename(repo)
  if (!is_package_installed(package_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools", quiet = TRUE)
      }
      devtools::install_github(repo, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", repo, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# 首先安装devtools（用于GitHub安装）
if (!is_package_installed("devtools")) {
  install_cran_package("devtools")
}

# 安装gganatogram从GitHub
cat("\nInstalling gganatogram from GitHub...\n")
install_github_package("jespermaag/gganatogram")

# 安装CRAN包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("stringr", "gridExtra")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 安装常用的辅助包（可选）
cat("\nInstalling optional utility packages...\n")
utility_packages <- c("ggplot2", "dplyr", "tidyr")

for (pkg in utility_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying package installation:\n")
required_packages <- c("stringr", "gridExtra", "gganatogram")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

# 测试包加载
cat("\nTesting package loading...\n")
tryCatch({
  library(stringr)
  cat("✓ stringr package loaded successfully\n")
}, error = function(e) {
  cat("✗ stringr loading failed:", e$message, "\n")
})

tryCatch({
  library(gridExtra)
  cat("✓ gridExtra package loaded successfully\n")
}, error = function(e) {
  cat("✗ gridExtra loading failed:", e$message, "\n")
})

tryCatch({
  library(gganatogram)
  cat("✓ gganatogram package loaded successfully\n")
  
  # 测试gganatogram的内置数据
  if (exists("hgMale_key") && exists("hgFemale_key")) {
    cat("✓ gganatogram内置数据可用\n")
  }
}, error = function(e) {
  cat("✗ gganatogram loading failed:", e$message, "\n")
})

cat("\nYou can now run your R scripts in this directory.\n")
