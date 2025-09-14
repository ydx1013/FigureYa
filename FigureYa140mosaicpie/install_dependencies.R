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

# Function to install packages from GitHub
install_github_package <- function(repo) {
  pkg_name <- basename(repo)
  if (!is_package_installed(pkg_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed:", pkg_name, "\n")
    }, error = function(e) {
      cat("Warning: Failed to install GitHub package '", repo, "': ", e$message, "\n")
    })
  } else {
    cat("Package already installed:", pkg_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("remotes", "ggplot2", "readxl", "reshape2")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing GitHub packages
cat("\nInstalling GitHub packages...\n")
# cgdsr is available on GitHub, not on CRAN
github_packages <- c("cBioPortal/cgdsr")

for (pkg in github_packages) {
  install_github_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
all_packages <- c(cran_packages, basename(github_packages))
for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

cat("You can now run your R scripts in this directory.\n")
