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
      cat("Warning: Failed to install CRAN package", pkg, ":", e$message, "\n")
      cat("Will continue with other packages...\n")
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
      BiocManager::install(packages_to_install, update = TRUE, ask = FALSE)
      cat("Successfully installed:", paste(packages_to_install, collapse=", "), "\n")
    }, error = function(e) {
      cat("Warning: Failed to install Bioconductor packages:", e$message, "\n")
      cat("Will continue with other packages...\n")
    })
  } else {
    cat("All required Bioconductor packages are already installed.\n")
  }
}

# Function to install specific problematic packages with custom handling
install_problematic_packages <- function() {
  # Special handling for ChAMP which has complex dependencies
  if (!is_package_installed("ChAMP")) {
    cat("\nAttempting to install ChAMP with special handling...\n")
    
    # First install Bioconductor dependencies
    bioc_deps <- c("minfi", "limma", "sva", "impute", "preprocessCore", "DNAcopy", 
                  "marray", "qvalue", "IlluminaHumanMethylation450kmanifest",
                  "IlluminaHumanMethylation450kanno.ilmn12.hg19")
    install_bioc_packages(bioc_deps)
    
    # Install CRAN dependencies
    cran_deps <- c("doParallel", "foreach", "parallel", "ggplot2", "reshape2",
                  "RColorBrewer", "gridExtra", "genefilter", "pamr", "cluster",
                  "som", "igraph", "scales", "plyr", "samr")
    install_cran_packages(cran_deps)
    
    # Now try to install ChAMP
    tryCatch({
      BiocManager::install("ChAMP", update = TRUE, ask = FALSE)
      if (is_package_installed("ChAMP")) {
        cat("Successfully installed ChAMP\n")
      } else {
        cat("Warning: ChAMP installation may have failed\n")
      }
    }, error = function(e) {
      cat("Warning: Failed to install ChAMP:", e$message, "\n")
    })
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install CRAN Packages ---
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "data.table", 
  "gplots", 
  "pheatmap",
  "magick",
  "doParallel",
  "foreach",
  "ggplot2",
  "reshape2",
  "RColorBrewer"
)
install_cran_packages(cran_packages)

# --- Step 2: Install Bioconductor Packages ---
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c(
  "ComplexHeatmap",
  "ClassDiscovery",
  "IlluminaHumanMethylation450kanno.ilmn12.hg19",
  "IlluminaHumanMethylation450kmanifest",
  "minfi",
  "limma",
  "sva",
  "impute"
)
install_bioc_packages(bioc_packages)

# --- Step 3: Special handling for problematic packages ---
install_problematic_packages()

# --- Step 4: Verify ChAMP installation ---
cat("\nVerifying ChAMP installation...\n")
if (is_package_installed("ChAMP")) {
  cat("✓ ChAMP package is installed\n")
  
  # Try to load the package to check for runtime dependencies
  tryCatch({
    library(ChAMP)
    cat("✓ ChAMP package loads successfully\n")
  }, error = function(e) {
    cat("Warning: ChAMP installed but has loading issues:", e$message, "\n")
    cat("This might be due to missing system dependencies or version conflicts\n")
  })
} else {
  cat("Warning: ChAMP package installation failed\n")
  cat("You may need to manually install it or use an alternative approach\n")
  
  # Alternative: try installing from GitHub if Bioconductor fails
  cat("Attempting alternative installation from GitHub...\n")
  if (!is_package_installed("remotes")) {
    install.packages("remotes")
  }
  tryCatch({
    remotes::install_github("YuanTian1991/ChAMP")
    cat("GitHub installation attempt completed\n")
  }, error = function(e) {
    cat("GitHub installation also failed:", e$message, "\n")
  })
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Provide troubleshooting advice
cat("\nTroubleshooting tips for ChAMP:\n")
cat("1. If ChAMP still fails, check system dependencies: libcurl, libxml2\n")
cat("2. Try: sudo apt-get install libcurl4-openssl-dev libxml2-dev (on Ubuntu)\n")
cat("3. Or try: brew install libcurl libxml2 (on macOS)\n")
cat("4. Restart R session and try loading ChAMP again\n")

cat("You can now run your R scripts in this directory.\n")
