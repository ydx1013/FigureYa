#!/usr/bin/env Rscript
# 修正版的 motifBreakR 安装脚本
# 专门解决 DirichletMultinomial 依赖问题

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

# 专门安装 DirichletMultinomial（关键修复）
install_dirichlet_multinomial <- function() {
  if (is_installed("DirichletMultinomial")) {
    cat("✓ DirichletMultinomial 已经安装\n")
    return(TRUE)
  }
  
  cat("专门安装 DirichletMultinomial...\n")
  
  # 首先安装系统依赖（针对Linux）
  if (.Platform$OS.type == "unix") {
    cat("安装系统依赖...\n")
    try({
      system("sudo apt-get update && sudo apt-get install -y libgsl-dev")
    }, silent = TRUE)
  }
  
  # 安装GSL库的R接口
  install_cran("gsl")
  
  # 尝试多种安装方法
  methods <- c(
    function() BiocManager::install("DirichletMultinomial", update = FALSE, ask = FALSE),
    function() {
      if (!is_installed("remotes")) install_cran("remotes")
      remotes::install_bioc("DirichletMultinomial")
    },
    function() {
      # 尝试从源码安装
      install.packages("https://bioconductor.org/packages/release/bioc/src/contrib/DirichletMultinomial_1.44.0.tar.gz", 
                      repos = NULL, type = "source")
    }
  )
  
  for (i in seq_along(methods)) {
    cat("尝试安装方法", i, "...\n")
    tryCatch({
      methods[[i]]()
      if (is_installed("DirichletMultinomial")) {
        cat("✓ DirichletMultinomial 安装成功\n")
        return(TRUE)
      }
    }, error = function(e) {
      cat("方法", i, "失败:", e$message, "\n")
    })
    Sys.sleep(2)
  }
  
  return(FALSE)
}

# 安装系统依赖
install_system_deps <- function() {
  if (.Platform$OS.type == "unix") {
    cat("安装系统依赖...\n")
    try({
      system("sudo apt-get update && sudo apt-get install -y ghostscript libgsl-dev libcurl4-openssl-dev libssl-dev libxml2-dev")
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
  install_cran("BiocManager")
  
  # 3. 关键：先安装 DirichletMultinomial
  install_dirichlet_multinomial()
  
  # 4. 安装Bioconductor基础包
  bioc_base <- c(
    "BiocGenerics",
    "S4Vectors",
    "IRanges",
    "GenomicRanges",
    "Biostrings",
    "rtracklayer",
    "GenomeInfoDb",
    "BiocParallel"
  )
  
  for (pkg in bioc_base) {
    install_bioc(pkg)
  }
  
  # 5. 安装TFBSTools（现在应该能成功）
  cat("安装 TFBSTools...\n")
  install_bioc("TFBSTools")
  
  # 6. 安装motifStack
  cat("安装 motifStack...\n")
  install_bioc("motifStack")
  
  # 7. 安装其他Bioconductor包
  bioc_other <- c(
    "Gviz",
    "VariantAnnotation",
    "MotifDb",
    "BSgenome"
  )
  
  for (pkg in bioc_other) {
    install_bioc(pkg)
  }
  
  # 8. 安装CRAN包
  cran_pkgs <- c(
    "TFMPvalue",
    "knitr",
    "rmarkdown",
    "curl",
    "httr"
  )
  
  for (pkg in cran_pkgs) {
    install_cran(pkg)
  }
  
  # 9. 安装基因组数据包
  genome_pkgs <- c(
    "BSgenome.Hsapiens.UCSC.hg19",
    "SNPlocs.Hsapiens.dbSNP142.GRCh37"
  )
  
  for (pkg in genome_pkgs) {
    install_bioc(pkg)
  }
}

# 安装motifBreakR
install_motifbreakR <- function() {
  cat("安装 motifBreakR...\n")
  
  if (is_installed("motifbreakR")) {
    cat("✓ motifbreakR 已经安装\n")
    return(TRUE)
  }
  
  # 确保关键依赖已安装
  required_deps <- c("TFBSTools", "motifStack", "BiocParallel", "BSgenome")
  for (pkg in required_deps) {
    if (!is_installed(pkg)) {
      install_bioc(pkg)
    }
  }
  
  # 从GitHub安装
  cat("从GitHub安装 motifBreakR...\n")
  tryCatch({
    if (!is_installed("remotes")) install_cran("remotes")
    remotes::install_github("Simon-Coetzee/motifBreakR")
    
    if (is_installed("motifbreakR")) {
      cat("✓ motifbreakR 安装成功\n")
      return(TRUE)
    } else {
      # 尝试备选方法
      devtools::install_github("Simon-Coetzee/motifBreakR")
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
    cat("你现在可以使用 library(motifbreakR) 了\n")
  } else {
    cat("⚠ 部分包安装可能有问题\n")
    cat("建议手动安装缺失的包:\n")
    cat("BiocManager::install(c('DirichletMultinomial', 'TFBSTools', 'motifStack'))\n")
    cat("devtools::install_github('Simon-Coetzee/motifBreakR')\n")
  }
}

# 执行安装
main()
