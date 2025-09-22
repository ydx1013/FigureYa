#!/usr/bin/env Rscript
# Auto-generated R dependency installation script
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# Function to install Sushi package from archive
install_sushi_package <- function() {
  if (!is_package_installed("Sushi")) {
    cat("Installing Sushi package from Bioconductor archive...\n")
    tryCatch({
      # 下载并安装Sushi包
      sushi_url <- "https://www.bioconductor.org/packages/3.8/bioc/src/contrib/Sushi_1.20.0.tar.gz"
      install.packages(sushi_url, repos = NULL, type = "source")
      cat("Successfully installed: Sushi\n")
    }, error = function(e) {
      cat("Failed to install Sushi:", e$message, "\n")
      cat("Trying alternative installation method...\n")
      # 备用安装方法
      try({
        # 尝试安装旧版本
        install.packages("https://cran.r-project.org/src/contrib/Archive/Sushi/Sushi_1.20.0.tar.gz", 
                        repos = NULL, type = "source")
        cat("Successfully installed: Sushi (via CRAN archive)\n")
      }, silent = TRUE)
    })
  } else {
    cat("Package already installed: Sushi\n")
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# 安装Sushi包
cat("\nInstalling Sushi package...\n")
install_sushi_package()

cat("\n===========================================\n")
cat("Package installation completed!\n")
cat("You can now run your R scripts in this directory.\n")
