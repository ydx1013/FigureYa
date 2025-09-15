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

# Function to install ggord from GitHub
install_ggord <- function() {
  if (!is_package_installed("ggord")) {
    cat("Installing ggord from GitHub...\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github("fawda123/ggord")
      cat("Successfully installed: ggord\n")
    }, error = function(e) {
      cat("Failed to install ggord:", e$message, "\n")
      cat("You may need to install it manually: devtools::install_github('fawda123/ggord')\n")
    })
  } else {
    cat("Package already installed: ggord\n")
  }
}

# Function to install yyplot from GitHub (如果也需要的话)
install_yyplot <- function() {
  if (!is_package_installed("yyplot")) {
    cat("Installing yyplot from GitHub...\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github("GuangchuangYu/yyplot")
      cat("Successfully installed: yyplot\n")
    }, error = function(e) {
      cat("Failed to install yyplot:", e$message, "\n")
      cat("You may need to install it manually: devtools::install_github('GuangchuangYu/yyplot')\n")
    })
  } else {
    cat("Package already installed: yyplot\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install devtools for GitHub packages
cat("\nInstalling devtools package...\n")
install_cran_package("devtools")

# Install ggord from GitHub
cat("\nInstalling ggord...\n")
install_ggord()

# Install yyplot from GitHub (如果也需要)
cat("\nInstalling yyplot...\n")
install_yyplot()

# Installing other CRAN packages
cat("\nInstalling other CRAN packages...\n")
cran_packages <- c("dplyr", "ggplot2", "plyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Test if ggord can be loaded
cat("\nTesting ggord package...\n")
if (require("ggord", quietly = TRUE)) {
  cat("✅ ggord package loaded successfully!\n")
} else {
  cat("❌ ggord package could not be loaded.\n")
  cat("You may need to install it manually:\n")
  cat("devtools::install_github('fawda123/ggord')\n")
}

cat("You can now run your R scripts in this directory.\n")
