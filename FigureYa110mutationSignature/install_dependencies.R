#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# Function to install CRAN packages (vectorized)
install_cran_packages <- function(packages) {
  # Filter out already installed packages
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

# Function to install Bioconductor packages (vectorized)
install_bioc_packages <- function(packages) {
  # Check for BiocManager and install if not present
  if (!is_package_installed("BiocManager")) {
    install.packages("BiocManager")
  }
  
  # Filter out already installed packages
  packages_to_install <- packages[!sapply(packages, is_package_installed)]
  
  if (length(packages_to_install) > 0) {
    cat("Installing Bioconductor package(s):", paste(packages_to_install, collapse=", "), "\n")
    tryCatch({
      BiocManager::install(packages_to_install, update = FALSE, ask = FALSE)
      cat("Successfully submitted for installation:", paste(packages_to_install, collapse=", "), "\n")
    }, error = function(e) {
      stop("Failed to install Bioconductor packages: ", e$message)
    })
  } else {
    cat("All required Bioconductor packages are already installed.\n")
  }
}

# Function to install packages from GitHub
install_github_package <- function(repo) {
  pkg_name <- strsplit(repo, "/")[[1]][2]  # Extract package name from "user/repo"
  
  if (!is_package_installed(pkg_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed from GitHub:", pkg_name, "\n")
    }, error = function(e) {
      stop("Failed to install GitHub package ", repo, ": ", e$message)
    })
  } else {
    cat("GitHub package already installed:", pkg_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install Bioconductor Packages FIRST ---
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c(
  "BSgenome", # Dependency for deconstructSigs and BSgenome.Hsapiens.UCSC.hg19
  "BSgenome.Hsapiens.UCSC.hg19",
  "NMF"
)
install_bioc_packages(bioc_packages)

# --- Step 2: Install CRAN Packages ---
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "curl", "httr", "gargle", "googledrive", "googlesheets4", "ragg", "rvest",
  "forcats", "magrittr", "readxl", "stringr", "tidyverse"
)
install_cran_packages(cran_packages)

# --- Step 3: Install GitHub Packages ---
cat("\nInstalling GitHub packages...\n")
github_packages <- c(
  "raerose01/deconstructSigs"  # deconstructSigs is only available on GitHub
)
for (repo in github_packages) {
  install_github_package(repo)
}

# --- Step 4: 验证安装 ---
cat("\nVerifying package installation...\n")
all_packages <- c(bioc_packages, cran_packages, "deconstructSigs")

for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "FAILED to install\n")
  }
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
