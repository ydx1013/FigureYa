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
      cat("Warning: Failed to install CRAN package '", package_name, "': ", e$message, "\n")
    })
  } else {
    cat("Package already installed:", package_name, "\n")
  }
}

# Function to install packages from GitHub
install_github_package <- function(repo, max_retries = 3) {
  pkg_name <- basename(repo)
  if (!is_package_installed(pkg_name)) {
    cat("Installing GitHub package:", repo, "\n")
    
    for (attempt in 1:max_retries) {
      success <- FALSE
      tryCatch({
        if (!is_package_installed("remotes")) {
          install.packages("remotes")
        }
        remotes::install_github(repo)
        cat("Successfully installed:", pkg_name, "\n")
        success <- TRUE
        return(TRUE)
      }, error = function(e) {
        cat("Attempt", attempt, "failed:", e$message, "\n")
        
        # 如果是GitHub API限制错误，等待后重试
        if (grepl("403", e$message) || grepl("Rate limit", e$message) || grepl("GitHub", e$message)) {
          wait_time <- attempt * 30  # 递增等待时间
          cat("GitHub API limit reached. Waiting", wait_time, "seconds before retry...\n")
          Sys.sleep(wait_time)
        }
        
        # 如果是最后一次尝试仍然失败
        if (attempt == max_retries) {
          cat("Warning: Failed to install GitHub package '", repo, "' after", max_retries, "attempts: ", e$message, "\n")
          return(FALSE)
        }
      })
      
      if (success) break
    }
  } else {
    cat("Package already installed:", pkg_name, "\n")
    return(TRUE)
  }
}

# Function to install cgdsr with alternative methods
install_cgdsr <- function() {
  if (!is_package_installed("cgdsr")) {
    cat("Attempting to install cgdsr package...\n")
    
    # 方法1: 从GitHub安装（主要方法）
    success <- FALSE
    tryCatch({
      success <- install_github_package("cBioPortal/cgdsr")
    }, error = function(e) {
      cat("GitHub installation attempt failed:", e$message, "\n")
    })
    
    if (!success) {
      # 方法2: 尝试从CRAN安装旧版本（如果可用）
      cat("Trying alternative installation methods for cgdsr...\n")
      tryCatch({
        # 检查是否有可用的CRAN版本
        install.packages("cgdsr")
        if (is_package_installed("cgdsr")) {
          cat("Successfully installed cgdsr from CRAN\n")
          return(TRUE)
        }
      }, error = function(e) {
        cat("CRAN installation also failed:", e$message, "\n")
      })
      
      # 方法3: 尝试安装开发版本
      cat("Trying development version of cgdsr...\n")
      tryCatch({
        if (!is_package_installed("remotes")) {
          install.packages("remotes")
        }
        remotes::install_github("cBioPortal/cgdsr@develop")
        if (is_package_installed("cgdsr")) {
          cat("Successfully installed development version of cgdsr\n")
          return(TRUE)
        }
      }, error = function(e) {
        cat("Development version installation failed:", e$message, "\n")
      })
      
      # 方法4: 手动下载安装
      cat("Trying manual download and installation...\n")
      tryCatch({
        # 下载源代码
        temp_file <- tempfile(fileext = ".zip")
        download.file("https://github.com/cBioPortal/cgdsr/archive/master.zip", 
                     temp_file)
        # 安装
        install.packages(temp_file, repos = NULL, type = "source")
        # 清理
        file.remove(temp_file)
        
        if (is_package_installed("cgdsr")) {
          cat("Successfully installed cgdsr from manual download\n")
          return(TRUE)
        }
      }, error = function(e) {
        cat("Manual installation failed:", e$message, "\n")
      })
    }
    
    return(is_package_installed("cgdsr"))
  } else {
    cat("cgdsr package already installed\n")
    return(TRUE)
  }
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# Installing CRAN packages
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("remotes", "ggplot2", "readxl", "reshape2")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# Special handling for cgdsr
cat("\nInstalling cgdsr package...\n")
cgdsr_installed <- install_cgdsr()

# Install other potential dependencies
cat("\nInstalling additional dependencies...\n")
additional_packages <- c("httr", "jsonlite", "xml2")  # cgdsr可能需要的依赖
for (pkg in additional_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# Check if all required packages are installed
cat("\nChecking installed packages:\n")
required_packages <- c("ggplot2", "readxl", "reshape2", "cgdsr")
all_installed <- TRUE

for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed <- FALSE
  }
}

# Provide alternatives if cgdsr fails
if (!is_package_installed("cgdsr")) {
  cat("\ncgdsr installation failed. Alternative options:\n")
  cat("1. Try installing manually: remotes::install_github('cBioPortal/cgdsr')\n")
  cat("2. Use cBioPortal API directly with httr package\n")
  cat("3. Check if your network allows GitHub access\n")
}

cat("You can now run your R scripts in this directory.\n")
