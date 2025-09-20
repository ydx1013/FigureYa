#!/usr/bin/env Rscript
# R package installation script
# This script installs required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(requireNamespace(package_name, quietly = TRUE))
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

cat("Starting R package installation...\n")
cat("===========================================\n")

# 安装CRAN包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("stringr", "gridExtra")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying package installation:\n")
required_packages <- c("stringr", "gridExtra")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "is NOT installed\n")
    all_installed = FALSE
  }
}

# 测试包加载和功能
cat("\nTesting package loading and functionality...\n")

# 测试stringr包
if (is_package_installed("stringr")) {
  tryCatch({
    library(stringr)
    cat("✓ stringr package loaded successfully\n")
    
    # 测试stringr功能
    test_text <- "Hello World"
    result <- str_to_upper(test_text)
    if (result == "HELLO WORLD") {
      cat("✓ stringr functions working correctly\n")
    } else {
      cat("⚠ stringr function test inconclusive\n")
    }
  }, error = function(e) {
    cat("✗ stringr loading failed:", e$message, "\n")
  })
}

# 测试gridExtra包
if (is_package_installed("gridExtra")) {
  tryCatch({
    library(gridExtra)
    cat("✓ gridExtra package loaded successfully\n")
    
    # 测试gridExtra功能（创建简单的图形对象）
    if (exists("grid.arrange") && exists("arrangeGrob")) {
      cat("✓ gridExtra main functions available\n")
    }
  }, error = function(e) {
    cat("✗ gridExtra loading failed:", e$message, "\n")
  })
}

if (all_installed) {
  cat("\n✅ All required packages installed successfully!\n")
  cat("You can now use stringr and gridExtra in your R scripts.\n")
} else {
  cat("\n⚠️  Some packages failed to install.\n")
  cat("You may need to install them manually:\n")
  
  missing_packages <- required_packages[!sapply(required_packages, is_package_installed)]
  for (pkg in missing_packages) {
    cat("install.packages('", pkg, "')\n", sep = "")
  }
}
