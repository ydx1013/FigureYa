#!/usr/bin/env Rscript
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# Function to install CRAN packages
install_cran_packages <- function(packages) {
  packages_to_install <- packages[!sapply(packages, is_package_installed)]
  if (length(packages_to_install) == 0) {
    cat("All required CRAN packages are already installed.\n")
    return()
  }
  for (pkg in packages_to_install) {
    cat("Installing CRAN package:", pkg, "\n")
    tryCatch({
      install.packages(pkg, dependencies = TRUE)
      cat("Successfully installed:", pkg, "\n")
    }, error = function(e) {
      stop("Failed to install CRAN package ", pkg, ": ", e$message)
    })
  }
}

# Function to install GitHub packages
install_github_packages <- function(repo) {
  if (!is_package_installed(basename(repo))) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install_cran_packages("devtools")
      }
      devtools::install_github(repo)
      cat("Successfully installed:", repo, "\n")
    }, error = function(e) {
      stop("Failed to install GitHub package ", repo, ": ", e$message)
    })
  } else {
    cat("Package already installed:", basename(repo), "\n")
  }
}


cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install CRAN Packages ---
# SeuratDisk is needed to read H5AD files.
# hdf5r is a dependency for SeuratDisk.
# reticulate is for Python integration.
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "Seurat",
  "SeuratDisk",
  "hdf5r",
  "reticulate",
  "ggplot2",
  "dplyr"
)
install_cran_packages(cran_packages)


# --- Step 2: Install GitHub Packages ---
# Rmagic is hosted on GitHub.
cat("\nInstalling GitHub packages...\n")
install_github_packages("KrishnaswamyLab/Rmagic")


# --- Step 3: Install Python dependencies ---
# SeuratDisk requires the 'anndata' Python package.
cat("\nInstalling Python packages for reticulate...\n")
tryCatch({
  reticulate::py_install("anndata", pip = TRUE)
  cat("Successfully installed Python package: anndata\n")
}, error = function(e) {
  stop("Failed to install Python package 'anndata': ", e$message)
})


cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
