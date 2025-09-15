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

# Function to install package from source
install_source_package <- function(package_url) {
  cat("Installing package from source:", package_url, "\n")
  tryCatch({
    install.packages(package_url, repos = NULL, type = "source")
    cat("Successfully installed package from source\n")
  }, error = function(e) {
    cat("Failed to install from source:", e$message, "\n")
  })
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("dplyr", "stringr", "survival", "sva", "tibble", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages (including DealGPL570 dependencies first)
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("GenomicFeatures", "limma", "rtracklayer", "GEOquery", "affy")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Install DealGPL570 from source after its dependencies are installed
cat("\nInstalling DealGPL570 from source...\n")
deal_gpl570_url <- "https://cran.r-project.org/src/contrib/Archive/DealGPL570/DealGPL570_0.0.1.tar.gz"
install_source_package(deal_gpl570_url)

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
