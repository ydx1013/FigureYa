#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

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
      # Stop execution if a critical package fails
      stop("Halting due to failed installation.")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install Bioconductor packages
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package(s):", paste(package_name, collapse=", "), "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      BiocManager::install(package_name, update = FALSE, ask = FALSE)
      cat("Successfully submitted for installation:", paste(package_name, collapse=", "), "\n")
    }, error = function(e) {
      cat("Failed to install Bioconductor packages:", e$message, "\n")
      # Stop execution if a critical package fails
      stop("Halting due to failed installation.")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install Bioconductor Packages FIRST ---
# These are either from Bioconductor directly or are dependencies for CRAN packages.
# This is the most important step to fix the error.
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c(
  "ClassDiscovery", # From a previous error
  "impute",         # WGCNA dependency
  "preprocessCore", # WGCNA dependency
  "GO.db",          # WGCNA dependency
  "AnnotationDbi"   # WGCNA dependency
)
install_bioc_package(bioc_packages)


# --- Step 2: Install CRAN Packages ---
# These packages can now be installed because their Bioconductor dependencies are met.
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "WGCNA", 
  "gplots", 
  "pheatmap"
)

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
