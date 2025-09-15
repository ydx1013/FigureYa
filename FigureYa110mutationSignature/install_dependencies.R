#!/usr/bin/env Rscript
# 专门安装 deconstructSigs 的脚本

# 设置下载选项
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(timeout = 300)
options(download.file.method = "libcurl")

# 检查包是否已安装
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# 安装依赖包
install_dependencies <- function() {
  cat("安装依赖包...\n")
  
  # 安装Bioconductor依赖
  if (!is_installed("BiocManager")) {
    install.packages("BiocManager")
  }
  
  bioc_packages <- c("BSgenome", "BSgenome.Hsapiens.UCSC.hg19")
  for (pkg in bioc_packages) {
    if (!is_installed(pkg)) {
      BiocManager::install(pkg, update = FALSE, ask = FALSE)
      cat("已安装:", pkg, "\n")
    }
  }
  
  # 安装CRAN依赖
  cran_packages <- c("remotes", "devtools")
  for (pkg in cran_packages) {
    if (!is_installed(pkg)) {
      install.packages(pkg)
      cat("已安装:", pkg, "\n")
    }
  }
}

# 方法1: 使用devtools安装
install_with_devtools <- function() {
  cat("尝试使用devtools安装...\n")
  tryCatch({
    devtools::install_github("raerose01/deconstructSigs")
    cat("使用devtools安装成功!\n")
    return(TRUE)
  }, error = function(e) {
    cat("devtools安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 方法2: 使用remotes安装特定版本
install_with_remotes <- function() {
  cat("尝试使用remotes安装特定版本...\n")
  tryCatch({
    remotes::install_github("raerose01/deconstructSigs@c3b4c1b") # 稳定版本commit
    cat("使用remotes安装成功!\n")
    return(TRUE)
  }, error = function(e) {
    cat("remotes安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 方法3: 从镜像网站安装
install_from_mirror <- function() {
  cat("尝试从镜像网站安装...\n")
  tryCatch({
    # 使用gitlab镜像
    devtools::install_git("https://gitlab.com/mirror_r_packages/deconstructSigs.git")
    cat("从镜像安装成功!\n")
    return(TRUE)
  }, error = function(e) {
    cat("镜像安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 主安装函数
install_deconstructSigs <- function() {
  if (is_installed("deconstructSigs")) {
    cat("deconstructSigs 已经安装!\n")
    return(TRUE)
  }
  
  cat("开始安装 deconstructSigs...\n")
  install_dependencies()
  
  # 尝试多种安装方法
  methods <- list(
    install_with_devtools,
    install_with_remotes,
    install_from_mirror
  )
  
  for (method in methods) {
    if (method()) {
      return(TRUE)
    }
  }
  
  return(FALSE)
}

# 执行安装
if (install_deconstructSigs()) {
  cat("✅ deconstructSigs 安装成功!\n")
} else {
  cat("❌ 所有安装方法都失败了\n")
  cat("请尝试手动安装方法\n")
}
