#!/usr/bin/env Rscript
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

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

# --- Main Installation Logic ---
cat("Starting R package installation...\n")
cat("===========================================\n")

# 1. Install core CRAN packages, including 'remotes' for versioned install
cat("\nInstalling core CRAN packages...\n")
cran_packages <- c(
  "remotes", "data.table", "ggplot2", "ggpubr", 
  "ggsignif", "gtools", "tidyverse"
)
install_cran_packages(cran_packages)


# 2. Install a specific, older version of GEOquery from Bioconductor
# This is required for the archived 'DealGPL570' package to work.
cat("\nInstalling a compatible version of GEOquery...\n")
if (!is_package_installed("GEOquery") || packageVersion("GEOquery") > "2.55") {
  cat("Installing GEOquery v2.54.1 for compatibility...\n")
  # First, ensure BiocManager is available
  if (!is_package_installed("BiocManager")) { install.packages("BiocManager") }
  remotes::install_version("GEOquery", version = "2.54.1")
} else {
  cat("A compatible version of GEOquery is already installed.\n")
}


# 3. Install the archived 'DealGPL570' package from URL
cat("\nInstalling archived DealGPL570 package...\n")
deal_pkg_url <- "https://cran.r-project.org/src/contrib/Archive/DealGPL570/DealGPL570_0.0.1.tar.gz"
deal_pkg_name <- "DealGPL570"
if (!is_package_installed(deal_pkg_name)) {
  cat("Installing DealGPL570 version 0.0.1 from CRAN Archive...\n")
  tryCatch({
    install.packages(deal_pkg_url, repos = NULL, type = "source")
    cat("Successfully installed DealGPL570_0.0.1\n")
  }, error = function(e) {
    stop("Failed to install DealGPL570_0.0.1: ", e$message)
  })
} else {
  cat("Package already installed:", deal_pkg_name, "\n")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
