#!/usr/bin/env Rscript
# R Package Installation Script for motifbreakR and dependencies
# This script handles the specific dependency chain issues

# Set up repositories
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

# Function to check if package is installed
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# Function to install with error handling
safe_install <- function(install_func, pkg, type = "Bioconductor") {
  cat("Installing", type, "package:", pkg, "\n")
  tryCatch({
    install_func(pkg)
    if (is_installed(pkg)) {
      cat("✓ Successfully installed:", pkg, "\n")
      return(TRUE)
    } else {
      cat("✗ Installation may have failed:", pkg, "\n")
      return(FALSE)
    }
  }, error = function(e) {
    cat("✗ Error installing", pkg, ":", e$message, "\n")
    return(FALSE)
  })
}

# Install BiocManager if not available
if (!is_installed("BiocManager")) {
  install.packages("BiocManager", quiet = TRUE)
}
library(BiocManager)

cat("Starting installation of required packages...\n")
cat("=============================================\n")

# Install system dependencies first
cat("\n1. Installing system dependencies...\n")
system_deps <- c(
  "libcurl4-openssl-dev",
  "libssl-dev",
  "libxml2-dev",
  "zlib1g-dev"
)

# Try to install system dependencies (may require sudo)
try({
  if (Sys.info()["sysname"] == "Linux") {
    cat("Attempting to install system dependencies...\n")
    system(paste("sudo apt-get update && sudo apt-get install -y", 
                paste(system_deps, collapse = " ")))
  }
}, silent = TRUE)

# Install CRAN dependencies
cat("\n2. Installing CRAN dependencies...\n")
cran_packages <- c(
  "devtools",
  "curl",
  "httr",
  "xml2",
  "BiocManager"
)

for (pkg in cran_packages) {
  if (!is_installed(pkg)) {
    install.packages(pkg, quiet = TRUE)
  }
}

# Install Bioconductor packages in correct order
cat("\n3. Installing Bioconductor packages...\n")

# First install basic Bioc dependencies
bioc_base <- c(
  "BiocGenerics",
  "S4Vectors",
  "IRanges",
  "GenomicRanges",
  "Biostrings",
  "rtracklayer",
  "BSgenome"
)

for (pkg in bioc_base) {
  if (!is_installed(pkg)) {
    BiocManager::install(pkg, update = FALSE, ask = FALSE, quiet = TRUE)
  }
}

# Install TFBSTools with specific configuration
cat("\n4. Installing TFBSTools (critical dependency)...\n")
if (!is_installed("TFBSTools")) {
  # Try standard installation first
  success <- safe_install(function(pkg) {
    BiocManager::install("TFBSTools", update = FALSE, ask = FALSE, quiet = TRUE)
  }, "TFBSTools")
  
  # If failed, try alternative approach
  if (!success) {
    cat("Trying alternative installation method for TFBSTools...\n")
    try({
      devtools::install_bioc("TFBSTools", dependencies = TRUE)
    }, silent = TRUE)
  }
}

# Install motifStack
cat("\n5. Installing motifStack...\n")
if (!is_installed("motifStack")) {
  success <- safe_install(function(pkg) {
    BiocManager::install("motifStack", update = FALSE, ask = FALSE, quiet = TRUE)
  }, "motifStack")
  
  if (!success) {
    cat("Trying alternative installation for motifStack...\n")
    try({
      devtools::install_bioc("motifStack", dependencies = TRUE)
    }, silent = TRUE)
  }
}

# Install motifbreakR
cat("\n6. Installing motifbreakR...\n")
if (!is_installed("motifbreakR")) {
  success <- safe_install(function(pkg) {
    BiocManager::install("motifbreakR", update = FALSE, ask = FALSE, quiet = TRUE)
  }, "motifbreakR")
  
  if (!success) {
    cat("Trying alternative installation for motifbreakR...\n")
    try({
      devtools::install_bioc("motifbreakR", dependencies = TRUE)
    }, silent = TRUE)
  }
}

# Install genome data packages
cat("\n7. Installing genome data packages...\n")
genome_packages <- c(
  "BSgenome.Hsapiens.UCSC.hg19",
  "SNPlocs.Hsapiens.dbSNP142.GRCh37"
)

for (pkg in genome_packages) {
  if (!is_installed(pkg)) {
    safe_install(function(pkg) {
      BiocManager::install(pkg, update = FALSE, ask = FALSE, quiet = TRUE)
    }, pkg)
  }
}

# Verify installations
cat("\n8. Verifying installations...\n")
required_packages <- c("TFBSTools", "motifStack", "motifbreakR", 
                      "BSgenome.Hsapiens.UCSC.hg19", "SNPlocs.Hsapiens.dbSNP142.GRCh37")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

cat("\n=============================================\n")
if (all_installed) {
  cat("All required packages installed successfully!\n")
  cat("You can now run your R scripts.\n")
} else {
  cat("Some packages failed to install. You may need to:\n")
  cat("1. Check system dependencies\n")
  cat("2. Try manual installation: BiocManager::install('package_name')\n")
  cat("3. Consult package documentation for specific requirements\n")
}

# Test loading the critical packages
cat("\n9. Testing package loading...\n")
try({
  library(TFBSTools)
  cat("✓ TFBSTools loaded successfully\n")
}, silent = TRUE)

try({
  library(motifStack)
  cat("✓ motifStack loaded successfully\n")
}, silent = TRUE)

try({
  library(motifbreakR)
  cat("✓ motifbreakR loaded successfully\n")
}, silent = TRUE)
