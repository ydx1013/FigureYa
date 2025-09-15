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

# Function to install from specific source
install_specific_package <- function(package_name, source_type = "cran", url = NULL) {
  if (!is_package_installed(package_name)) {
    cat("Installing", package_name, "from", source_type, "\n")
    tryCatch({
      if (source_type == "cran") {
        install.packages(package_name, dependencies = TRUE)
      } else if (source_type == "bioc") {
        if (!is_package_installed("BiocManager")) {
          install.packages("BiocManager")
        }
        BiocManager::install(package_name, update = FALSE, ask = FALSE)
      } else if (source_type == "github" && !is.null(url)) {
        if (!is_package_installed("remotes")) {
          install.packages("remotes")
        }
        remotes::install_github(url)
      } else if (source_type == "source" && !is.null(url)) {
        install.packages(url, repos = NULL, type = "source")
      }
      cat("Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("Failed to install", package_name, "from", source_type, ":", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# System dependency note for png/jpeg
cat("\nNOTE: ComplexHeatmap requires system libraries.\n")
cat("For Ubuntu/Debian, run this in shell BEFORE using this script:\n")
cat("  sudo apt-get update\n")
cat("  sudo apt-get install libpng-dev libjpeg-dev\n\n")

# Installing ComplexHeatmap dependencies first
cat("\nInstalling ComplexHeatmap dependencies...\n")
heatmap_deps <- c("png", "jpeg")

for (pkg in heatmap_deps) {
  install_cran_package(pkg)
}

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("BART", "RColorBrewer", "compareC", "devtools", "dplyr", "gbm", "ggbreak", "ggplot2", "ggsci", "glmnet", "miscTools", "plsRcox", "randomForestSRC", "rlang", "superpc", "survival", "survivalsvm", "tibble", "tidyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Installing Bioconductor packages
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("ComplexHeatmap", "circlize", "mixOmics", "survcomp")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# Special installation for CoxBoost - try multiple sources
cat("\nInstalling CoxBoost (trying multiple sources)...\n")

# 方法1: 从CRAN安装 (如果可用)
if (!is_package_installed("CoxBoost")) {
  cat("Trying to install CoxBoost from CRAN...\n")
  tryCatch({
    install.packages("CoxBoost")
    cat("Successfully installed CoxBoost from CRAN\n")
  }, error = function(e) {
    cat("CoxBoost not available on CRAN, trying alternative sources...\n")
    
    # 方法2: 从GitHub安装
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_github("binderh/CoxBoost")
      cat("Successfully installed CoxBoost from GitHub\n")
    }, error = function(e2) {
      cat("Failed to install from GitHub, trying archive source...\n")
      
      # 方法3: 从存档源安装
      tryCatch({
        # 尝试从CRAN存档安装
        install.packages("https://cran.r-project.org/src/contrib/Archive/CoxBoost/CoxBoost_1.4.tar.gz", 
                         repos = NULL, type = "source")
        cat("Successfully installed CoxBoost from archive\n")
      }, error = function(e3) {
        cat("All installation methods failed for CoxBoost:\n")
        cat("CRAN:", e$message, "\n")
        cat("GitHub:", e2$message, "\n")
        cat("Archive:", e3$message, "\n")
        cat("Please manually install CoxBoost\n")
      })
    })
  })
} else {
  cat("Package already installed: CoxBoost\n")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")

# Final verification
cat("\nVerifying critical package installation...\n")
critical_packages <- c("CoxBoost", "survival", "glmnet", "randomForestSRC")
for (pkg in critical_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed - may cause script failure\n")
  }
}
