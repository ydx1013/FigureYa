#!/usr/bin/env Rscript
# Auto-generated R dependency installation script for ternary plots
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

cat("Starting R package installation for ternary plots...\n")
cat("===========================================\n")

# 安装基础工具
if (!is_package_installed("remotes")) {
  install.packages("remotes", quiet = TRUE)
}

# 安装其他CRAN包
cat("\nInstalling other CRAN packages...\n")
other_packages <- c("directlabels", "ggplot2", "proto", "scales", "tidyverse", 
                   "dplyr", "grid", "gtable", "plyr", "MASS", "compositions")

for (pkg in other_packages) {
  install_cran_package(pkg)
}

# 安装ggtern - 从GitHub安装
cat("\nInstalling ggtern from GitHub...\n")
install_github_package("nicholasehamilton/ggtern")

# 验证安装
cat("\n===========================================\n")
cat("Verifying installation...\n")

required_packages <- c("ggplot2", "ggtern", "directlabels", "scales", "tidyverse")
success_count <- 0

for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is ready\n")
    success_count <- success_count + 1
  } else {
    cat("✗", pkg, "is MISSING\n")
  }
}

cat("\nInstallation summary:\n")
cat("Successfully installed:", success_count, "/", length(required_packages), "packages\n")

if (success_count == length(required_packages)) {
  cat("✅ All packages installed successfully!\n")
  cat("You can now run your ternary plot scripts.\n")
} else {
  cat("⚠️  Some packages failed to install.\n")
  
  # 提供备选方案
  if (!is_package_installed("ggtern")) {
    cat("\nAlternative ternary plot packages:\n")
    cat("1. Try: install.packages('Ternary') - for base R ternary plots\n")
    cat("2. Try: install.packages('plotly') - for interactive ternary plots\n")
    cat("3. Manual ggtern install: remotes::install_github('nicholasehamilton/ggtern')\n")
  }
}

# 测试ggtern功能
if (is_package_installed("ggtern")) {
  cat("\nTesting ggtern functionality...\n")
  tryCatch({
    library(ggtern)
    cat("✓ ggtern loaded successfully\n")
    
    # 简单测试
    data <- data.frame(x = c(0.5, 0.3, 0.2),
                     y = c(0.3, 0.5, 0.2),
                     z = c(0.2, 0.2, 0.6))
    p <- ggtern(data, aes(x, y, z)) + geom_point()
    cat("✓ ggtern basic functionality test passed\n")
  }, error = function(e) {
    cat("✗ ggtern functionality test failed:", e$message, "\n")
  })
}
