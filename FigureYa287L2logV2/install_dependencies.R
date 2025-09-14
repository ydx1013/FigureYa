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
      cat("Warning: Failed to install CRAN package '", package_name, "': ", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install InformationValue (special handling)
install_information_value <- function() {
  if (!is_package_installed("InformationValue")) {
    cat("Installing InformationValue...\n")
    tryCatch({
      # Method 1: Try CRAN installation
      install.packages("InformationValue", dependencies = TRUE)
      cat("Successfully installed: InformationValue\n")
    }, error = function(e) {
      cat("Warning: Failed to install InformationValue from CRAN: ", e$message, "\n")
      
      # Method 2: Try archived version
      tryCatch({
        install.packages("https://cran.r-project.org/src/contrib/Archive/InformationValue/InformationValue_1.2.3.tar.gz", 
                        repos = NULL, type = "source")
        cat("Successfully installed: InformationValue (archived version)\n")
      }, error = function(e2) {
        cat("Error: All installation methods failed for InformationValue: ", e2$message, "\n")
      })
    })
  } else {
    cat("Package already installed: InformationValue\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
# Removed invalid package names: "and", "mean_auc", "mean_roc", "mean_sensity", "mean_specificity"
# These appear to be functions, not packages
cran_packages <- c("ggplot2", "glmnet", "pROC", "rms", "sampling")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Special installation for InformationValue
cat("\nInstalling InformationValue (special package)...\n")
install_information_value()

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
all_packages <- c(cran_packages, "InformationValue")
for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

# Note about the removed "packages"
cat("\nNote: The following were not installed as they are not valid R package names:\n")
cat("- 'and' (this is a logical operator, not a package)\n")
cat("- 'mean_auc' (this appears to be a function, not a package)\n")
cat("- 'mean_roc' (this appears to be a function, not a package)\n")
cat("- 'mean_sensity' (this appears to be a function, not a package)\n")
cat("- 'mean_specificity' (this appears to be a function, not a package)\n")
cat("These are likely functions defined within the R script itself.\n")

cat("You can now run your R scripts in this directory.\n")
