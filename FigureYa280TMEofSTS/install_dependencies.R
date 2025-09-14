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
      cat("Warning: Failed to install Bioconductor package '", package_name, "': ", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install MCPcounter (special case)
install_mcpcounter <- function() {
  if (!is_package_installed("MCPcounter")) {
    cat("Installing MCPcounter (special installation)...\n")
    tryCatch({
      # Method 1: Install from GitHub
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github("ebecht/MCPcounter", ref = "master", subdir = "Source")
      cat("Successfully installed: MCPcounter\n")
    }, error = function(e) {
      cat("Warning: Failed to install MCPcounter from GitHub: ", e$message, "\n")
      
      # Method 2: Alternative installation
      tryCatch({
        install.packages("https://github.com/ebecht/MCPcounter/raw/master/Source/MCPcounter_1.2.0.tar.gz", 
                        repos = NULL, type = "source")
        cat("Successfully installed: MCPcounter (alternative method)\n")
      }, error = function(e2) {
        cat("Error: All installation methods failed for MCPcounter: ", e2$message, "\n")
      })
    })
  } else {
    cat("Package already installed: MCPcounter\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# First install BiocManager if not already installed
if (!is_package_installed("BiocManager")) {
  cat("Installing BiocManager...\n")
  install.packages("BiocManager")
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("ClassDiscovery", "RColorBrewer", "devtools", "gplots", "remotes")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("ComplexHeatmap", "GSVA")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Special installation for MCPcounter
cat("\nInstalling MCPcounter (special package)...\n")
install_mcpcounter()

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
all_packages <- c(cran_packages, bioc_packages, "MCPcounter")
for (pkg in all_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
  }
}

cat("You can now run your R scripts in this directory.\n")
