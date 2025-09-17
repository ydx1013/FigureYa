#!/usr/bin/env Rscript
# R package installation script for FigureYa63pubmedMiningV2

# Set up mirrors
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

# Improved package check function
is_package_installed <- function(package_name) {
  return(requireNamespace(package_name, quietly = TRUE))
}

# Install function with better error handling
install_package <- function(package_name, type = "cran") {
  if (!is_package_installed(package_name)) {
    cat("Installing", type, "package:", package_name, "\n")
    tryCatch({
      if (type == "cran") {
        install.packages(package_name, dependencies = TRUE, quiet = TRUE)
      } else if (type == "bioc") {
        if (!is_package_installed("BiocManager")) {
          install.packages("BiocManager", quiet = TRUE)
        }
        BiocManager::install(package_name, update = FALSE, ask = FALSE, quiet = TRUE)
      } else if (type == "github") {
        if (!is_package_installed("remotes")) {
          install.packages("remotes", quiet = TRUE)
        }
        remotes::install_github(package_name, quiet = TRUE)
      }
      cat("✓ Successfully installed:", package_name, "\n")
    }, error = function(e) {
      cat("✗ Failed to install", package_name, ":", e$message, "\n")
    })
  } else {
    cat("✓ Package already installed:", package_name, "\n")
  }
}

cat("Starting package installation for PubMed mining...\n")
cat("===========================================\n")

# 安装基础工具包
cat("\n1. Installing basic utilities...\n")
base_packages <- c("remotes", "devtools")
for (pkg in base_packages) {
  install_package(pkg, "cran")
}

# 安装CRAN包
cat("\n2. Installing CRAN packages...\n")
cran_packages <- c(
  "bibliometrix", "data.table", "DT", "ggplot2", 
  "ggrepel", "ggthemes", "htmlwidgets", "pubmed.mineR", 
  "rentrez", "stringr", "tidyverse", "dplyr"
)

for (pkg in cran_packages) {
  install_package(pkg, "cran")
}

# 安装jiebaR - 从GitHub安装
cat("\n3. Installing jiebaR from GitHub...\n")
install_package("qinwf/jiebaR", "github")

# 安装Bioconductor包
cat("\n4. Installing Bioconductor packages...\n")
bioc_packages <- c("AnnotationDbi")
for (pkg in bioc_packages) {
  install_package(pkg, "bioc")
}

# 验证安装
cat("\n===========================================\n")
cat("Verifying installation...\n")

critical_packages <- c("jiebaR", "bibliometrix", "pubmed.mineR", "rentrez", "AnnotationDbi")
success_count <- 0

for (pkg in critical_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is ready\n")
    success_count <- success_count + 1
  } else {
    cat("✗", pkg, "is MISSING\n")
  }
}

cat("\nInstallation summary:\n")
cat("Successfully installed:", success_count, "/", length(critical_packages), "critical packages\n")

if (success_count == length(critical_packages)) {
  cat("✅ All critical packages installed successfully!\n")
  cat("You can now run your R scripts in this directory.\n")
} else {
  cat("⚠️  Some packages may need manual installation.\n")
  
  # 提供手动安装命令
  if (!is_package_installed("jiebaR")) {
    cat("\nFor manual jiebaR installation:\n")
    cat("remotes::install_github('qinwf/jiebaR')\n")
  }
}

# 测试jiebaR基本功能
cat("\nTesting jiebaR functionality...\n")
if (is_package_installed("jiebaR")) {
  tryCatch({
    library(jiebaR)
    worker <- worker()
    test_text <- "这是一个测试句子"
    result <- segment(test_text, worker)
    cat("jiebaR test successful:", paste(result, collapse = " | "), "\n")
  }, error = function(e) {
    cat("jiebaR test failed:", e$message, "\n")
  })
} else {
  cat("jiebaR not available for testing\n")
}
