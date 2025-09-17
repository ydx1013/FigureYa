#!/usr/bin/env Rscript
# 修正后的R依赖安装脚本

# 设置镜像以改善下载性能
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

# 安装GitHub包的函数
install_github_package <- function(repo) {
  package_name <- basename(repo)
  if (!is_package_installed(package_name)) {
    cat("正在安装GitHub包:", repo, "\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github(repo)
      cat("成功安装:", package_name, "\n")
    }, error = function(e) {
      cat("安装失败", repo, ":", e$message, "\n")
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

# 安装SeuratData的特殊函数
install_seuratdata <- function() {
  if (!is_package_installed("SeuratData")) {
    cat("正在安装SeuratData...\n")
    tryCatch({
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      # 安装SeuratData
      remotes::install_github("satijalab/seurat-data")
      cat("成功安装: SeuratData\n")
    }, error = function(e) {
      cat("安装SeuratData失败:", e$message, "\n")
    })
  } else {
    cat("包已安装: SeuratData\n")
  }
}

cat("开始安装R包...\n")
cat("===========================================\n")

# 首先安装devtools和remotes
install_cran_package("devtools")
install_cran_package("remotes")

# 安装CRAN包
cat("\n安装CRAN包...\n")
cran_packages <- c("RColorBrewer", "Seurat", "colorRamps", "dplyr", "future", 
                  "magrittr", "patchwork", "pheatmap")

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 特殊安装SeuratData
cat("\n安装SeuratData...\n")
install_seuratdata()

# 安装细胞类型标记包（这些也需要从GitHub安装）
cat("\n安装细胞类型标记包...\n")
celltype_packages <- c("satijalab/azimuth", "satijalab/azimuth-data")
for (pkg in celltype_packages) {
  install_github_package(pkg)
}

# 尝试安装其他可能的细胞类型包
cat("\n尝试安装细胞类型参考包...\n")
tryCatch({
  # 这些包可能不存在，但尝试安装
  potential_packages <- c("B_cell", "Eryth", "Monocyte", "T_cell", "pDC")
  for (pkg in potential_packages) {
    if (!is_package_installed(pkg)) {
      cat("尝试安装:", pkg, "\n")
      tryCatch({
        install_cran_package(pkg)
      }, error = function(e) {
        cat(pkg, "不在CRAN上，可能需要其他安装方式\n")
      })
    }
  }
}, error = function(e) {
  cat("细胞类型包安装遇到问题:", e$message, "\n")
})

cat("\n===========================================\n")
cat("包安装完成！\n")
cat("注意：某些细胞类型标记包可能需要额外的安装步骤\n")
cat("现在可以运行此目录中的R脚本了。\n")
