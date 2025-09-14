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

# Function to install Bioconductor packages
install_bioc_packages <- function(packages) {
  if (!is_package_installed("BiocManager")) {
    install.packages("BiocManager")
  }
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

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install CRAN Packages ---
# 'kpmt' is a CRAN dependency for 'ChAMP' and must be installed first.
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "data.table", 
  "gplots", 
  "pheatmap",
  "kpmt"  # Explicitly install the missing dependency
)
install_cran_packages(cran_packages)


# --- Step 2: Install Bioconductor Packages ---
# Correctly classify all Bioconductor packages.
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c(
  "ChAMP", 
  "ComplexHeatmap",
  "ClassDiscovery", # This is a Bioconductor package
  "IlluminaHumanMethylation450kanno.ilmn12.hg19" # This is a Bioconductor package
)
install_bioc_packages(bioc_packages)


cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
