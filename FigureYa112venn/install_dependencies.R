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
      cat("Warning: Failed to install CRAN package ", pkg, ": ", e$message, "\n")
      # 不要停止，继续安装其他包
    })
  }
}

# 安全的GitHub包安装函数
install_github_safe <- function(repo, max_retries = 3) {
  pkg_name <- basename(repo)
  
  if (is_package_installed(pkg_name)) {
    cat("Package already installed:", pkg_name, "\n")
    return(TRUE)
  }
  
  # 首先检查是否有可用的CRAN替代方案
  cran_alternatives <- list(
    "colorfulVennPlot" = c("VennDiagram", "ggvenn", "nVennR", "eulerr")
  )
  
  if (pkg_name %in% names(cran_alternatives)) {
    cat("Checking for CRAN alternatives for", pkg_name, "...\n")
    alternatives <- cran_alternatives[[pkg_name]]
    available_alternatives <- alternatives[sapply(alternatives, is_package_installed)]
    
    if (length(available_alternatives) > 0) {
      cat("Using CRAN alternative:", available_alternatives[1], "instead of", pkg_name, "\n")
      return(TRUE)
    }
  }
  
  # 如果必须从GitHub安装，尝试多次
  for (attempt in 1:max_retries) {
    cat("Attempt", attempt, "of", max_retries, "- Installing", repo, "from GitHub...\n")
    
    tryCatch({
      # 确保remotes包已安装（比devtools更稳定）
      if (!is_package_installed("remotes")) {
        install.packages("remotes")
      }
      
      # 使用remotes安装
      remotes::install_github(repo, quiet = FALSE, upgrade = "never")
      cat("Successfully installed", pkg_name, "from GitHub\n")
      return(TRUE)
      
    }, error = function(e) {
      cat("Attempt", attempt, "failed:", e$message, "\n")
      
      # 如果是GitHub API限制错误，等待后重试
      if (grepl("401", e$message) || grepl("Rate limit", e$message) || grepl("GitHub", e$message)) {
        wait_time <- attempt * 30  # 递增等待时间（30, 60, 90秒）
        cat("GitHub API limit reached. Waiting", wait_time, "seconds before retry...\n")
        Sys.sleep(wait_time)
      }
    })
  }
  
  cat("All GitHub attempts failed for", repo, "\n")
  
  # 如果GitHub安装失败，尝试安装CRAN替代方案
  if (pkg_name %in% names(cran_alternatives)) {
    cat("Installing CRAN alternatives for", pkg_name, "...\n")
    install_cran_packages(cran_alternatives[[pkg_name]])
  }
  
  return(FALSE)
}

cat("Starting R package installation...\n")
cat("===========================================\n")

# --- Step 1: Install CRAN Packages ---
cat("\nInstalling CRAN packages...\n")
cran_packages <- c(
  "Cairo", "RColorBrewer", "VennDiagram", 
  "dplyr", "ggplot2", "grDevices", "magrittr", "purrr", "readr", 
  "stringr", "tibble", "tidyr",
  "remotes",  # 使用remotes而不是devtools
  "ggvenn", "nVennR", "eulerr"  # 添加Venn图替代方案
)
install_cran_packages(cran_packages)

# --- Step 2: 尝试安装GitHub包 ---
cat("\nInstalling GitHub packages...\n")

# 尝试安装colorfulVennPlot（但优先使用CRAN替代方案）
success <- install_github_safe("yanlinlin82/colorfulVennPlot")

# --- Step 3: 验证安装 ---
cat("\nVerifying package installation...\n")

# 核心CRAN包验证
core_packages <- c("Cairo", "RColorBrewer", "VennDiagram", "dplyr", "ggplot2")
all_core_installed <- TRUE

for (pkg in core_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "FAILED to install\n")
    all_core_installed <- FALSE
  }
}

# Venn图包验证
venn_packages <- c("colorfulVennPlot", "VennDiagram", "ggvenn", "nVennR", "eulerr")
venn_installed <- any(sapply(venn_packages, is_package_installed))

if (venn_installed) {
  installed_venn <- venn_packages[which(sapply(venn_packages, is_package_installed))]
  cat("✓ Venn diagram package(s) installed:", paste(installed_venn, collapse=", "), "\n")
} else {
  cat("✗ No Venn diagram packages installed\n")
}

cat("\n===========================================\n")
if (all_core_installed && venn_installed) {
  cat("Package installation completed successfully!\n")
  cat("You can now run your R scripts in this directory.\n")
} else if (venn_installed) {
  cat("Package installation completed with warnings.\n")
  cat("Some core packages failed, but Venn diagram functionality is available.\n")
  cat("You can try to run your R scripts.\n")
} else {
  cat("Package installation completed with significant warnings.\n")
  cat("You may need to manually install missing packages.\n")
}
