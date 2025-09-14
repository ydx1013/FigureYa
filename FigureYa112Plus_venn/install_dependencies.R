#!/usr/bin/env Rscript
# This script installs all required R packages for this project

# Set up mirrors for better download performance
options("repos" = c(CRAN = "https://cloud.r-project.org/"))
options(timeout = 600)  # 增加超时时间

# Function to check if a package is installed
is_package_installed <- function(package_name) {
  return(package_name %in% rownames(installed.packages()))
}

# Function to install CRAN packages (vectorized)
install_cran_packages <- function(packages) {
  # Filter out already installed packages
  packages_to_install <- packages[!sapply(packages, is_package_installed)]
  if (length(packages_to_install) == 0) {
    cat("All required CRAN packages are already installed.\n")
    return()
  }
  
  for (pkg in packages_to_install) {
    cat("Installing CRAN package:", pkg, "\n")
    tryCatch({
      install.packages(pkg, dependencies = TRUE)
      cat("Successfully installed:", pkg, "\n")
    }, error = function(e) {
      cat("Failed to install CRAN package ", pkg, ": ", e$message, "\n")
      # 不要停止，继续安装其他包
    })
  }
}

# 改进的GitHub包安装函数
install_github_safe <- function(repo, max_retries = 3) {
  pkg_name <- basename(repo)
  
  if (is_package_installed(pkg_name)) {
    cat("Package already installed:", pkg_name, "\n")
    return(TRUE)
  }
  
  for (attempt in 1:max_retries) {
    cat("Attempt", attempt, "of", max_retries, "- Installing", repo, "from GitHub...\n")
    
    tryCatch({
      # 确保remotes包已安装
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      
      # 使用remotes而不是devtools，更稳定
      remotes::install_github(repo, quiet = FALSE, upgrade = "never")
      cat("Successfully installed", pkg_name, "from GitHub\n")
      return(TRUE)
      
    }, error = function(e) {
      cat("Attempt", attempt, "failed:", e$message, "\n")
      
      # 如果是JSON错误，可能是GitHub API限制，等待后重试
      if (grepl("JSON", e$message) || grepl("API", e$message)) {
        wait_time <- attempt * 10  # 递增等待时间
        cat("Waiting", wait_time, "seconds before retry...\n")
        Sys.sleep(wait_time)
      }
    })
  }
  
  cat("All attempts failed for", repo, "\n")
  return(FALSE)
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install system dependencies ---
cat("\nChecking system dependencies...\n")
# rgeos需要libgeos-dev，已经在工作流中安装

# --- Step 2: Install CRAN Packages ---
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "export", "ggplot2", "openxlsx", "stringr", "devtools", "remotes",
  "rgeos", "sf", "VennDiagram"  # 添加备选方案
)
install_cran_packages(cran_packages)

# --- Step 3: 尝试安装ggVennDiagram ---
cat("\nInstalling ggVennDiagram...\n")

# 方法1: 首先尝试从GitHub安装
success <- install_github_safe("gaospecial/ggVennDiagram")

if (!success) {
  cat("GitHub installation failed, trying alternative approaches...\n")
  
  # 方法2: 尝试安装CRAN上的替代包
  cat("Trying alternative Venn diagram packages from CRAN...\n")
  alternative_packages <- c("VennDiagram", "ggvenn", "nVennR")
  install_cran_packages(alternative_packages)
  
  # 方法3: 尝试直接下载安装
  cat("Trying direct download...\n")
  tryCatch({
    # 尝试从CRAN镜像下载
    install.packages("https://cran.r-project.org/src/contrib/Archive/ggVennDiagram/ggVennDiagram_0.1.0.tar.gz", 
                    repos = NULL, type = "source")
    cat("Successfully installed ggVennDiagram from archive\n")
  }, error = function(e) {
    cat("Direct download also failed:", e$message, "\n")
  })
}

# --- Step 4: 验证安装 ---
cat("\nVerifying package installation...\n")
required_packages <- c("export", "ggplot2", "openxlsx", "stringr", "rgeos")

all_installed <- TRUE
for (pkg in required_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "FAILED to install\n")
    all_installed <- FALSE
  }
}

# 检查ggVennDiagram或替代方案
venn_packages <- c("ggVennDiagram", "VennDiagram", "ggvenn")
venn_installed <- any(sapply(venn_packages, is_package_installed))

if (venn_installed) {
  cat("✓ At least one Venn diagram package is installed:", 
      paste(venn_packages[which(sapply(venn_packages, is_package_installed))], collapse=", "), "\n")
} else {
  cat("✗ No Venn diagram packages installed\n")
  all_installed <- FALSE
}

cat("\n===========================================\n")
if (all_installed && venn_installed) {
  cat("Package installation completed successfully!\n")
} else {
  cat("Package installation completed with some warnings.\n")
  cat("You may need to manually install missing packages.\n")
}
cat("You can now run your R scripts in this directory.\n")
