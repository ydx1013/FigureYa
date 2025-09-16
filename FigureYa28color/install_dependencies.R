#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

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
      install.packages(package_name, dependencies = TRUE)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install packages from GitHub
install_github_package <- function(repo) {
  package_name <- strsplit(repo, "/")[[1]][2]
  if (!is_package_installed(package_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", repo, ":", e$message, "\n")
      # 提供替代方案
      suggest_alternatives(package_name)
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# 提供替代的颜色方案包
suggest_alternatives <- function(package_name) {
  if (package_name == "rPlotter") {
    cat("\n尝试安装替代的颜色方案包...\n")
    alternative_packages <- c("RColorBrewer", "viridis", "ggsci", "paletteer", "colorspace")
    
    for (pkg in alternative_packages) {
      if (!is_package_installed(pkg)) {
        install_cran_package(pkg)
      }
    }
    cat("这些包提供了丰富的颜色方案，可以替代 rPlotter 的功能\n")
  }
}

# 尝试不同的 rPlotter 仓库地址
try_different_rplotter_repos <- function() {
  repos_to_try <- c(
    "tomwhoooo/rPlotter",
    "tomwhooo/rPlotter",  # 可能的拼写变体
    "tomsing1/rPlotter",   # 另一个可能的用户名
    "r-lib/rPlotter"       # 官方仓库（如果存在）
  )
  
  for (repo in repos_to_try) {
    cat("尝试仓库:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("成功从", repo, "安装 rPlotter\n")
      return(TRUE)
    }, error = function(e) {
      cat("无法从", repo, "安装:", e$message, "\n")
      return(FALSE)
    })
  }
  return(FALSE)
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# 首先安装 remotes
if (!is_package_installed("remotes")) {
  install_cran_package("remotes")
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("scales")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 尝试安装 rPlotter
cat("\n尝试安装 rPlotter...\n")
if (!is_package_installed("rPlotter")) {
  success <- try_different_rplotter_repos()
  
  if (!success) {
    cat("\nrPlotter 包无法安装，安装替代的颜色方案包...\n")
    suggest_alternatives("rPlotter")
  }
} else {
  cat("rPlotter 已经安装\n")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 检查最终安装状态
cat("\n检查安装状态:\n")
required_packages <- c("scales", "rPlotter", "RColorBrewer", "viridis")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

cat("You can now run your R scripts in this directory.\n")
