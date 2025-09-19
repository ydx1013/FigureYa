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
      return(FALSE)
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
  return(TRUE)
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
      return(FALSE)
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
  return(TRUE)
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install basic dependencies
cat("\nInstalling basic dependencies...\n")
basic_packages <- c("devtools", "ggplot2", "dplyr", "tidyr", "tibble")
for (pkg in basic_packages) {
  install_cran_package(pkg)
}

# Install BiocManager if not present
if (!is_package_installed("BiocManager")) {
  install.packages("BiocManager")
}

# Install GEOquery for GEO data download
cat("\nInstalling GEOquery for GEO data access...\n")
install_bioc_package("GEOquery")

# Install pamr and cluster packages
cat("\nInstalling pamr and cluster packages...\n")
cran_packages <- c("pamr", "cluster", "RColorBrewer", "pheatmap", "survival", "survminer")
for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Install other useful Bioconductor packages
cat("\nInstalling other useful Bioconductor packages...\n")
bioc_packages <- c("limma", "Biobase", "preprocessCore")
for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Verify installation
cat("\n===========================================\n")
cat("Verifying package installation...\n")

required_packages <- c("GEOquery", "pamr", "cluster", "limma", "Biobase")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# Test package functionality
cat("\nTesting package functionality...\n")
test_packages <- c("GEOquery", "pamr", "cluster")
for (pkg in test_packages) {
  if (is_package_installed(pkg)) {
    tryCatch({
      library(pkg, character.only = TRUE)
      cat("✓", pkg, "loaded successfully\n")
      cat("  Version:", packageVersion(pkg), "\n")
    }, error = function(e) {
      cat("✗ Failed to load", pkg, ":", e$message, "\n")
    })
  }
}

cat("\nPackage installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
