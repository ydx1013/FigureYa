#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options(BioC_mirror = "http://mirrors.tuna.tsinghua.edu.cn/bioconductor/")

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

cat("Starting R package installation...\n")
cat("===========================================\n")


# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("ALKBH5", "BLCA", "BRCA", "CESC", "CHOL", "COAD", "ClassDiscovery", "ESCA", "FTO", "GBM", "HNRNPA2B1", "HNRNPC", "HNSC", "IGF2BP1", "IGF2BP2", "IGF2BP3", "KIAA1429", "KICH", "KIRC", "KIRP", "LIHC", "LUAD", "LUSC", "METTL14", "METTL3", "PAAD", "PRAD", "RBM15", "RBM15B", "RBMX", "READ", "STAD", "THCA", "UCEC", "WTAP", "YTHDC1", "YTHDC2", "YTHDF1", "YTHDF2", "YTHDF3", "ZC3H13", "data.table", "white")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("ComplexHeatmap", "impute")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
