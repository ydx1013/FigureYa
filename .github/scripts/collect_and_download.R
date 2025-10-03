# install.packages(c("dplyr", "stringr", "purrr", "httr", "remotes"))
library(dplyr)
library(stringr)
library(purrr)
library(httr)
library(remotes)

# --- 配置 ---
SOURCE_REPO_PATH <- "source-repo"
TARGET_REPO_PATH <- "target-repo"
# ---

# 1. 查找所有依赖文件
dependency_files <- list.files(
  path = SOURCE_REPO_PATH,
  pattern = "install_dependencies.R",
  recursive = TRUE,
  full.names = TRUE
)

if (length(dependency_files) == 0) {
  stop("错误：在 '", SOURCE_REPO_PATH, "' 中没有找到 'install_dependencies.R' 文件。")
}

cat("找到以下依赖文件：\n")
print(dependency_files)

# 2. 读取并解析所有文件内容，提取包信息
all_lines <- map(dependency_files, readLines) %>% unlist()

# 提取 CRAN 和 Bioconductor 包
cran_bioc_packages <- all_lines %>%
  str_extract_all('(?<=install\\.packages\\(|BiocManager::install\\()"[^"]+"') %>%
  unlist() %>%
  str_remove_all('"')

# 提取 GitHub 包
github_packages <- all_lines %>%
  str_extract_all('(?<=install_github\\()"[^"]+"') %>%
  unlist() %>%
  str_remove_all('"')

# 去重
unique_cran_bioc <- unique(cran_bioc_packages)
unique_github <- unique(github_packages)

cat("\n--- 汇总需要安装的包 ---\n")
cat("CRAN/Bioconductor 包:\n")
print(unique_cran_bioc)
cat("\nGitHub 包:\n")
print(unique_github)
cat("---------------------------\n\n")

# 3. 下载包的源码
dir.create(TARGET_REPO_PATH, showWarnings = FALSE)

# 下载 CRAN/Bioc 包
if (length(unique_cran_bioc) > 0) {
  cat("开始下载 CRAN/Bioconductor 源码包...\n")
  # 使用 download.packages 下载源码包，它会自动处理依赖
  # type = "source" 确保下载的是 .tar.gz
  tryCatch({
    download.packages(
      pkgs = unique_cran_bioc,
      destdir = TARGET_REPO_PATH,
      type = "source",
      repos = "https://cran.r-project.org" # 指定 CRAN 镜像
    )
  }, error = function(e) {
    cat("从 CRAN 下载时出错，尝试从 Bioconductor 下载...\n")
    # 如果 CRAN 失败，可能是 Bioconductor 包
    # BiocManager::install(..., destdir=...) 的行为不同，我们用 remotes
    for (pkg in unique_cran_bioc) {
      tryCatch({
        remotes::download_version(pkg, destdir = TARGET_REPO_PATH, type = "source")
        cat("成功下载: ", pkg, "\n")
      }, error = function(e_remotes) {
        cat("警告：下载 '", pkg, "' 失败: ", e_remotes$message, "\n")
      })
    }
  })
}

# 下载 GitHub 包
if (length(unique_github) > 0) {
  cat("\n开始下载 GitHub 源码包...\n")
  for (pkg_repo in unique_github) {
    cat("下载: ", pkg_repo, "\n")
    tryCatch({
      # remotes::download_github 会下载源码的 zip 或 tar.gz
      remotes::download_github(pkg_repo, destdir = TARGET_REPO_PATH)
    }, error = function(e) {
      cat("警告：下载 '", pkg_repo, "' 失败: ", e$message, "\n")
    })
  }
}

cat("\n所有包下载完成。\n")
