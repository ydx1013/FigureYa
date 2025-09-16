#!/usr/bin/env Rscript
# 专门安装 tidyverse 和相关依赖的脚本

# 设置下载选项
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(timeout = 600)  # 增加超时时间
options(download.file.method = "libcurl")

# 检查包是否已安装
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# 安装单个包（带重试机制）
install_single_package <- function(pkg, max_retries = 3) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "已经安装\n")
    return(TRUE)
  }
  
  for (attempt in 1:max_retries) {
    cat("尝试安装", pkg, "(尝试", attempt, "/", max_retries, ")...\n")
    
    tryCatch({
      install.packages(pkg, dependencies = TRUE)
      if (is_installed(pkg)) {
        cat("✓", pkg, "安装成功\n")
        return(TRUE)
      }
    }, error = function(e) {
      cat("尝试", attempt, "失败:", e$message, "\n")
      if (attempt < max_retries) {
        cat("等待10秒后重试...\n")
        Sys.sleep(10)
      }
    })
  }
  
  cat("❌", pkg, "安装失败\n")
  return(FALSE)
}

# 分步安装tidyverse的核心组件
install_tidyverse_components <- function() {
  cat("开始分步安装 tidyverse 组件...\n")
  
  # tidyverse 核心包列表
  tidyverse_core <- c(
    "ggplot2",    # 数据可视化
    "dplyr",      # 数据操作
    "tidyr",      # 数据整理
    "readr",      # 数据读取
    "purrr",      # 函数式编程
    "tibble",     # 现代数据框
    "stringr",    # 字符串处理
    "forcats"     # 因子处理
  )
  
  # 其他常用包
  additional_packages <- c(
    "magrittr",   # 管道操作符
    "readxl",     # Excel文件读取
    "haven",      # SPSS/SAS/Stata文件读取
    "jsonlite",   # JSON处理
    "xml2",       # XML处理
    "httr",       # HTTP请求
    "rvest",      # 网页抓取
    "modelr",     # 建模工具
    "broom"       # 模型结果整理
  )
  
  # 先安装核心包
  cat("安装核心 tidyverse 包...\n")
  core_success <- sapply(tidyverse_core, install_single_package)
  
  # 再安装附加包
  cat("安装附加 tidyverse 包...\n")
  additional_success <- sapply(additional_packages, install_single_package)
  
  # 尝试安装完整的tidyverse元包
  cat("尝试安装完整的 tidyverse 元包...\n")
  tidyverse_success <- install_single_package("tidyverse")
  
  return(all(core_success) || tidyverse_success)
}

# 安装系统依赖（如果需要）
install_system_dependencies <- function() {
  cat("检查系统依赖...\n")
  
  # 对于Linux系统，可能需要安装一些开发库
  if (.Platform$OS.type == "unix") {
    cat("在Unix系统上，可能需要安装以下开发库：\n")
    cat("sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev\n")
    cat("或者对于CentOS: sudo yum install libcurl-devel openssl-devel libxml2-devel\n")
  }
}

# 验证安装
verify_installation <- function() {
  cat("验证安装...\n")
  
  required_packages <- c("ggplot2", "dplyr", "tidyr", "readr", "purrr")
  missing_packages <- c()
  
  for (pkg in required_packages) {
    if (is_installed(pkg)) {
      cat("✓", pkg, "已安装\n")
      
      # 尝试加载包来验证
      tryCatch({
        library(pkg, character.only = TRUE)
        cat("  ", pkg, "加载成功\n")
      }, error = function(e) {
        cat("  ⚠", pkg, "加载有警告:", e$message, "\n")
      })
    } else {
      cat("❌", pkg, "未安装\n")
      missing_packages <- c(missing_packages, pkg)
    }
  }
  
  return(length(missing_packages) == 0)
}

# 提供备选方案
suggest_alternatives <- function() {
  cat("\n如果tidyverse安装仍然失败，可以考虑：\n")
  cat("1. 只安装需要的核心包（ggplot2, dplyr, tidyr等）\n")
  cat("2. 使用MiniCRAN或本地镜像\n")
  cat("3. 手动下载包文件并本地安装\n")
  cat("4. 使用conda安装: conda install -c r r-tidyverse\n")
}

# 主安装函数
main <- function() {
  cat("开始安装 tidyverse 和相关包...\n")
  cat("===========================================\n")
  
  # 安装系统依赖提示
  install_system_dependencies()
  
  # 安装tidyverse组件
  success <- install_tidyverse_components()
  
  # 验证安装
  is_verified <- verify_installation()
  
  cat("\n===========================================\n")
  if (is_verified) {
    cat("✅ tidyverse 安装验证成功！\n")
    cat("你现在可以运行需要tidyverse的R脚本了。\n")
  } else if (success) {
    cat("⚠ tidyverse 部分安装成功\n")
    cat("核心功能可用，但某些包可能缺失。\n")
    suggest_alternatives()
  } else {
    cat("❌ tidyverse 安装失败\n")
    suggest_alternatives()
    
    # 尝试最后的手段：安装最小功能集
    cat("\n尝试安装最小功能集...\n")
    minimal_packages <- c("ggplot2", "dplyr", "readr")
    sapply(minimal_packages, install_single_package)
  }
  
  # 检查是否安装了deconstructSigs（根据之前的错误日志）
  if (!is_installed("deconstructSigs")) {
    cat("\n检测到可能需要 deconstructSigs...\n")
    cat("请运行专门的 deconstructSigs 安装脚本\n")
  }
}

# 执行安装
main()
