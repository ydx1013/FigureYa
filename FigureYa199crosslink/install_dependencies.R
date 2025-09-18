#!/usr/bin/env Rscript
# 简化版R包安装脚本 - 仅安装ggplot2

# 设置CRAN镜像
options("repos" = c(CRAN = "https://cloud.r-project.org/"))

# 检查包是否已安装的函数
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# 安装CRAN包的函数
install_cran_package <- function(package_name) {
  if (!is_package_installed(package_name)) {
    cat("正在安装包:", package_name, "\n")
    tryCatch({
      install.packages(package_name, dependencies = TRUE, quiet = TRUE)
      cat("成功安装:", package_name, "\n")
    }, error = function(e) {
      cat("安装失败", package_name, ":", e$message, "\n")
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

cat("开始安装R包...\n")
cat("===========================================\n")

# 只安装ggplot2包
install_cran_package("ggplot2")

cat("\n===========================================\n")

# 验证安装结果
if (is_package_installed("ggplot2")) {
  cat("✓ ggplot2 已成功安装\n")
  cat("\n安装完成！您现在可以使用：library(ggplot2)\n")
} else {
  cat("✗ ggplot2 安装失败\n")
  cat("请检查网络连接或手动安装：install.packages(\"ggplot2\")\n")
}
