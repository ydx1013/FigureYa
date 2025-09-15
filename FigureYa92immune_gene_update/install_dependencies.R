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

# Function to install specific problematic packages
install_problematic_packages <- function() {
  cat("Installing problematic dependencies...\n")
  
  # First install PMCMRplus which is causing the issue
  if (!is_package_installed("PMCMRplus")) {
    cat("Installing PMCMRplus from GitHub...\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github("cran/PMCMRplus")
      cat("Successfully installed PMCMRplus\n")
    }, error = function(e) {
      cat("Failed to install PMCMRplus:", e$message, "\n")
    })
  }
  
  # Then install statsExpressions
  if (!is_package_installed("statsExpressions")) {
    cat("Installing statsExpressions...\n")
    install_cran_package("statsExpressions")
  }
  
  # Finally install ggstatsplot
  if (!is_package_installed("ggstatsplot")) {
    cat("Installing ggstatsplot...\n")
    install_cran_package("ggstatsplot")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Install basic CRAN packages first
cat("\nInstalling basic CRAN packages...\n")
basic_packages <- c("data.table", "dplyr", "ggplot2", "tidyr")
for (pkg in basic_packages) {
  install_cran_package(pkg)
}

# Install problematic packages with special handling
cat("\nInstalling packages with special dependencies...\n")
install_problematic_packages()

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")

# Verify critical packages are installed
cat("\nVerifying installation...\n")
critical_packages <- c("ggstatsplot", "statsExpressions", "PMCMRplus")
for (pkg in critical_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}
