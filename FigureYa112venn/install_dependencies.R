#!/usr/bin/env Rscript
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

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install CRAN Packages ---
# 'devtools' is needed to install packages from GitHub.
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "Cairo", "RColorBrewer", "VennDiagram", 
  "dplyr", "ggplot2", "grDevices", "magrittr", "purrr", "readr", 
  "stringr", "tibble", "tidyr",
  "devtools" # Add devtools
)
install_cran_packages(cran_packages)


# --- Step 2: Install GitHub packages ---
# 'colorfulVennPlot' is hosted on GitHub, not CRAN.
cat("\nInstalling GitHub packages...\n")
if (!is_package_installed("colorfulVennPlot")) {
  cat("Installing colorfulVennPlot from GitHub...\n")
  tryCatch({
    devtools::install_github("yanlinlin82/colorfulVennPlot")
    cat("Successfully installed colorfulVennPlot from GitHub\n")
  }, error = function(e) {
    stop("Failed to install colorfulVennPlot from GitHub: ", e$message)
  })
} else {
  cat("Package already installed: colorfulVennPlot\n")
}


cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
