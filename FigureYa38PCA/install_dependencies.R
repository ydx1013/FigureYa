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

# Function to install GitHub packages
install_github_package <- function(repo_name) {
  package_name <- strsplit(repo_name, "/")[[1]][2]
  if (!is_package_installed(package_name)) {
    cat("Installing GitHub package:", repo_name, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github(repo_name)
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
cran_packages <- c("dplyr", "ggplot2", "plyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing GitHub packages
cat("\nInstalling GitHub packages...\n")
github_packages <- c("fawda123/ggord")  # ggord 在 GitHub 上

for (pkg in github_packages) {
  install_github_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Test if ggord can be loaded
cat("\nTesting ggord package...\n")
if (require("ggord", quietly = TRUE)) {
  cat("✅ ggord package loaded successfully!\n")
} else {
  cat("❌ ggord package could not be loaded.\n")
  cat("You may need to install it manually:\n")
  cat("devtools::install_github('fawda123/ggord')\n")
}

cat("You can now run your R scripts in this directory.\n")
