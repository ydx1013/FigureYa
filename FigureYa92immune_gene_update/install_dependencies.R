#!/usr/bin/env Rscript
# R Package Installation Script for ggstatsplot and dependencies
# Special handling for PMCMRplus which is not on CRAN

# Set up repositories
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if package is installed
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# Function to install with error handling
safe_install <- function(install_func, pkg, type = "CRAN") {
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

cat("Starting installation of required packages...\n")
cat("=============================================\n")

# Install remotes for GitHub installations
if (!is_installed("remotes")) {
  install.packages("remotes", quiet = TRUE)
}

# Install system dependencies first (for PMCMRplus)
cat("\n1. Installing system dependencies...\n")
try({
  if (Sys.info()["sysname"] == "Linux") {
    system_deps <- c(
      "gfortran",
      "g++",
      "libblas-dev",
      "liblapack-dev"
    )
    system(paste("sudo apt-get update && sudo apt-get install -y", 
                paste(system_deps, collapse = " ")))
  }
}, silent = TRUE)

# Install basic dependencies
cat("\n2. Installing basic dependencies...\n")
basic_packages <- c(
  "dplyr",
  "ggplot2",
  "tidyr",
  "purrr",
  "rlang",
  "vctrs",
  "Matrix"
)

for (pkg in basic_packages) {
  if (!is_installed(pkg)) {
    install.packages(pkg, quiet = TRUE)
  }
}

# Install PMCMRplus from GitHub (the problematic dependency)
cat("\n3. Installing PMCMRplus from GitHub...\n")
if (!is_installed("PMCMRplus")) {
  tryCatch({
    # Try installing from GitHub mirror
    remotes::install_github("cran/PMCMRplus", dependencies = TRUE)
    cat("✓ PMCMRplus installed from GitHub\n")
  }, error = function(e) {
    cat("Failed to install PMCMRplus from GitHub:", e$message, "\n")
    
    # Alternative: install from source
    cat("Trying alternative installation method...\n")
    try({
      # Download and install from source
      temp_file <- tempfile(fileext = ".tar.gz")
      download.file("https://cran.r-project.org/src/contrib/Archive/PMCMRplus/PMCMRplus_1.9.0.tar.gz", 
                   temp_file, quiet = TRUE)
      install.packages(temp_file, repos = NULL, type = "source")
      unlink(temp_file)
    }, silent = TRUE)
  })
}

# Install statsExpressions dependencies first
cat("\n4. Installing statsExpressions dependencies...\n")
statsExpressions_deps <- c(
  "correlation",
  "parameters",
  "effectsize",
  "insight",
  "bayestestR",
  "performance"
)

for (pkg in statsExpressions_deps) {
  if (!is_installed(pkg)) {
    install.packages(pkg, quiet = TRUE)
  }
}

# Install statsExpressions
cat("\n5. Installing statsExpressions...\n")
if (!is_installed("statsExpressions")) {
  safe_install(function(pkg) install.packages(pkg), "statsExpressions")
  
  # If failed, try from GitHub
  if (!is_installed("statsExpressions")) {
    cat("Trying to install statsExpressions from GitHub...\n")
    try({
      remotes::install_github("indrajeetpatil/statsExpressions")
    }, silent = TRUE)
  }
}

# Install ggstatsplot dependencies
cat("\n6. Installing ggstatsplot dependencies...\n")
ggstatsplot_deps <- c(
  "ggcorrplot",
  "ggsignif",
  "ggside",
  "ggExtra",
  "patchwork",
  "rcompanion"
)

for (pkg in ggstatsplot_deps) {
  if (!is_installed(pkg)) {
    install.packages(pkg, quiet = TRUE)
  }
}

# Install ggstatsplot
cat("\n7. Installing ggstatsplot...\n")
if (!is_installed("ggstatsplot")) {
  safe_install(function(pkg) install.packages(pkg), "ggstatsplot")
  
  # If failed, try from GitHub
  if (!is_installed("ggstatsplot")) {
    cat("Trying to install ggstatsplot from GitHub...\n")
    try({
      remotes::install_github("indrajeetpatil/ggstatsplot")
    }, silent = TRUE)
  }
}

# Install additional packages that might be needed
cat("\n8. Installing additional utility packages...\n")
utility_packages <- c(
  "data.table",
  "readr",
  "stringr",
  "forcats",
  "scales"
)

for (pkg in utility_packages) {
  if (!is_installed(pkg)) {
    install.packages(pkg, quiet = TRUE)
  }
}

# Verify installations
cat("\n9. Verifying installations...\n")
required_packages <- c("PMCMRplus", "statsExpressions", "ggstatsplot")

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
  cat("1. Install system dependencies manually\n")
  cat("2. Try manual installation from GitHub\n")
  cat("3. Use alternative packages if available\n")
}

# Test loading the critical packages
cat("\n10. Testing package loading...\n")
try({
  library(PMCMRplus)
  cat("✓ PMCMRplus loaded successfully\n")
}, silent = TRUE)

try({
  library(statsExpressions)
  cat("✓ statsExpressions loaded successfully\n")
}, silent = TRUE)

try({
  library(ggstatsplot)
  cat("✓ ggstatsplot loaded successfully\n")
}, silent = TRUE)

# Provide alternative if PMCMRplus fails
if (!is_installed("PMCMRplus")) {
  cat("\nNote: PMCMRplus installation failed.\n")
  cat("You might want to try installing it manually:\n")
  cat("remotes::install_github('cran/PMCMRplus')\n")
  cat("Or use alternative non-parametric test functions\n")
}
