#!/usr/bin/env Rscript
# 专门安装 deconstructSigs 和相关依赖的脚本

# 设置下载选项
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(timeout = 600)  # 增加超时时间
options(download.file.method = "libcurl")

# 检查包是否已安装
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# 安装CRAN包（带重试机制）
install_cran_package <- function(pkg, max_retries = 3) {
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

# 安装GitHub包
install_github_package <- function(repo, max_retries = 3) {
  pkg_name <- basename(repo)
  
  if (is_installed(pkg_name)) {
    cat("✓", pkg_name, "已经安装\n")
    return(TRUE)
  }
  
  # 确保devtools已安装
  if (!is_installed("devtools")) {
    install_cran_package("devtools")
  }
  
  for (attempt in 1:max_retries) {
    cat("尝试从GitHub安装", repo, "(尝试", attempt, "/", max_retries, ")...\n")
    
    tryCatch({
      devtools::install_github(repo)
      if (is_installed(pkg_name)) {
        cat("✓", pkg_name, "安装成功\n")
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
  
  cat("❌", pkg_name, "安装失败\n")
  return(FALSE)
}

# 安装deconstructSigs及其依赖
install_deconstructsigs <- function() {
  cat("开始安装 deconstructSigs 及其依赖...\n")
  
  # 先安装基础依赖
  base_dependencies <- c(
    "devtools",      # 用于从GitHub安装
    "remotes",       # 替代的远程安装工具
    "ggplot2",       # 图形绘制
    "dplyr",         # 数据处理
    "tidyr",         # 数据整理
    "reshape2",      # 数据重塑
    "stringr"        # 字符串处理
  )
  
  cat("安装基础依赖包...\n")
  sapply(base_dependencies, install_cran_package)
  
  # 安装deconstructSigs
  cat("安装 deconstructSigs...\n")
  success <- install_github_package("raerose01/deconstructSigs")
  
  if (!success) {
    cat("尝试备选安装方法...\n")
    # 尝试使用remotes安装
    if (!is_installed("remotes")) {
      install_cran_package("remotes")
    }
    
    tryCatch({
      remotes::install_github("raerose01/deconstructSigs")
      if (is_installed("deconstructSigs")) {
        cat("✓ deconstructSigs 通过remotes安装成功\n")
        return(TRUE)
      }
    }, error = function(e) {
      cat("备选安装方法失败:", e$message, "\n")
    })
  }
  
  return(success)
}

# 安装其他可能的突变特征分析包
install_alternative_packages <- function() {
  cat("安装其他突变特征分析相关的包...\n")
  
  alternative_packages <- c(
    "MutationalPatterns",  # 另一个流行的突变特征分析包
    "maftools",           # 突变分析工具
    "BSgenome",           # 基因组数据处理
    "VariantAnnotation"   # 变异注释
  )
  
  for (pkg in alternative_packages) {
    if (!is_installed(pkg)) {
      cat("尝试安装备选包:", pkg, "\n")
      install_cran_package(pkg)
    }
  }
}

# 验证安装
verify_installation <- function() {
  cat("验证安装...\n")
  
  required_packages <- c("deconstructSigs", "ggplot2", "dplyr", "reshape2")
  missing_packages <- c()
  
  for (pkg in required_packages) {
    if (is_installed(pkg)) {
      cat("✓", pkg, "已安装\n")
      
      # 尝试加载包来验证
      tryCatch({
        library(pkg, character.only = TRUE, quietly = TRUE)
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
  cat("\n如果 deconstructSigs 安装失败，可以考虑：\n")
  cat("1. 使用 MutationalPatterns 包作为替代\n")
  cat("2. 手动下载源码编译安装\n")
  cat("3. 使用 Docker 或 conda 环境\n")
  cat("4. 联系包作者或查看GitHub issues\n")
}

# 主安装函数
main <- function() {
  cat("开始安装 deconstructSigs 和相关包...\n")
  cat("===========================================\n")
  
  # 安装deconstructSigs
  success <- install_deconstructsigs()
  
  # 安装备选包
  install_alternative_packages()
  
  # 验证安装
  is_verified <- verify_installation()
  
  cat("\n===========================================\n")
  if (is_verified) {
    cat("✅ deconstructSigs 安装验证成功！\n")
    cat("你现在可以运行突变特征分析的R脚本了。\n")
  } else if (is_installed("MutationalPatterns")) {
    cat("⚠ deconstructSigs 安装失败，但找到了替代包 MutationalPatterns\n")
    cat("你可能需要修改脚本使用 MutationalPatterns 包\n")
  } else {
    cat("❌ deconstructSigs 安装失败\n")
    suggest_alternatives()
  }
  
  # 提供修改脚本的建议
  if (!is_installed("deconstructSigs") && is_installed("MutationalPatterns")) {
    cat("\n你可以修改脚本，将 library(deconstructSigs) 替换为：\n")
    cat("library(MutationalPatterns)\n")
    cat("# 注意：函数和参数可能需要相应调整\n")
  }
}

# 执行安装
main()
