#!/usr/bin/env Rscript
# 修复后的 R 依赖安装脚本
# 专门针对 FigureYa197SmoothHaz.Rmd 的依赖

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
    cat("正在安装 CRAN 包:", package_name, "\n")
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

# 安装特定版本的包
install_specific_version <- function(package_name, version) {
  if (!is_package_installed(package_name)) {
    cat("正在安装指定版本:", package_name, "==", version, "\n")
    tryCatch({
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      remotes::install_version(package_name, version = version)
      cat("成功安装:", package_name, "==", version, "\n")
    }, error = function(e) {
      cat("版本安装失败:", e$message, "\n")
      # 尝试安装最新版本
      install_cran_package(package_name)
    })
  } else {
    cat("包已安装:", package_name, "\n")
  }
}

cat("开始安装 R 包依赖...\n")
cat("===========================================\n")

# 首先安装系统依赖（如果在 Linux 环境下）
cat("\n检查系统依赖...\n")
if (.Platform$OS.type == "unix") {
  # 对于 extrafont 需要的系统依赖
  system("sudo apt-get update && sudo apt-get install -y libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev")
}

# 安装 CRAN 包（使用正确的包名）
cat("\n安装 CRAN 包...\n")
cran_packages <- c(
  "cowplot", "dplyr", "ggplot2", "muhaz", 
  "openxlsx", "survival", "survminer", "remotes"
)

for (pkg in cran_packages) {
  install_cran_package(pkg)
}

# 特殊处理 extrafont 相关包
cat("\n安装 extrafont 相关包...\n")
tryCatch({
  # 先安装依赖
  install_cran_package("Rttf2pt1")
  install_cran_package("extrafontdb")
  
  # 安装指定版本的 extrafont（如果最新版有问题）
  if (!is_package_installed("extrafont")) {
    cat("尝试安装 extrafont...\n")
    install_cran_package("extrafont")
    
    # 如果安装失败，尝试从 GitHub 安装
    if (!is_package_installed("extrafont")) {
      cat("从 GitHub 安装 extrafont...\n")
      if (!is_package_installed("devtools")) {
        install.packages("devtools")
      }
      devtools::install_github("wch/extrafont")
    }
  }
  
  # 加载并初始化字体
  if (is_package_installed("extrafont")) {
    library(extrafont)
    font_import(prompt = FALSE)
    loadfonts()
    cat("extrafont 初始化完成\n")
  }
}, error = function(e) {
  cat("extrafont 安装过程中出错:", e$message, "\n")
})

# 安装 export 包
cat("\n安装 export 包...\n")
if (!is_package_installed("export")) {
  tryCatch({
    install_cran_package("export")
  }, error = function(e) {
    cat("尝试安装 officedown 作为替代...\n")
    install_cran_package("officedown")
  })
}

cat("\n===========================================\n")
cat("安装完成！正在验证安装...\n")

# 验证关键包是否安装成功
required_packages <- c("survival", "survminer", "muhaz", "ggplot2")
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✅", pkg, "安装成功\n")
  } else {
    cat("❌", pkg, "安装失败\n")
  }
}

cat("\n你可以现在运行 FigureYa197SmoothHaz.Rmd 脚本了！\n")
