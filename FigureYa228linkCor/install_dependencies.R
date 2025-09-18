#!/usr/bin/env Rscript
# 修正后的R依赖安装脚本 - 离线版本

# 设置镜像以改善下载性能（对于其他需要联网的包）
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")

# 检查包是否已安装的函数
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# 安装CRAN包的函数
install_cran_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("正在安装CRAN包:", package_name, "\n")
    tryCatch({
      install.packages(package_name, dependencies = TRUE)
      cat("成功安装:", package_name, "\n")
    }, error = function(e) {
      cat("安装失败", package_name, ":", e$message, "\n")
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

# 安装Bioconductor包的函数
install_bioc_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("正在安装Bioconductor包:", package_name, "\n")
    tryCatch({
      if (!is_package_installed("BiocManager")) {
        install.packages("BiocManager")
      }
      BiocManager::install(package_name, update = FALSE, ask = FALSE)
      cat("成功安装:", package_name, "\n")
    }, error = function(e) {
      cat("安装失败", package_name, ":", e$message, "\n")
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

# 从本地tar.gz文件安装包的函数
install_local_package <- function(tar_file) {
  package_name <- gsub("\\.tar\\.gz$", "", basename(tar_file))
  package_name <- gsub("-master$", "", package_name)  # 移除-master后缀
  
  if (!is_package_installed(package_name)) {
    cat("正在从本地文件安装包:", tar_file, "\n")
    tryCatch({
      # 检查文件是否存在
      if (!file.exists(tar_file)) {
        stop(paste("文件不存在:", tar_file))
      }
      
      # 安装本地包
      install.packages(tar_file, repos = NULL, type = "source")
      cat("成功从本地文件安装:", package_name, "\n")
    }, error = function(e) {
      cat("本地安装失败", tar_file, ":", e$message, "\n")
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

cat("开始安装R包...\n")
cat("===========================================\n")

# 首先安装ggcor的依赖（如果有的话）
cat("\n安装ggcor的依赖包...\n")
ggcor_dependencies <- c("ggplot2", "dplyr", "tidyr", "tibble", "rlang")
for (pkg in ggcor_dependencies) {
  install_cran_package(pkg)
}

# 从本地文件安装ggcor
cat("\n从本地文件安装ggcor...\n")
local_packages <- c("ggcor-master.tar.gz")
for (pkg_file in local_packages) {
  install_local_package(pkg_file)
}

# 安装其他CRAN包
cat("\n安装其他CRAN包...\n")
cran_packages <- c("ade4", "data.table", "ggnewscale")
for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 安装Bioconductor包
cat("\n安装Bioconductor包...\n")
bioc_packages <- c("GSVA")
for (pkg in bioc_packages) {
  install_bioc_package(pkg)
}

# 验证安装
cat("\n验证包安装...\n")
required_packages <- c("ggcor", "ade4", "data.table", "ggnewscale", "ggplot2", "GSVA")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "安装成功\n")
  } else {
    cat("✗", pkg, "安装失败\n")
    all_installed <- FALSE
  }
}

# 测试加载ggcor包
cat("\n测试ggcor包加载...\n")
try({
  library(ggcor)
  cat("✓ ggcor包加载成功\n")
  cat("ggcor版本:", packageVersion("ggcor"), "\n")
}, error = function(e) {
  cat("✗ ggcor包加载失败:", e$message, "\n")
  all_installed <- FALSE
})

cat("\n===========================================\n")
if (all_installed) {
  cat("所有包安装完成！\n")
  cat("现在可以运行FigureYa228linkCor.Rmd脚本了。\n")
} else {
  cat("部分包安装失败，请检查错误信息。\n")
}
