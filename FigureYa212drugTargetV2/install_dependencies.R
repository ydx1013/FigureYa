#!/usr/bin/env Rscript
# 修复后的 R 依赖安装脚本
# 专门针对 FigureYa212drugTargetV2.Rmd 的依赖

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

# 特殊安装 pRRophetic 包
install_pRRophetic <- function() {
  if (!is_package_installed("pRRophetic")) {
    cat("Installing pRRophetic package...\n")
    tryCatch({
      # 方法1: 从 CRAN 安装
      install.packages("pRRophetic")
      cat("Successfully installed pRRophetic from CRAN\n")
    }, error = function(e) {
      cat("CRAN installation failed, trying alternative methods...\n")
      tryCatch({
        # 方法2: 从 GitHub 安装
        if (!is_package_installed("devtools")) {
          install.packages("devtools")
        }
        devtools::install_github("paulgeeleher/pRRophetic")
        cat("Successfully installed pRRophetic from GitHub\n")
      }, error = function(e2) {
        cat("GitHub installation failed, trying manual download...\n")
        tryCatch({
          # 方法3: 手动下载安装
          download.file("https://cran.r-project.org/src/contrib/pRRophetic_0.5.tar.gz", 
                       "pRRophetic.tar.gz")
          install.packages("pRRophetic.tar.gz", repos = NULL, type = "source")
          cat("Successfully installed pRRophetic from source\n")
        }, error = function(e3) {
          cat("All pRRophetic installation methods failed:\n")
          cat("CRAN:", e$message, "\n")
          cat("GitHub:", e2$message, "\n")
          cat("Source:", e3$message, "\n")
        })
      })
    })
  } else {
    cat("Package already installed: pRRophetic\n")
  }
}

cat("Starting R package installation for FigureYa212drugTargetV2...\n")
cat("===========================================\n")

# 首先安装 BiocManager（如果尚未安装）
if (!is_package_installed("BiocManager")) {
  install.packages("BiocManager")
}

# 安装 Bioconductor 包
cat("\nInstalling Bioconductor packages...\n")
bioc_packages <- c("impute", "preprocessCore", "sva")

for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# 安装 CRAN 包（使用正确的包名）
cat("\nInstalling CRAN packages...\n")
cran_packages <- c("ISOpureR", "SimDesign", "cowplot", "ggplot2", "dplyr", "tidyr", "readr", "purrr")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 特殊安装 pRRophetic
cat("\nInstalling pRRophetic (special handling required)...\n")
install_pRRophetic()

# 药物靶点分析常用的额外包
cat("\nInstalling additional drug target analysis packages...\n")
additional_packages <- c("oncoPredict", "PharmacoGx", "ggpubr", "reshape2")
for (pkg in additional_packages) {
  if (pkg %in% c("PharmacoGx")) {
    install_bioc_package(pkg)
  } else {
    install_cran_package(pkg)
  }
}

# 系统依赖检查
cat("\nChecking for system dependencies...\n")
if (.Platform$OS.type == "unix") {
  # 编译依赖
  system("sudo apt-get update && sudo apt-get install -y libblas-dev liblapack-dev gfortran libcurl4-openssl-dev libssl-dev")
}

cat("\n===========================================\n")
cat("Package installation completed!\n")

# 验证安装
cat("\nVerifying installation...\n")
required_packages <- c("pRRophetic", "impute", "ggplot2", "dplyr")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✅", pkg, "installed successfully\n")
  } else {
    cat("❌", pkg, "installation failed\n")
  }
}

# 测试 pRRophetic 包的功能
cat("\nTesting pRRophetic package...\n")
if (is_package_installed("pRRophetic")) {
  tryCatch({
    library(pRRophetic)
    cat("✅ pRRophetic package loaded successfully\n")
    cat("pRRophetic package version:", packageVersion("pRRophetic"), "\n")
  }, error = function(e) {
    cat("❌ Error loading pRRophetic:", e$message, "\n")
  })
} else {
  cat("⚠️ pRRophetic not installed, consider using alternative packages\n")
}

cat("\nYou can now run FigureYa212drugTargetV2.Rmd script!\n")
