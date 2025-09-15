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
  cat("\nInstalling problematic dependencies...\n")
  
  # First try to install PMCMRplus from CRAN
  if (!is_package_installed("PMCMRplus")) {
    cat("Attempting to install PMCMRplus...\n")
    tryCatch({
      install.packages("PMCMRplus", dependencies = TRUE)
      cat("Successfully installed PMCMRplus\n")
    }, error = function(e) {
      cat("PMCMRplus not available on CRAN, trying alternative approach...\n")
    })
  }
  
  # If PMCMRplus failed, try installing from archive
  if (!is_package_installed("PMCMRplus")) {
    cat("Trying to install PMCMRplus from archive...\n")
    tryCatch({
      install.packages("https://cran.r-project.org/src/contrib/Archive/PMCMRplus/PMCMRplus_1.9.6.tar.gz", 
                       repos = NULL, type = "source")
      cat("Successfully installed PMCMRplus from archive\n")
    }, error = function(e) {
      cat("Failed to install PMCMRplus from archive:", e$message, "\n")
    })
  }
  
  # Install statsExpressions
  if (!is_package_installed("statsExpressions")) {
    cat("Installing statsExpressions...\n")
    install_cran_package("statsExpressions")
  }
  
  # Install ggstatsplot with specific version if needed
  if (!is_package_installed("ggstatsplot")) {
    cat("Installing ggstatsplot...\n")
    tryCatch({
      install.packages("ggstatsplot", dependencies = TRUE)
      cat("Successfully installed ggstatsplot\n")
    }, error = function(e) {
      cat("Trying alternative ggstatsplot installation...\n")
      # Try installing from GitHub as fallback
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      tryCatch({
        remotes::install_github("IndrajeetPatil/ggstatsplot")
        cat("Successfully installed ggstatsplot from GitHub\n")
      }, error = function(e) {
        cat("Failed to install ggstatsplot:", e$message, "\n")
      })
    })
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Install basic dependencies first
cat("\nInstalling basic CRAN packages...\n")
basic_packages <- c("ggplot2", "scales", "stringr", "survival", "dplyr", "tidyr", "viridis", "readr")
for (pkg in basic_packages) {
  install_cran_package(pkg)
}

# Install problematic packages with special handling
install_problematic_packages()

# Install remaining tidyverse components if needed
if (!is_package_installed("tidyverse")) {
  cat("\nInstalling tidyverse...\n")
  install_cran_package("tidyverse")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Verify critical packages are installed
critical_packages <- c("survival", "ggplot2", "ggstatsplot")
cat("\nVerifying critical packages:\n")
for (pkg in critical_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

cat("\nYou can now run your R scripts in this directory.\n")
