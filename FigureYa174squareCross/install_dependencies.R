#!/usr/bin/env Rscript
# 简化版R包安装脚本 - 仅安装ggplot2, aplot, dplyr

# 设置CRAN镜像
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(timeout = 600)  # 增加超时时间到10分钟

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

# 只安装这三个包
packages_to_install <- c("ggplot2", "aplot", "dplyr")

for (pkg in packages_to_install) {
  install_cran_package(pkg)
}

cat("\n===========================================\n")

# 验证安装结果
cat("验证安装结果:\n")
all_installed <- TRUE
for (pkg in packages_to_install) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "已成功安装\n")
  } else {
    cat("✗", pkg, "安装失败\n")
    all_installed = FALSE
  }
}

if (all_installed) {
  cat("\n所有三个包已成功安装！\n")
  cat("您现在可以使用以下代码加载这些包：\n")
  cat("library(ggplot2)\n")
  cat("library(aplot)\n") 
  cat("library(dplyr)\n")
} else {
  cat("\n部分包安装失败，请检查网络连接或手动安装。\n")
}

cat("安装完成！\n")
