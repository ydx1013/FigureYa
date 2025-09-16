#!/usr/bin/env Rscript
# 修复后的 R 依赖安装脚本
# 专门针对 FigureYa211multiCohortImmSubtype.Rmd 的依赖

# 设置镜像
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

# 检查包是否已安装
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# 安装 CRAN 包
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

# 安装 Bioconductor 包
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

cat("Starting R package installation for FigureYa211multiCohortImmSubtype...\n")
cat("===========================================\n")

# 首先安装 BiocManager（如果尚未安装）
if (!is_package_installed("BiocManager")) {
  install.packages("BiocManager")
}

# 安装 Bioconductor 包（包括 sva 和 estimate）
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("sva", "estimate", "ConsensusClusterPlus")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# 安装 CRAN 包
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("pheatmap", "survival", "survminer", "ggplot2", "dplyr", "tidyr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 免疫分析常用的额外包
cat("\nInstalling additional immunology packages...\n")
additional_packages <- c("GSVA", "immunedeconv", "IOBR", "ggpubr")
for (pkg in additional_packages) {
  if (pkg %in% c("GSVA", "immunedeconv")) {
    install_bioc_package(pkg)
  } else {
    install_cran_package(pkg)
  }
}

# 系统依赖检查
cat("\nChecking for system dependencies...\n")
if (.Platform$OS.type == "unix") {
  # 编译依赖
  system("sudo apt-get update && sudo apt-get install -y libblas-dev liblapack-dev gfortran")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying installation...\n")
required_packages <- c("sva", "estimate", "ConsensusClusterPlus", "pheatmap", "survival")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✅", pkg, "installed successfully\n")
  } else {
    cat("❌", pkg, "installation failed\n")
  }
}

# 测试关键包的功能
cat("\nTesting key packages...\n")
if (is_package_installed("sva")) {
  tryCatch({
    library(sva)
    cat("✅ sva package loaded successfully\n")
  }, error = function(e) {
    cat("❌ Error loading sva:", e$message, "\n")
  })
}

if (is_package_installed("estimate")) {
  tryCatch({
    library(estimate)
    cat("✅ estimate package loaded successfully\n")
  }, error = function(e) {
    cat("❌ Error loading estimate:", e$message, "\n")
  })
}

cat("\nYou can now run FigureYa211multiCohortImmSubtype.Rmd script!\n")
