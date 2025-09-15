#!/usr/bin/env Rscript
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

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
      cat("Failed to install CRAN package", pkg, ":", e$message, "\n")
    })
  }
}

# Function to install GitHub packages with better error handling
install_github_packages <- function(repo) {
  pkg_name <- basename(repo)
  if (!is_package_installed(pkg_name)) {
    cat("Installing GitHub package:", repo, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install_cran_packages("remotes")
      }
      remotes::install_github(repo)
      cat("Successfully installed:", repo, "\n")
    }, error = function(e) {
      cat("Failed to install GitHub package", repo, ":", e$message, "\n")
      cat("Trying alternative installation method...\n")
      
      # Alternative: try to install from specific commit or branch
      tryCatch({
        remotes::install_github(paste0(repo, "@master"))
        cat("Successfully installed from master branch:", repo, "\n")
      }, error = function(e2) {
        cat("Alternative installation also failed:", e2$message, "\n")
        cat("You may need to install manually or check system dependencies.\n")
      })
    })
  } else {
    cat("Package already installed:", pkg_name, "\n")
  }
}

# Function to check and handle hdf5r dependencies
install_hdf5r_with_deps <- function() {
  if (!is_package_installed("hdf5r")) {
    cat("Installing hdf5r with special handling...\n")
    
    # Check system and provide guidance
    if (.Platform$OS.type == "unix") {
      cat("On Unix systems, hdf5r requires HDF5 library.\n")
      cat("You may need to install system dependencies:\n")
      cat("  Ubuntu/Debian: sudo apt-get install libhdf5-dev\n")
      cat("  CentOS/RHEL: sudo yum install hdf5-devel\n")
      cat("  macOS (Homebrew): brew install hdf5\n")
    }
    
    tryCatch({
      install.packages("hdf5r", dependencies = TRUE)
      cat("Successfully installed: hdf5r\n")
    }, error = function(e) {
      cat("Failed to install hdf5r:", e$message, "\n")
      cat("You may need to install system-level HDF5 library first.\n")
    })
  } else {
    cat("Package already installed: hdf5r\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install basic dependencies ---
cat("\nInstalling basic CRAN packages...\n")
basic_packages <- c(
  "ggplot2",
  "dplyr",
  "remotes",
  "reticulate"
)
install_cran_packages(basic_packages)

# --- Step 2: Install hdf5r with special handling ---
cat("\nInstalling hdf5r...\n")
install_hdf5r_with_deps()

# --- Step 3: Install other CRAN packages ---
cat("\nInstalling other CRAN packages...\n")
other_cran_packages <- c(
  "Seurat",
  "SeuratDisk"
)
install_cran_packages(other_cran_packages)

# --- Step 4: Install Rmagic from GitHub ---
cat("\nInstalling Rmagic from GitHub...\n")
install_github_packages("KrishnaswamyLab/Rmagic")

# --- Step 5: Install Python dependencies ---
cat("\nInstalling Python packages for reticulate...\n")
tryCatch({
  # First check if Python is available
  if (!reticulate::py_available()) {
    reticulate::install_python()
  }
  
  # Install Python packages
  reticulate::py_install("anndata", pip = TRUE)
  reticulate::py_install("magic-impute", pip = TRUE)
  cat("Successfully installed Python packages: anndata, magic-impute\n")
}, error = function(e) {
  cat("Failed to install Python packages:", e$message, "\n")
  cat("You can install them manually with: pip install anndata magic-impute\n")
})

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Final check
cat("\nFinal package availability check:\n")
required_packages <- c("Seurat", "SeuratDisk", "hdf5r", "reticulate", "ggplot2", "dplyr")

for (pkg in required_packages) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat("✅", pkg, "is available\n")
  } else {
    cat("❌", pkg, "is NOT available\n")
  }
}

# Check if Rmagic is available
if (requireNamespace("Rmagic", quietly = TRUE)) {
  cat("✅ Rmagic is available\n")
} else {
  cat("❌ Rmagic is NOT available\n")
  cat("You may need to install it manually:\n")
  cat("remotes::install_github('KrishnaswamyLab/Rmagic')\n")
}

cat("\nYou can now run your R scripts in this directory.\n")
