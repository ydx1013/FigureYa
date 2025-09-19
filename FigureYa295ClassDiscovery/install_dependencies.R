#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs classpredict package from URL

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

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

cat("Starting classpredict package installation...\n")
cat("===========================================\n")

# 首先安装devtools
cat("\n1. Installing devtools...\n")
install_cran_package("devtools")

# 安装classpredict
cat("\n2. Installing classpredict from URL...\n")
classpredict_success <- install_classpredict()

# 验证安装
cat("\n3. Verifying installation...\n")
if (is_package_installed("classpredict")) {
  cat("✓ classpredict is installed\n")
} else {
  cat("✗ classpredict is NOT installed\n")
}

# 测试包加载
cat("\n4. Testing package loading...\n")
tryCatch({
  library(classpredict)
  cat("✓ classpredict package loaded successfully\n")
  
  # 检查主要函数是否存在
  if (exists("classpredict") || exists("predict.class")) {
    cat("✓ Main functions are available\n")
  }
}, error = function(e) {
  cat("✗ classpredict loading failed:", e$message, "\n")
})

cat("\n===========================================\n")
if (classpredict_success) {
  cat("✅ classpredict package installed successfully!\n")
  cat("You can now use classpredict in your R scripts:\n")
  cat("library(classpredict)\n")
} else {
  cat("⚠️  classpredict installation failed. You may need to:\n")
  cat("1. Check your internet connection\n")
  cat("2. Try manual installation:\n")
  cat("   devtools::install_url(\"https://brb.nci.nih.gov/BRB-ArrayTools/RPackagesAndManuals/classpredict_0.2.tar.gz\")\n")
  cat("3. Download the package file and install from local file\n")
}

cat("\nInstallation completed!\n")
