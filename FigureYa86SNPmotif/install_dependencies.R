#!/usr/bin/env Rscript
# 修正版的 motifBreakR 安装脚本
# 根据官方 GitHub 说明和错误信息调整

# 设置镜像
options(repos = c(CRAN = "https://cloud.r-project.org/"))
options(BioC_mirror = "https://bioconductor.org/")
options(timeout = 600)

# 检查包是否已安装
is_installed <- function(pkg) {
  pkg %in% rownames(installed.packages())
}

# 安装CRAN包
install_cran <- function(pkg, max_retries = 3) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "已经安装\n")
    return(TRUE)
  }
  
  for (attempt in 1:max_retries) {
    cat("安装CRAN包:", pkg, "(尝试", attempt, "/", max_retries, ")\n")
    tryCatch({
      install.packages(pkg, dependencies = TRUE, quiet = TRUE)
      if (is_installed(pkg)) {
        cat("✓", pkg, "安装成功\n")
        return(TRUE)
      }
    }, error = function(e) {
      cat("尝试", attempt, "失败:", e$message, "\n")
      Sys.sleep(5)
    })
  }
  return(FALSE)
}

# 安装Bioconductor包
install_bioc <- function(pkg, max_retries = 3) {
  if (is_installed(pkg)) {
    cat("✓", pkg, "已经安装\n")
    return(TRUE)
  }
  
  if (!is_installed("BiocManager")) {
    install_cran("BiocManager")
  }
  
  for (attempt in 1:max_retries) {
    cat("安装Bioconductor包:", pkg, "(尝试", attempt, "/", max_retries, ")\n")
    tryCatch({
      BiocManager::install(pkg, update = FALSE, ask = FALSE, quiet = TRUE)
      if (is_installed(pkg)) {
        cat("✓", pkg, "安装成功\n")
        return(TRUE)
      }
    }, error = function(e) {
      cat("尝试", attempt, "失败:", e$message, "\n")
      Sys.sleep(5)
    })
  }
  return(FALSE)
}

# 安装系统依赖（针对Linux）
install_system_deps <- function() {
  if (.Platform$OS.type == "unix") {
    cat("安装系统依赖...\n")
    try({
      # ghostscript 是 motifStack 的关键依赖
      system("sudo apt-get update && sudo apt-get install -y ghostscript libghc-zlib-dev libcurl4-openssl-dev libssl-dev libxml2-dev")
    }, silent = TRUE)
  }
}

# 按照正确的顺序安装依赖
install_dependencies <- function() {
  cat("开始安装依赖包...\n")
  cat("=============================================\n")
  
  # 1. 首先安装系统依赖
  install_system_deps()
  
  # 2. 安装基础工具
  install_cran("devtools")
  install_cran("remotes")
  
  # 3. 安装BiocManager
  install_cran("BiocManager")
  
  # 4. 安装Bioconductor基础包（按照依赖顺序）
  bioc_base <- c(
    "BiocGenerics",
    "S4Vectors",
    "IRanges",
    "GenomicRanges",
    "Biostrings",
    "rtracklayer",
    "GenomeInfoDb"
  )
  
  for (pkg in bioc_base) {
    install_bioc(pkg)
  }
  
  # 5. 安装其他Bioconductor包
  bioc_other <- c(
    "BiocParallel",
    "Gviz",
    "VariantAnnotation",
    "matrixStats",
    "MotifDb",
    "BSgenome"
  )
  
  for (pkg in bioc_other) {
    install_bioc(pkg)
  }
  
  # 6. 安装TFBSTools（关键依赖）
  cat("安装 TFBSTools...\n")
  if (!install_bioc("TFBSTools")) {
    # 如果标准安装失败，尝试从源码安装
    cat("尝试从源码安装 TFBSTools...\n")
    try({
      remotes::install_bioc("TFBSTools", dependencies = TRUE, upgrade = "never")
    }, silent = TRUE)
  }
  
  # 7. 安装motifStack
  cat("安装 motifStack...\n")
  if (!install_bioc("motifStack")) {
    # 如果标准安装失败，尝试从源码安装
    cat("尝试从源码安装 motifStack...\n")
    try({
      remotes::install_bioc("motifStack", dependencies = TRUE, upgrade = "never")
    }, silent = TRUE)
  }
  
  # 8. 安装CRAN包
  cran_pkgs <- c(
    "TFMPvalue",
    "knitr",
    "rmarkdown",
    "curl",
    "httr",
    "xml2"
  )
  
  for (pkg in cran_pkgs) {
    install_cran(pkg)
  }
  
  # 9. 安装基因组数据包
  genome_pkgs <- c(
    "BSgenome.Hsapiens.UCSC.hg19",
    "SNPlocs.Hsapiens.dbSNP142.GRCh37",
    "SNPlocs.Hsapiens.dbSNP155.GRCh37"
  )
  
  for (pkg in genome_pkgs) {
    install_bioc(pkg)
  }
}

# 安装motifBreakR（从GitHub）
install_motifbreakR <- function() {
  cat("安装 motifBreakR...\n")
  
  if (is_installed("motifbreakR")) {
    cat("✓ motifbreakR 已经安装\n")
    return(TRUE)
  }
  
  # 确保所有依赖都已安装
  required_deps <- c("TFBSTools", "motifStack", "BiocParallel", "BSgenome")
  for (pkg in required_deps) {
    if (!is_installed(pkg)) {
      install_bioc(pkg)
    }
  }
  
  # 从GitHub安装
  cat("从GitHub安装 motifBreakR...\n")
  tryCatch({
    devtools::install_github("Simon-Coetzee/motifBreakR")
    if (is_installed("motifbreakR")) {
      cat("✓ motifbreakR 安装成功\n")
      return(TRUE)
    } else {
      cat("尝试备选安装方法...\n")
      remotes::install_github("Simon-Coetzee/motifBreakR")
      return(is_installed("motifbreakR"))
    }
  }, error = function(e) {
    cat("GitHub安装失败:", e$message, "\n")
    return(FALSE)
  })
}

# 验证安装
verify_installation <- function() {
  cat("验证安装...\n")
  
  required <- c("motifbreakR", "TFBSTools", "motifStack", "BSgenome.Hsapiens.UCSC.hg19")
  missing <- c()
  
  for (pkg in required) {
    if (is_installed(pkg)) {
      cat("✓", pkg, "已安装\n")
      # 测试加载
      tryCatch({
        library(pkg, character.only = TRUE, quietly = TRUE)
        cat("  ", pkg, "加载成功\n")
      }, error = function(e) {
        cat("  ⚠", pkg, "加载警告:", e$message, "\n")
      })
    } else {
      cat("❌", pkg, "未安装\n")
      missing <- c(missing, pkg)
    }
  }
  
  return(length(missing) == 0)
}

# 主函数
main <- function() {
  cat("开始安装 motifBreakR 及其依赖...\n")
  cat("=============================================\n")
  
  # 安装依赖
  install_dependencies()
  
  # 安装motifBreakR
  success <- install_motifbreakR()
  
  # 验证
  verified <- verify_installation()
  
  cat("\n=============================================\n")
  if (verified) {
    cat("✅ 所有包安装成功！\n")
  } else if (success) {
    cat("⚠ motifBreakR 已安装但某些依赖可能有问题\n")
  } else {
    cat("❌ 安装失败\n")
    cat("建议：\n")
    cat("1. 确保系统已安装 ghostscript: sudo apt-get install ghostscript\n")
    cat("2. 手动安装: BiocManager::install(c('TFBSTools', 'motifStack'))\n")
    cat("3. 然后: devtools::install_github('Simon-Coetzee/motifBreakR')\n")
  }
}

# 执行安装
main()
