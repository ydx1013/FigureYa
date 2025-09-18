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
      return(FALSE)
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
  return(TRUE)
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
      return(FALSE)
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
  return(TRUE)
}

# Function to install from GitHub
install_github_package <- function(repo, pkg_name = NULL) {
  if (is.null(pkg_name)) {
    pkg_name <- basename(repo)
  }
  
  if (!is_package_installed(pkg_name)) {
    cat("Installing from GitHub:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed from GitHub:", pkg_name, "\n")
    }, error = function(e) {
      cat("Failed to install from GitHub", repo, ":", e$message, "\n")
      return(FALSE)
    })
  } else {
    cat("Package already installed:", pkg_name, "\n")
  }
  return(TRUE)
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install basic dependencies
cat("\nInstalling basic dependencies...\n")
basic_packages <- c("remotes", "devtools", "ggplot2", "dplyr", "tidyr", "tibble")
for (pkg in basic_packages) {
  install_cran_package(pkg)
}

# Install BiocManager if not present
if (!is_package_installed("BiocManager")) {
  install.packages("BiocManager")
}

# Install CMScaller dependencies first
cat("\nInstalling CMScaller dependencies...\n")
cms_dependencies <- c("limma", "Biobase", "preprocessCore", "genefu", "pamr")
for (pkg in cms_dependencies) {
  install_bioc_package(pkg)
}

# Install CRAN dependencies for CMScaller
cat("\nInstalling additional CRAN dependencies...\n")
cran_deps <- c("cluster", "e1071", "randomForest", "RColorBrewer", "viridis", "ggpubr")
for (pkg in cran_deps) {
  install_cran_package(pkg)
}

# Install CMScaller from GitHub
cat("\nInstalling CMScaller from GitHub...\n")
if (!install_github_package("LotteN/CMScaller", "CMScaller")) {
  # Try alternative installation methods
  cat("Trying alternative installation methods for CMScaller...\n")
  
  # Method 1: Install specific version
  tryCatch({
    remotes::install_github("LotteN/CMScaller@v1.0.0")
    cat("Successfully installed CMScaller specific version\n")
  }, error = function(e) {
    cat("Specific version installation failed:", e$message, "\n")
  })
  
  # Method 2: Install from source
  if (!is_package_installed("CMScaller")) {
    tryCatch({
      install.packages("https://github.com/LotteN/CMScaller/archive/master.tar.gz", 
                      repos = NULL, type = "source")
      cat("Successfully installed CMScaller from source\n")
    }, error = function(e) {
      cat("Source installation failed:", e$message, "\n")
    })
  }
}

# Install other required packages
cat("\nInstalling other required packages...\n")
other_packages <- c("pheatmap", "survival", "survminer", "gridExtra")
for (pkg in other_packages) {
  install_cran_package(pkg)
}

# Verify installation
cat("\n===========================================\n")
cat("Verifying package installation...\n")

required_packages <- c("CMScaller", "pamr", "cluster", "limma", "Biobase")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# Test loading CMScaller
cat("\nTesting CMScaller package...\n")
tryCatch({
  if (is_package_installed("CMScaller")) {
    library(CMScaller)
    cat("✓ CMScaller loaded successfully!\n")
    cat("✓ Package version:", packageVersion("CMScaller"), "\n")
  } else {
    cat("✗ CMScaller not installed\n")
  }
}, error = function(e) {
  cat("✗ Failed to load CMScaller:", e$message, "\n")
})

# If CMScaller installation fails completely, provide detailed instructions
if (!is_package_installed("CMScaller")) {
  cat("\n", strrep("=", 60), "\n", sep = "")
  cat("MANUAL INSTALLATION INSTRUCTIONS FOR CMScaller:\n")
  cat("1. Install system dependencies (Ubuntu/Debian):\n")
  cat("   sudo apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev\n")
  cat("2. Install R dependencies:\n")
  cat("   install.packages(c('remotes', 'devtools'))\n")
  cat("   BiocManager::install(c('limma', 'Biobase', 'preprocessCore', 'genefu'))\n")
  cat("3. Install CMScaller manually:\n")
  cat("   remotes::install_github('LotteN/CMScaller')\n")
  cat("4. If that fails, download and install from source:\n")
  cat("   devtools::install_url('https://github.com/LotteN/CMScaller/archive/master.tar.gz')\n")
  cat(strrep("=", 60), "\n", sep = "")
}


cat("\nPackage installation completed!\n")
cat("You can now run your R scripts in this directory.\n")

# Final test
cat("\nFinal test - loading all critical packages...\n")
critical_packages <- c("CMScaller", "pamr", "cluster")
for (pkg in critical_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat("✓", pkg, "can be loaded\n")
  } else {
    cat("✗", pkg, "cannot be loaded\n")
  }
}
