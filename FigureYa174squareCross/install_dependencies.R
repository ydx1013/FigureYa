#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")
options(timeout = 600)  # 增加超时时间到10分钟

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# Function to install CRAN packages
install_cran_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing CRAN package:", package_name, "\n")
    tryCatch({
      install.packages(package_name, dependencies = TRUE, quiet = FALSE)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install Bioconductor packages
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      BiocManager::install(package_name, update = FALSE, ask = FALSE, quiet = FALSE)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# 安装GitHub包
install_github_package <- function(repo, package_name = NULL, build_vignettes = FALSE) {
  if (is.null(package_name)) {
    package_name <- basename(repo)
  }
  
  if (is_package_installed(package_name)) {
    cat("Package already installed:", package_name, "\n")
    return(TRUE)
  }
  
  cat("Installing from GitHub:", repo, "\n")
  tryCatch({
    if (!is_package_installed("remotes")) {
      install.packages("remotes")
    }
    
    if (build_vignettes) {
      remotes::install_github(repo, build_vignettes = TRUE)
    } else {
      remotes::install_github(repo)
    }
    
    if (is_package_installed(package_name)) {
      cat("Successfully installed from GitHub:", package_name, "\n")
      return(TRUE)
    } else {
      cat("Installation completed but package not found:", package_name, "\n")
      return(FALSE)
    }
  }, error = function(e) {
    cat("Failed to install from GitHub:", e$message, "\n")
    return(FALSE)
  })
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# 首先安装基础依赖
cat("\nInstalling important dependency packages first...\n")
base_dep_packages <- c("remotes", "httr", "curl")
for (pkg in base_dep_packages) {
  install_cran_package(pkg)
}

# 安装标准CRAN包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("aplot", "dplyr", "ggplot2", "reshape2", "tibble", "purrr")
for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 安装crosslink包（从GitHub）- 单数！
cat("\nInstalling crosslink package from GitHub...\n")
crosslink_success <- install_github_package("zzwch/crosslink", "crosslink", build_vignettes = TRUE)

# 如果安装失败，尝试其他可能的方法
if (!crosslink_success) {
  cat("\nTrying alternative installation methods for crosslink...\n")
  
  # 方法1：尝试安装可能需要的依赖
  potential_deps <- c("Rcpp", "BH", "rcpparmadillo", "Matrix")
  for (pkg in potential_deps) {
    if (!is_package_installed(pkg)) {
      install_cran_package(pkg)
    }
  }
  
  # 再次尝试安装（不构建vignettes）
  cat("Retrying crosslink installation (without vignettes)...\n")
  crosslink_success <- install_github_package("zzwch/crosslink", "crosslink", build_vignettes = FALSE)
}

# 验证安装
cat("\nVerifying package installation...\n")
required_packages <- c("aplot", "dplyr", "ggplot2", "crosslink")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
    # 测试包是否能正常加载
    tryCatch({
      suppressPackageStartupMessages(library(pkg, character.only = TRUE, quietly = TRUE))
      cat("  Package loads successfully\n")
    }, error = function(e) {
      cat("  ERROR: Package has loading issues:", e$message, "\n")
      all_installed <- FALSE
    })
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed = FALSE
  }
}

# 显示安装总结
cat("\n===========================================\n")
if (all_installed) {
  cat("All packages successfully installed!\n")
} else {
  cat("Some packages failed to install.\n")
}

cat("\nInstallation summary:\n")
cat("- crosslink:", ifelse(is_package_installed("crosslink"), "✓", "✗"), "\n")
cat("- aplot:", ifelse(is_package_installed("aplot"), "✓", "✗"), "\n") 
cat("- dplyr:", ifelse(is_package_installed("dplyr"), "✓", "✗"), "\n")
cat("- ggplot2:", ifelse(is_package_installed("ggplot2"), "✓", "✗"), "\n")

if (!is_package_installed("crosslink")) {
  cat("\nTroubleshooting for crosslink:\n")
  cat("1. Make sure you have development tools installed (Rtools on Windows, Xcode on Mac)\n")
  cat("2. Try installing system dependencies first\n")
  cat("3. Check the GitHub repository: https://github.com/zzwch/crosslink\n")
  cat("4. You can try manual installation: remotes::install_github('zzwch/crosslink', build_vignettes = TRUE)\n")
}

cat("You can now run your R scripts in this directory.\n")

# 提供会话信息用于调试
cat("\nSession information for debugging:\n")
print(sessionInfo())
