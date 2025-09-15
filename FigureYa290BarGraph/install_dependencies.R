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

# Function to install from GitHub
install_github_package <- function(repo) {
  package_name <- strsplit(repo, "/")[[1]][2]
  if (!is_package_installed(package_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", repo, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("Matrix", "Seurat", "ggplot2", "hdf5r", "rstatix", "remotes")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing SeuratDisk from GitHub (official repository)
cat("\nInstalling SeuratDisk from GitHub...\n")
install_github_package("mojaveazure/seurat-disk")

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")

# Verify installation
cat("\nVerifying package installation...\n")
required_packages <- c("Matrix", "Seurat", "SeuratDisk", "ggplot2", "hdf5r", "rstatix")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}
