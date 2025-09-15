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

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("Seurat", "ggplot2", "ggpubr", "magrittr", "patchwork", "remotes")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Install SeuratData from GitHub
cat("\nInstalling SeuratData from GitHub...\n")
if (!is_package_installed("SeuratData")) {
  tryCatch({
    remotes::install_github("satijalab/seurat-data")
    cat("Successfully installed: SeuratData\n")
  }, error = function(e) {
    cat("Failed to install SeuratData:", e$message, "\n")
    cat("You may need to install it manually with: remotes::install_github('satijalab/seurat-data')\n")
  })
} else {
  cat("Package already installed: SeuratData\n")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
