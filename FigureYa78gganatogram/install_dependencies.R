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

cat("Starting R package installation...\n")
cat("===========================================\n")

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
required_packages <- c("stringr", "gridExtra")

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

if (all_installed) {
  cat("\n✅ All required packages installed successfully!\n")
  cat("You can now use these packages in your R scripts:\n")
  cat("library(stringr)    # 字符串处理工具\n")
  cat("library(gridExtra)  # 网格图形布局工具\n")
} else {
  cat("\n⚠️  Some packages failed to install. You can try:\n")
  cat("1. Manual installation: install.packages('package_name')\n")
  cat("2. Check your internet connection\n")
  cat("3. Try a different CRAN mirror\n")
}

cat("\nYou can now run your R scripts in this directory.\n")
