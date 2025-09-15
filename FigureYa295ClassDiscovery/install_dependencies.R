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

# Function to install classpredict from URL
install_classpredict <- function() {
  if (!is_package_installed("classpredict")) {
    cat("Installing classpredict package from URL...\n")
    
    # Check if devtools is installed
    if (!is_package_installed("devtools")) {
      cat("Installing devtools first...\n")
      install.packages("devtools")
    }
    
    # Install classpredict from URL
    tryCatch({
      devtools::install_url("https://brb.nci.nih.gov/BRB-ArrayTools/RPackagesAndManuals/classpredict_0.2.tar.gz")
      cat("Successfully installed: classpredict\n")
      return(TRUE)
    }, error = function(e) {
      cat("Failed to install classpredict:", e$message, "\n")
      
      # Fallback: try alternative installation method
      cat("Trying alternative installation method...\n")
      tryCatch({
        # Download the package file
        temp_file <- tempfile(fileext = ".tar.gz")
        download.file("https://brb.nci.nih.gov/BRB-ArrayTools/RPackagesAndManuals/classpredict_0.2.tar.gz", 
                      temp_file, quiet = TRUE)
        
        # Install from local file
        install.packages(temp_file, repos = NULL, type = "source")
        cat("Successfully installed: classpredict (alternative method)\n")
        return(TRUE)
      }, error = function(e2) {
        cat("Alternative installation also failed:", e2$message, "\n")
        return(FALSE)
      })
    })
  } else {
    cat("Package already installed: classpredict\n")
    return(TRUE)
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("ape", "cluster", "phangorn", "reshape2", "plyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("ComplexHeatmap", "ConsensusClusterPlus", "limma")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Install classpredict from URL
cat("\nInstalling classpredict package...\n")
classpredict_success <- install_classpredict()

cat("\n===========================================\n")
if (classpredict_success) {
  cat("✅ All packages installed successfully!\n")
  cat("You can now run your R scripts in this directory.\n")
} else {
  cat("⚠️  Package installation completed with warnings.\n")
  cat("classpredict package may not be available.\n")
  cat("You may need to manually install it or use a Windows system.\n")
}

# Test if classpredict can be loaded
cat("\nTesting classpredict package...\n")
if (require("classpredict", quietly = TRUE)) {
  cat("✅ classpredict package loaded successfully!\n")
} else {
  cat("❌ classpredict package could not be loaded.\n")
  cat("Please check the installation and try again.\n")
}
