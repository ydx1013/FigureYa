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

# Special installation for ggtern with version handling
install_ggtern <- function() {
  if (!is_package_installed("ggtern")) {
    cat("Installing ggtern (may require specific version)...\n")
    
    # 先安装依赖包
    cat("Installing ggtern dependencies first...\n")
    dependencies <- c("ggplot2", "proto", "scales", "grid", "gtable", "plyr", 
                     "MASS", "compositions", "dplyr", "tidyverse")
    
    for (pkg in dependencies) {
      if (!is_package_installed(pkg)) {
        install_cran_package(pkg)
      }
    }
    
    # 尝试不同版本的安装方法
    tryCatch({
      # 方法1: 尝试安装最新版本
      cat("Attempt 1: Installing latest ggtern from CRAN...\n")
      install.packages("ggtern", dependencies = TRUE, quiet = TRUE)
      cat("✓ Successfully installed ggtern\n")
    }, error = function(e) {
      cat("✗ Latest version failed:", e$message, "\n")
      
      # 方法2: 尝试安装特定版本
      cat("Attempt 2: Trying specific ggtern version...\n")
      tryCatch({
        if (!is_package_installed("remotes")) {
          install.packages("remotes", quiet = TRUE)
        }
        # 安装较旧的稳定版本
        remotes::install_version("ggtern", version = "3.3.0", quiet = TRUE)
        cat("✓ Successfully installed ggtern version 3.3.0\n")
      }, error = function(e2) {
        cat("✗ Version 3.3.0 failed:", e2$message, "\n")
        
        # 方法3: 从GitHub安装开发版本
        cat("Attempt 3: Installing from GitHub...\n")
        tryCatch({
          remotes::install_github("nicholasehamilton/ggtern")
          cat("✓ Successfully installed ggtern from GitHub\n")
        }, error = function(e3) {
          cat("✗ All ggtern installation attempts failed\n")
          cat("Error:", e3$message, "\n")
        })
      })
    })
  } else {
    cat("✓ ggtern already installed\n")
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

# 特殊安装ggtern
cat("\nInstalling ggtern...\n")
install_ggtern()

# 验证安装
cat("\n===========================================\n")
cat("Verifying installation...\n")

required_packages <- c("ggplot2", "ggtern", "directlabels", "scales", "tidyverse")
success_count <- 0

for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is ready\n")
    success_count <- success_count + 1
    
    # 测试ggtern功能
    if (pkg == "ggtern" && is_package_installed("ggtern")) {
      cat("Testing ggtern functionality...\n")
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
    cat("3. Manual ggtern install: remotes::install_version('ggtern', '3.3.0')\n")
  }
}

# 提供备选方案信息
cat("\nIf ggtern continues to fail, consider these alternatives:\n")
cat("- Ternary package: install.packages('Ternary')\n") 
cat("- plotly for interactive ternary: install.packages('plotly')\n")
cat("- vcd for ternary plots: install.packages('vcd')\n")
