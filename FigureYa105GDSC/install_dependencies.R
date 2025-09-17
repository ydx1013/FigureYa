#!/usr/bin/env Rscript
# 安装必要依赖包的脚本

# 设置下载选项
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")
options(timeout = 600)  # 增加超时时间

# 检查包是否已安装
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# 安装Bioconductor包
install_bioc_package <- function(pkg) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "已经安装\n")
    return(TRUE)
  }
  
  cat("安装Bioconductor包:", pkg, "\n")
  tryCatch({
    if (!is_installed("BiocManager")) {
      install.packages("BiocManager")
    }
    BiocManager::install(pkg, update = FALSE, ask = FALSE)
    if (is_installed(pkg)) {
      cat("✓", pkg, "安装成功\n")
      return(TRUE)
    } else {
      cat("❌", pkg, "安装失败\n")
      return(FALSE)
    }
  }, error = function(e) {
    cat("❌", pkg, "安装错误:", e$message, "\n")
    return(FALSE)
  })
}

# 安装CRAN包
install_cran_package <- function(pkg) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "已经安装\n")
    return(TRUE)
  }
  
  cat("安装CRAN包:", pkg, "\n")
  tryCatch({
    install.packages(pkg, dependencies = TRUE)
    if (is_installed(pkg)) {
      cat("✓", pkg, "安装成功\n")
      return(TRUE)
    } else {
      cat("❌", pkg, "安装失败\n")
      return(FALSE)
    }
  }, error = function(e) {
    cat("❌", pkg, "安装错误:", e$message, "\n")
    return(FALSE)
  })
}

# 安装必要的依赖包
install_dependencies <- function() {
  cat("安装必要的依赖包...\n")
  
  # Bioconductor依赖
  bioc_deps <- c(
    "Biobase",
    "genefilter",
    "sva",
    "car",
    "impute",
    "preprocessCore"
  )
  
  # CRAN依赖
  cran_deps <- c(
    "ggplot2",
    "cowplot",
    "ridge",
    "lars",
    "data.table",
    "foreach",
    "doParallel"
  )
  
  # 安装Bioconductor依赖
  for (pkg in bioc_deps) {
    install_bioc_package(pkg)
  }
  
  # 安装CRAN依赖
  for (pkg in cran_deps) {
    install_cran_package(pkg)
  }
}

# 主安装函数
main <- function() {
  cat("开始安装必要的依赖包...\n")
  cat("===========================================\n")
  
  # 安装依赖包
  install_dependencies()
  
  cat("\n===========================================\n")
  cat("✅ 依赖包安装完成！\n")
  cat("注意：pRRophetic 包已不再需要安装\n")
  cat("你现在可以运行相关的R脚本了。\n")
}

# 执行安装
main()
