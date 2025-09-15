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

# Function to install PMAPscore from GitHub
install_pmapscore <- function() {
  if (!is_package_installed("PMAPscore")) {
    cat("Installing PMAPscore from GitHub...\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github("Jiaxin-Fan/PMAPscore")
      cat("Successfully installed: PMAPscore\n")
    }, error = function(e) {
      cat("Failed to install PMAPscore:", e$message, "\n")
      cat("You may need to install it manually: remotes::install_github('Jiaxin-Fan/PMAPscore')\n")
    })
  } else {
    cat("Package already installed: PMAPscore\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install remotes for GitHub packages
cat("\nInstalling remotes package...\n")
install_cran_package("remotes")

# Install PMAPscore from GitHub
cat("\nInstalling PMAPscore...\n")
install_pmapscore()

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("SPIA", "ComplexHeatmap", "KEGGREST")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Test if key packages can be loaded
cat("\nTesting package availability...\n")
test_packages <- c("SPIA", "PMAPscore", "ComplexHeatmap", "KEGGREST")

for (pkg in test_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat("✅", pkg, "is available\n")
  } else {
    cat("❌", pkg, "is NOT available\n")
  }
}

cat("You can now run your R scripts in this directory.\n")
