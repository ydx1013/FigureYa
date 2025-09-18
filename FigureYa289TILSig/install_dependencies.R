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
install_bioc_package <- function(package_name, version = NULL) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      if (is.null(version)) {
        BiocManager::install(package_name, update = FALSE, ask = FALSE)
      } else {
        BiocManager::install(paste0(package_name, "@", version), update = FALSE, ask = FALSE)
      }
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install package from local source
install_local_package <- function(package_path) {
  cat("Installing package from local source:", package_path, "\n")
  tryCatch({
    install.packages(package_path, repos = NULL, type = "source")
    cat("Successfully installed package from local source\n")
  }, error = function(e) {
    cat("Failed to install from local source:", e$message, "\n")
  })
}

# Function to install remotes package
install_remotes_package <- function() {
  if (!is_package_installed("remotes")) {
    install_cran_package("remotes")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Install remotes first
install_remotes_package()

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("dplyr", "stringr", "survival", "sva", "tibble", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# First install an older version of GEOquery that has gunzip function
cat("\nInstalling older version of GEOquery...\n")
tryCatch({
  if (!is_package_installed("GEOquery")) {
    remotes::install_version("GEOquery", version = "2.58.0")  # Choose an older version
  }
}, error = function(e) {
  cat("Failed to install older GEOquery:", e$message, "\n")
})

# Installing other Bioconductor packages
cat("\nInstalling other Bioconductor packages...\n")
bioc_packages <- c("GenomicFeatures", "limma", "rtracklayer", "affy")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Install DealGPL570 from local source
cat("\nInstalling DealGPL570 from local source...\n")
deal_gpl570_path <- "DealGPL570_0.0.1.tar.gz"  # Local file in current directory

# Check if local file exists
if (file.exists(deal_gpl570_path)) {
  install_local_package(deal_gpl570_path)
} else {
  cat("Local DealGPL570 package not found:", deal_gpl570_path, "\n")
  cat("Please make sure DealGPL570_0.0.1.tar.gz is in the current directory\n")
}

# If DealGPL570 installation fails, provide alternative solutions
if (!is_package_installed("DealGPL570")) {
  cat("\nDealGPL570 installation failed. Trying alternative approaches...\n")
  
  # Alternative 1: Try to install from CRAN archive
  cat("Trying to install from CRAN archive...\n")
  tryCatch({
    install.packages("https://cran.r-project.org/src/contrib/Archive/DealGPL570/DealGPL570_0.0.1.tar.gz", 
                    repos = NULL, type = "source")
  }, error = function(e) {
    cat("CRAN archive installation also failed:", e$message, "\n")
  })
  
  # Alternative 2: Manual data processing approach
  if (!is_package_installed("DealGPL570")) {
    cat("\nManual alternative: You may need to process GPL570 data manually\n")
    cat("or use alternative packages for microarray data processing.\n")
  }
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Final verification
if (is_package_installed("DealGPL570")) {
  cat("✅ DealGPL570 successfully installed!\n")
} else {
  cat("❌ DealGPL570 installation failed\n")
  cat("You may need to manually install it or use alternative methods\n")
}

cat("You can now run your R scripts in this directory.\n")
