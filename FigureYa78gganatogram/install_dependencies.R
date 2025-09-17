#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

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

# Function to install GitHub packages with better error handling
install_github_package <- function(repo) {
  package_name <- basename(repo)
  if (!is_package_installed(package_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes", quiet = TRUE)
      }
      remotes::install_github(repo, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install from GitHub:", e$message, "\n")
      
      # 尝试使用devtools作为备选
      cat("Trying alternative installation with devtools...\n")
      tryCatch({
        if (!is_package_installed("devtools")) {
          install.packages("devtools", quiet = TRUE)
        }
        devtools::install_github(repo, quiet = TRUE)
        cat("✓ Successfully installed with devtools:", package_name, "\n")
      }, error = function(e2) {
        cat("✗ All installation methods failed for", repo, "\n")
      })
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# 首先安装基础工具
if (!is_package_installed("remotes")) {
  install_cran_package("remotes")
}

# 安装gganatogram从GitHub
cat("\nInstalling gganatogram from GitHub...\n")
install_github_package("jespermaag/gganatogram")

# 安装CRAN包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("gridExtra", "stringr", "ggplot2", "dplyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying package installation:\n")
all_packages <- c("gganatogram", "gridExtra", "stringr", "ggplot2", "dplyr")

for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# 测试gganatogram功能
if (is_package_installed("gganatogram")) {
  cat("\nTesting gganatogram package...\n")
  tryCatch({
    library(gganatogram)
    cat("✓ gganatogram package loaded successfully\n")
    
    # 检查主要函数是否存在
    if (exists("gganatogram")) {
      cat("✓ Main function is available\n")
    }
  }, error = function(e) {
    cat("✗ gganatogram test failed:", e$message, "\n")
  })
} else {
  cat("\n⚠️  gganatogram installation failed. Alternative solutions:\n")
  cat("1. Manual installation: remotes::install_github('jespermaag/gganatogram')\n")
  cat("2. Alternative package: install.packages('anatogram')\n")
  cat("3. Use ggplot2 with custom anatomical images\n")
}

cat("\nYou can now run your R scripts in this directory.\n")
