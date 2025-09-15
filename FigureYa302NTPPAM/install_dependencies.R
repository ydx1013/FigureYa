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
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install CMScaller from GitHub
install_cmscaller <- function() {
  if (!is_package_installed("CMScaller")) {
    cat("Installing CMScaller from GitHub...\n")
    tryCatch({
      # First install remotes if not available
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      # Install CMScaller from GitHub
      remotes::install_github("LotteN/CMScaller")
      cat("Successfully installed: CMScaller\n")
    }, error = function(e) {
      cat("Failed to install CMScaller:", e$message, "\n")
      cat("You may need to install it manually with: remotes::install_github('LotteN/CMScaller')\n")
    })
  } else {
    cat("Package already installed: CMScaller\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("cluster", "remotes")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Install CMScaller from GitHub
cat("\nInstalling CMScaller...\n")
install_cmscaller()

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("pamr")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")

# Test if CMScaller can be loaded
cat("\nTesting CMScaller package...\n")
if (require("CMScaller", quietly = TRUE)) {
  cat("✅ CMScaller package loaded successfully!\n")
} else {
  cat("❌ CMScaller package could not be loaded.\n")
  cat("You may need to install it manually:\n")
  cat("remotes::install_github('LotteN/CMScaller')\n")
}
