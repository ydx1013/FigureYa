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

# Function to install from GitHub using devtools
install_github_package <- function(repo, pkg_name = NULL) {
  if (is.null(pkg_name)) {
    pkg_name <- basename(repo)
  }
  
  if (!is_package_installed(pkg_name)) {
    cat("Installing from GitHub:", repo, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github(repo)
      cat("Successfully installed from GitHub:", pkg_name, "\n")
    }, error = function(e) {
      cat("Failed to install from GitHub", repo, ":", e$message, "\n")
      return(FALSE)
    })
  } else {
    cat("Package already installed:", pkg_name, "\n")
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

# Install CMScaller dependencies first
cat("\nInstalling CMScaller dependencies...\n")
cms_dependencies <- c("limma", "Biobase", "preprocessCore")
for (pkg in cms_dependencies) {
  install_bioc_package(pkg)
}

# Install CRAN dependencies for CMScaller
cat("\nInstalling additional CRAN dependencies...\n")
cran_deps <- c("cluster", "e1071", "RColorBrewer")
for (pkg in cran_deps) {
  install_cran_package(pkg)
}

# Install CMScaller from GitHub using devtools
cat("\nInstalling CMScaller from GitHub...\n")
install_github_package("Lothelab/CMScaller", "CMScaller")

# Install other required packages
cat("\nInstalling other required packages...\n")
other_packages <- c("pheatmap", "survival", "survminer")
for (pkg in other_packages) {
  install_cran_package(pkg)
}

# Verify installation
cat("\n===========================================\n")
cat("Verifying package installation...\n")

required_packages <- c("CMScaller", "limma", "Biobase")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

cat("\nPackage installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
