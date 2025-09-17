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

# Function to install GitHub packages
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
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
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

# 安装CancerSubtypes从GitHub
cat("\nInstalling CancerSubtypes from GitHub...\n")
install_github_package("wybert/CancerSubtypes")

# 安装CRAN包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("data.table", "stringr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying package installation:\n")
all_packages <- c("CancerSubtypes", "data.table", "stringr")

for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# 测试CancerSubtypes功能
if (is_package_installed("CancerSubtypes")) {
  cat("\nTesting CancerSubtypes package...\n")
  tryCatch({
    library(CancerSubtypes)
    cat("✓ CancerSubtypes package loaded successfully\n")
    
    # 检查主要函数是否存在
    if (exists("ExecuteCC") && exists("ExecuteSNF")) {
      cat("✓ Main functions are available\n")
    }
  }, error = function(e) {
    cat("✗ CancerSubtypes test failed:", e$message, "\n")
  })
}

cat("\nYou can now run your R scripts in this directory.\n")
