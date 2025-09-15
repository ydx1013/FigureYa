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
      cat("Warning: Failed to install", package_name, ":", e$message, "\n")
      cat("This might be available on Bioconductor instead\n")
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
      cat("Warning: Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install kpmt from GitHub (since it's not on CRAN or Bioconductor)
install_kpmt_from_github <- function() {
  if (!is_package_installed("kpmt")) {
    cat("Installing kpmt from GitHub...\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github("tpq/kpmt")
      cat("Successfully installed kpmt from GitHub\n")
    }, error = function(e) {
      cat("Warning: Failed to install kpmt from GitHub:", e$message, "\n")
      cat("This will cause ChAMP installation to fail\n")
    })
  } else {
    cat("kpmt package already installed\n")
  }
}

# Function to install ChAMP with special handling
install_champ_special <- function() {
  if (!is_package_installed("ChAMP")) {
    cat("Installing ChAMP with special handling...\n")
    
    # First install kpmt (critical dependency)
    install_kpmt_from_github()
    
    # Install other ChAMP dependencies
    cat("Installing ChAMP dependencies...\n")
    champ_dependencies <- c(
      "minfi", "limma", "sva", "impute", "preprocessCore", "DNAcopy", 
      "marray", "qvalue", "IlluminaHumanMethylation450kmanifest",
      "IlluminaHumanMethylation450kanno.ilmn12.hg19"
    )
    
    for (pkg in champ_dependencies) {
      install_bioc_package(pkg)
    }
    
    # Now try to install ChAMP
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      BiocManager::install("ChAMP", update = FALSE, ask = FALSE)
      if (is_package_installed("ChAMP")) {
        cat("Successfully installed ChAMP\n")
      } else {
        cat("ChAMP installation may have failed\n")
      }
    }, error = function(e) {
      cat("Warning: Failed to install ChAMP:", e$message, "\n")
      
      # Try alternative: install from GitHub
      cat("Trying to install ChAMP from GitHub...\n")
      tryCatch({
        if (!is_package_installed("remotes")) {
          install.packages("remotes")
        }
        remotes::install_github("YuanTian1991/ChAMP")
        cat("GitHub installation attempt completed\n")
      }, error = function(e2) {
        cat("GitHub installation also failed:", e2$message, "\n")
      })
    })
  } else {
    cat("ChAMP package already installed\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install BiocManager if not already installed
if (!is_package_installed("BiocManager")) {
  cat("Installing BiocManager...\n")
  install.packages("BiocManager")
}

# Install remotes for GitHub packages
if (!is_package_installed("remotes")) {
  install.packages("remotes")
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("RColorBrewer", "survival", "tidyverse", "remotes")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Special handling for ChAMP and its dependencies
cat("\nInstalling ChAMP and its dependencies...\n")
install_champ_special()

# Install other Bioconductor packages
cat("\nInstalling other Bioconductor packages...\n")
other_bioc_packages <- c("minfi")  # minfi might already be installed as dependency

for (pkg in other_bioc_packages) {
  if (!is_package_installed(pkg)) {
    install_bioc_package(pkg)
  }
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
required_packages <- c("RColorBrewer", "survival", "tidyverse", "minfi", "ChAMP")
all_installed <- TRUE

for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

# Provide troubleshooting advice if ChAMP failed
if (!is_package_installed("ChAMP")) {
  cat("\nChAMP installation failed. Troubleshooting options:\n")
  cat("1. Try installing an older Bioconductor version: BiocManager::install(version = '3.16')\n")
  cat("2. Install system dependencies: sudo apt-get install libcurl4-openssl-dev libxml2-dev\n")
  cat("3. Use alternative methylation packages like minfi directly\n")
}

cat("You can now run your R scripts in this directory.\n")
