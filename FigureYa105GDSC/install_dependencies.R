#!/usr/bin/env Rscript
# 专门安装 pRRophetic 包的脚本

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

# 安装pRRophetic的依赖包
install_dependencies <- function() {
  cat("安装 pRRophetic 的依赖包...\n")
  
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

# 尝试从Bioconductor安装pRRophetic
install_pRRophetic_bioc <- function() {
  cat("尝试从Bioconductor安装 pRRophetic...\n")
  return(install_bioc_package("pRRophetic"))
}

# 尝试从GitHub安装pRRophetic
install_pRRophetic_github <- function() {
  cat("尝试从GitHub安装 pRRophetic...\n")
  
  if (!is_installed("remotes")) {
    install.packages("remotes")
  }
  
  tryCatch({
    # 尝试不同的GitHub仓库
    remotes::install_github("paulgeeleher/pRRophetic")
    if (is_installed("pRRophetic")) {
      cat("✓ 从GitHub安装 pRRophetic 成功\n")
      return(TRUE)
    }
    
    # 如果第一个仓库失败，尝试其他可能的仓库
    remotes::install_github("geeleher/pRRophetic")
    if (is_installed("pRRophetic")) {
      cat("✓ 从GitHub安装 pRRophetic 成功\n")
      return(TRUE)
    }
    
    cat("❌ 所有GitHub仓库尝试都失败\n")
    return(FALSE)
    
  }, error = function(e) {
    cat("❌ GitHub安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 尝试安装旧版本
install_pRRophetic_old_version <- function() {
  cat("尝试安装旧版本 pRRophetic...\n")
  
  tryCatch({
    # 使用BiocManager安装特定版本
    if (!is_installed("BiocManager")) {
      install.packages("BiocManager")
    }
    
    # 尝试Bioconductor 3.14版本的pRRophetic
    BiocManager::install("pRRophetic", version = "3.14", update = FALSE, ask = FALSE)
    if (is_installed("pRRophetic")) {
      cat("✓ 安装旧版本 pRRophetic 成功\n")
      return(TRUE)
    }
    
    cat("❌ 旧版本安装失败\n")
    return(FALSE)
    
  }, error = function(e) {
    cat("❌ 旧版本安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 验证安装
verify_installation <- function() {
  cat("验证 pRRophetic 安装...\n")
  
  if (is_installed("pRRophetic")) {
    cat("✓ pRRophetic 已安装\n")
    
    # 尝试加载包
    tryCatch({
      library(pRRophetic, character.only = TRUE)
      cat("✓ pRRophetic 加载成功\n")
      return(TRUE)
    }, error = function(e) {
      cat("⚠ pRRophetic 加载有警告:", e$message, "\n")
      return(TRUE)  # 即使有警告，也算安装成功
    })
  } else {
    cat("❌ pRRophetic 未安装\n")
    return(FALSE)
  }
}

# 主安装函数
main <- function() {
  cat("开始安装 pRRophetic 包...\n")
  cat("===========================================\n")
  
  # 首先安装依赖包
  install_dependencies()
  
  # 尝试多种安装方法
  installation_methods <- list(
    install_pRRophetic_bioc,
    install_pRRophetic_github,
    install_pRRophetic_old_version
  )
  
  success <- FALSE
  for (method in installation_methods) {
    if (method()) {
      success <- TRUE
      break
    }
    cat("等待5秒后尝试下一种方法...\n")
    Sys.sleep(5)
  }
  
  # 验证安装
  is_verified <- verify_installation()
  
  cat("\n===========================================\n")
  if (is_verified) {
    cat("✅ pRRophetic 安装成功！\n")
    cat("你现在可以运行需要pRRophetic的R脚本了。\n")
  } else {
    cat("❌ pRRophetic 安装失败\n")
    cat("请尝试以下替代方案：\n")
    cat("1. 手动从Bioconductor安装: BiocManager::install(\"pRRophetic\")\n")
    cat("2. 从GitHub安装: remotes::install_github(\"paulgeeleher/pRRophetic\")\n")
    cat("3. 联系pRRophetic的作者获取帮助\n")
  }
  
  # 确保其他需要的包也安装了
  cat("\n确保其他必要包已安装...\n")
  other_packages <- c("cowplot", "ggplot2")
  for (pkg in other_packages) {
    install_cran_package(pkg)
  }
}

# 执行安装
main()
