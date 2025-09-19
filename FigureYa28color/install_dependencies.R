#!/usr/bin/env Rscript
# Auto-generated R dependency installation script for rPlotter
# This script installs all required R packages for rPlotter

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
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

# Function to install Bioconductor packages
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager", quiet = TRUE)
      }
      BiocManager::install(package_name, ask = FALSE, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

# Function to install packages from GitHub
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

cat("Starting R package installation for rPlotter...\n")
cat("===========================================\n")

# 1. 安装CRAN包（包括scales和rgl）
cat("\n1. Installing CRAN packages...\n")
cran_packages <- c("ggplot2", "stringr", "reshape2", "dichromat", "scales", "rgl")
for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 2. 安装EBImage (Bioconductor)
cat("\n2. Installing EBImage from Bioconductor...\n")
install_bioc_package("EBImage")

# 3. 安装GitHub包
cat("\n3. Installing packages from GitHub...\n")

# 首先安装devtools
if (!is_package_installed("devtools")) {
  install_cran_package("devtools")
}

# 安装rblocks
install_github_package("ramnathv/rblocks")

# 4. 最后安装rPlotter
cat("\n4. Installing rPlotter from GitHub...\n")
install_github_package("woobe/rPlotter")

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying package installation:\n")
required_packages <- c(
  "ggplot2", "stringr", "reshape2", "dichromat", "scales", "rgl", # CRAN包
  "EBImage",                                     # Bioconductor包
  "rblocks",                                     # GitHub包
  "rPlotter"                                     # 目标包
)

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

# 测试scales包功能
if (is_package_installed("scales")) {
  cat("\nTesting scales package...\n")
  tryCatch({
    library(scales)
    cat("✓ scales package loaded successfully\n")
    # 测试一些常用函数
    if (exists("percent") && exists("comma") && exists("scientific")) {
      cat("✓ scales main functions are available\n")
    }
  }, error = function(e) {
    cat("✗ scales test failed:", e$message, "\n")
  })
}

# 测试rgl包功能
if (is_package_installed("rgl")) {
  cat("\nTesting rgl package...\n")
  tryCatch({
    library(rgl)
    cat("✓ rgl package loaded successfully\n")
    # 检查主要函数是否存在
    if (exists("plot3d") && exists("rgl.open") && exists("rgl.points")) {
      cat("✓ rgl main functions are available\n")
    }
  }, error = function(e) {
    cat("✗ rgl test failed:", e$message, "\n")
  })
}

# 测试rPlotter功能
if (is_package_installed("rPlotter")) {
  cat("\nTesting rPlotter package...\n")
  tryCatch({
    library(rPlotter)
    cat("✓ rPlotter package loaded successfully\n")
    # 检查主要函数是否存在
    if (exists("plot_colors") || exists("rPlotter")) {
      cat("✓ Main functions are available\n")
    }
  }, error = function(e) {
    cat("✗ rPlotter test failed:", e$message, "\n")
  })
}

cat("\n===========================================\n")
if (all_installed) {
  cat("✅ All required packages installed successfully!\n")
  cat("You can now use rPlotter, scales, and rgl in your R scripts.\n")
} else {
  cat("⚠️  Some packages failed to install. You may need to:\n")
  cat("1. Check your internet connection\n")
  cat("2. Install missing packages manually\n")
  cat("3. For Bioconductor packages: BiocManager::install('package_name')\n")
  cat("4. For GitHub packages: devtools::install_github('user/repo')\n")
}

cat("\nYou can now run your R scripts with rPlotter, scales, and rgl.\n")
