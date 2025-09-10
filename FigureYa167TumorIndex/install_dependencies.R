#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror = "http://mirrors.tuna.tsinghua.edu.cn/bioconductor/")

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
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      BiocManager::install(package_name, update = FALSE, ask = FALSE)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")


# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("GSA", "X12M_DKO", "X12M_DKO_HCC", "X12M_PKO", "X12M_PKO_HCA", "X12M_SKO", "X12M_WT", "X16M_PKO_HCA", "X16M_PKO_HCC", "X16M_WT", "X1M_DKO", "X1M_PKO", "X1M_SKO", "X1M_WT", "X2M_DKO", "X2M_PKO", "X2M_SKO", "X2M_WT", "X3M_PKO", "X3M_WT", "X4M_PKO", "X4M_WT", "X5M_PKO", "X5M_WT", "X7M_DKO", "X7M_DKO_HCC", "X7M_PKO", "X7M_PKO_HCA", "X7M_SKO", "X7M_WT", "X9M_PKO", "X9M_WT", "Youth", "ggplot2", "ggpubr", "ggsci", "glmnet", "preprocessCore", "randomForest", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("GEOquery")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
