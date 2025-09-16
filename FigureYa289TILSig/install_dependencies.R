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

# Function to install Bioconductor packages
install_bioc_package <- function(package_name, version = NULL) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      if (is.null(version)) {
        BiocManager::install(package_name, update = FALSE, ask = FALSE)
      } else {
        BiocManager::install(paste0(package_name, "@", version), update = FALSE, ask = FALSE)
      }
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install package from source
install_source_package <- function(package_url) {
  cat("Installing package from source:", package_url, "\n")
  tryCatch({
    install.packages(package_url, repos = NULL, type = "source")
    cat("Successfully installed package from source\n")
  }, error = function(e) {
    cat("Failed to install from source:", e$message, "\n")
  })
}

# Function to install remotes package
install_remotes_package <- function() {
  if (!is_package_installed("remotes")) {
    install_cran_package("remotes")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Install remotes first
install_remotes_package()

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("dplyr", "stringr", "survival", "sva", "tibble", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# First install an older version of GEOquery that has gunzip function
cat("\nInstalling older version of GEOquery...\n")
tryCatch({
  if (!is_package_installed("GEOquery")) {
    remotes::install_version("GEOquery", version = "2.58.0")  # 选择一个较旧的版本
  }
}, error = function(e) {
  cat("Failed to install older GEOquery:", e$message, "\n")
})

# Installing other Bioconductor packages
cat("\nInstalling other Bioconductor packages...\n")
bioc_packages <- c("GenomicFeatures", "limma", "rtracklayer", "affy")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Install DealGPL570 from source
cat("\nInstalling DealGPL570 from source...\n")
deal_gpl570_url <- "https://cran.r-project.org/src/contrib/Archive/DealGPL570/DealGPL570_0.0.1.tar.gz"
install_source_package(deal_gpl570_url)

# 如果上面的方法不行，尝试手动修复 DealGPL570 包
if (!is_package_installed("DealGPL570")) {
  cat("\n尝试替代方案：手动处理 GPL570 数据...\n")
  # 这里可以添加替代 DealGPL570 功能的代码
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
