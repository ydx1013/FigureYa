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
      cat("Warning: Failed to install CRAN package '", package_name, "': ", e$message, "\n")
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
      cat("Warning: Failed to install Bioconductor package '", package_name, "': ", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install DealGPL570 from source
install_deal_gpl570 <- function() {
  if (!is_package_installed("DealGPL570")) {
    cat("Installing DealGPL570 from source...\n")
    tryCatch({
      # First install dependencies
      cat("Installing dependencies for DealGPL570...\n")
      install_bioc_package("GEOquery")
      install_bioc_package("affy")
      
      # Install DealGPL570 from CRAN archive
      install.packages("https://cran.r-project.org/src/contrib/Archive/DealGPL570/DealGPL570_0.0.1.tar.gz", 
                      repos = NULL, type = "source")
      cat("Successfully installed: DealGPL570\n")
    }, error = function(e) {
      cat("Warning: Failed to install DealGPL570: ", e$message, "\n")
      cat("Trying alternative installation method...\n")
      
      # Alternative: install from GitHub if available
      tryCatch({
        if (!is_package_installed("remotes")) {
          install.packages("remotes")
        }
        remotes::install_github("cran/DealGPL570")
        cat("Successfully installed: DealGPL570 (from GitHub)\n")
      }, error = function(e2) {
        cat("Error: All installation methods failed for DealGPL570: ", e2$message, "\n")
      })
    })
  } else {
    cat("Package already installed: DealGPL570\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install BiocManager if not already installed
if (!is_package_installed("BiocManager")) {
  cat("Installing BiocManager...\n")
  install.packages("BiocManager")
}

# Installing core CRAN dependencies
cat("\nInstalling core CRAN dependencies...\n")
core_packages <- c("curl", "httr", "gargle", "googledrive", "googlesheets4", "ragg", "rvest", "remotes")

for (pkg in core_packages) {
  install_cran_package(pkg)
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
# Removed invalid package names that appear to be column names, not packages
cran_packages <- c("dplyr", "ggplot2", "readr", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("Rhtslib", "maftools")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Special installation for DealGPL570
cat("\nInstalling DealGPL570 (special package)...\n")
install_deal_gpl570()

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
all_packages <- c(core_packages, cran_packages, bioc_packages, "DealGPL570")
for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# System dependency reminder
cat("\nNOTE: If you encounter system dependency errors, please install:\n")
cat("For Ubuntu/Debian:\n")
cat("  sudo apt-get install libfontconfig1-dev libcurl4-openssl-dev libxml2-dev libssl-dev\n")
cat("For CentOS/RHEL:\n")
cat("  sudo yum install fontconfig-devel libcurl-devel libxml2-devel openssl-devel\n")

cat("You can now run your R scripts in this directory.\n")
