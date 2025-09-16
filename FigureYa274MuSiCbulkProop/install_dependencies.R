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

# Function to install SeuratData
install_seurat_data <- function() {
  if (!is_package_installed("SeuratData")) {
    cat("Installing SeuratData package...\n")
    tryCatch({
      # 先安装remotes包（如果还没安装）
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      # 从Satija Lab的安装源安装SeuratData
      remotes::install_github("satijalab/seurat-data")
      cat("Successfully installed: SeuratData\n")
    }, error = function(e) {
      cat("Failed to install SeuratData:", e$message, "\n")
    })
  } else {
    cat("Package already installed: SeuratData\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

cat("\nInstalling important CRAN dependency packages first...\n")
cran_dep_packages <- c(
  "curl", "httr", "httr2", "png", "xml2", "rvest", "remotes"
)
for (pkg in cran_dep_packages) {
  install_cran_package(pkg)
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("Seurat", "devtools", "dplyr", "magrittr", "patchwork", "pheatmap")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 特殊安装SeuratData
cat("\nInstalling SeuratData package...\n")
install_seurat_data()

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("Biobase", "MuSiC", "SingleCellExperiment", "glmGamPoi")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# 检查并安装MuSiC（如果Bioconductor安装失败）
if (!is_package_installed("MuSiC")) {
  cat("\nMuSiC not found, trying to install from GitHub...\n")
  tryCatch({
    if (!is_package_installed("devtools")) {
      install.packages("devtools")
    }
    devtools::install_github("xuranw/MuSiC")
    cat("Successfully installed MuSiC from GitHub\n")
  }, error = function(e) {
    cat("Failed to install MuSiC from GitHub:", e$message, "\n")
  })
} else {
  cat("Package already installed: MuSiC\n")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
