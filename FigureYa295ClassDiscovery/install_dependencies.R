#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs required R packages including classpredict

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
      install.packages(package_name, dependencies = TRUE, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

# Function to install Bioconductor packages
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("Installing Bioconductor package:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager", quiet = TRUE)
      }
      BiocManager::install(package_name, update = FALSE, ask = FALSE, quiet = TRUE)
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

# Function to install classpredict from URL
install_classpredict <- function() {
  if (!is_package_installed("classpredict")) {
    cat("Installing classpredict package from URL...\n")
    
    # Check if devtools is installed
    if (!is_package_installed("devtools")) {
      cat("Installing devtools first...\n")
      install_cran_package("devtools")
    }
    
    # Install classpredict from URL using devtools
    tryCatch({
      devtools::install_url("https://brb.nci.nih.gov/BRB-ArrayTools/RPackagesAndManuals/classpredict_0.2.tar.gz")
      cat("✓ Successfully installed: classpredict\n")
      return(TRUE)
    }, error = function(e) {
      cat("✗ Failed to install classpredict:", e$message, "\n")
      return(FALSE)
    })
  } else {
    cat("✓ Package already installed: classpredict\n")
    return(TRUE)
  }
}

cat("Starting package installation...\n")
cat("===========================================\n")

# 1. 安装CRAN包
cat("\n1. Installing CRAN packages...\n")
cran_packages <- c("cluster", "phangorn", "ape", "reshape2", "devtools")
for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 2. 安装Bioconductor包
cat("\n2. Installing Bioconductor packages...\n")
bioc_packages <- c("ComplexHeatmap", "limma")
for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# 3. 安装classpredict
cat("\n3. Installing classpredict from URL...\n")
classpredict_success <- install_classpredict()

# 验证安装
cat("\n4. Verifying installation...\n")
required_packages <- c("cluster", "phangorn", "ape", "reshape2", "ComplexHeatmap", "limma", "classpredict")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

# 测试包加载
cat("\n5. Testing package loading...\n")
test_packages <- function() {
  tryCatch({
    library(cluster)
    cat("✓ cluster package loaded successfully\n")
  }, error = function(e) {
    cat("✗ cluster loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(phangorn)
    cat("✓ phangorn package loaded successfully\n")
  }, error = function(e) {
    cat("✗ phangorn loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(ape)
    cat("✓ ape package loaded successfully\n")
  }, error = function(e) {
    cat("✗ ape loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(reshape2)
    cat("✓ reshape2 package loaded successfully\n")
  }, error = function(e) {
    cat("✗ reshape2 loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(ComplexHeatmap)
    cat("✓ ComplexHeatmap package loaded successfully\n")
  }, error = function(e) {
    cat("✗ ComplexHeatmap loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(limma)
    cat("✓ limma package loaded successfully\n")
  }, error = function(e) {
    cat("✗ limma loading failed:", e$message, "\n")
  })
  
  tryCatch({
    library(classpredict)
    cat("✓ classpredict package loaded successfully\n")
  }, error = function(e) {
    cat("✗ classpredict loading failed:", e$message, "\n")
  })
}

cat("\nInstallation completed!\n")
