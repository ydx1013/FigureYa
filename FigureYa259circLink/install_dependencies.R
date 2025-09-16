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

# Function to install from GitHub (更新版本，支持build_vignettes参数)
install_github_package <- function(repo, build_vignettes = FALSE) {
  pkg_name <- strsplit(repo, "/")[[1]][2]
  if (!is_package_installed(pkg_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      if (build_vignettes) {
        devtools::install_github(repo, build_vignettes = TRUE)
      } else {
        devtools::install_github(repo)
      }
      cat("Successfully installed:", pkg_name, "\n")
    }, error = function(e) {
      cat("Failed to install", pkg_name, "from GitHub:", e$message, "\n")
    })
  } else {
    cat("Package already installed:", pkg_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("ggplot2", "magrittr", "tidyverse")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 安装GitHub包
cat("\nInstalling GitHub packages...\n")
github_packages <- list(
  crosslink = list(repo = "zzwch/crosslink", build_vignettes = TRUE)
)

for (pkg_name in names(github_packages)) {
  pkg_info <- github_packages[[pkg_name]]
  install_github_package(pkg_info$repo, pkg_info$build_vignettes)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
