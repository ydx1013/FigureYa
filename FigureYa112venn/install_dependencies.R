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

# 专门处理colorfulVennPlot安装
install_colorfulVennPlot <- function() {
  if (is_package_installed("colorfulVennPlot")) {
    cat("colorfulVennPlot is already installed\n")
    return(TRUE)
  }
  
  cat("Attempting to install colorfulVennPlot...\n")
  
  # 方法1: 直接从GitHub安装
  tryCatch({
    if (!is_package_installed("remotes")) {
      install.packages("remotes")
    }
    remotes::install_github("yanlinlin82/colorfulVennPlot")
    if (is_package_installed("colorfulVennPlot")) {
      cat("Successfully installed colorfulVennPlot from GitHub\n")
      return(TRUE)
    }
  }, error = function(e) {
    cat("GitHub installation failed:", e$message, "\n")
  })
  
  # 方法2: 尝试安装旧版本（如果知道具体版本号）
  tryCatch({
    # 这里假设我们知道一个可用的版本号，或者尝试从存档安装
    remotes::install_version("colorfulVennPlot", version = "0.90")
    if (is_package_installed("colorfulVennPlot")) {
      cat("Successfully installed colorfulVennPlot from archive\n")
      return(TRUE)
    }
  }, error = function(e) {
    cat("Archive installation failed:", e$message, "\n")
  })
  
  # 方法3: 手动下载并安装
  tryCatch({
    # 尝试从CRAN存档下载
    download.file("https://cran.r-project.org/src/contrib/Archive/colorfulVennPlot/colorfulVennPlot_0.90.tar.gz", 
                  "colorfulVennPlot.tar.gz")
    install.packages("colorfulVennPlot.tar.gz", repos = NULL, type = "source")
    if (is_package_installed("colorfulVennPlot")) {
      cat("Successfully installed colorfulVennPlot from source\n")
      return(TRUE)
    }
  }, error = function(e) {
    cat("Source installation failed:", e$message, "\n")
  })
  
  # 如果所有方法都失败，安装替代包
  cat("All installation methods for colorfulVennPlot failed. Installing alternatives...\n")
  alternatives <- c("VennDiagram", "ggvenn", "nVennR", "eulerr")
  install_cran_packages(alternatives)
  
  # 检查是否有替代包安装成功
  any_alternative <- any(sapply(alternatives, is_package_installed))
  if (any_alternative) {
    installed_alts <- alternatives[which(sapply(alternatives, is_package_installed))]
    cat("Installed alternative Venn packages:", paste(installed_alts, collapse=", "), "\n")
    return(FALSE)  # 返回FALSE表示原包未安装，但有替代方案
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
  "remotes",
  "ggvenn", "nVennR", "eulerr"  # Venn图替代方案
)
install_cran_packages(cran_packages)

# --- Step 2: 专门处理colorfulVennPlot ---
cat("\nHandling colorfulVennPlot installation...\n")
colorfulVennPlot_installed <- install_colorfulVennPlot()

# --- Step 3: 验证安装 ---
cat("\nVerifying package installation...\n")

# 核心CRAN包验证
core_packages <- c("Cairo", "RColorBrewer", "dplyr", "ggplot2")
all_core_installed <- TRUE

for (pkg in core_packages) {
  if (is_package_installed(pkg)) {
    cat("✓", pkg, "is installed\n")
  } else {
    cat("✗", pkg, "FAILED to install\n")
    all_core_installed = FALSE
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

# 提供使用替代包的建议
if (!colorfulVennPlot_installed && venn_installed) {
  cat("\nNote: colorfulVennPlot could not be installed, but alternatives are available.\n")
  cat("You may need to modify your R script to use one of these alternatives:\n")
  cat("- VennDiagram: Similar functionality, widely used\n")
  cat("- ggvenn: ggplot2-based Venn diagrams\n")
  cat("- nVennR: Interactive Venn diagrams\n")
  cat("- eulerr: Euler diagrams (proportional Venn diagrams)\n")
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

# 提供修改R脚本的建议
if (!colorfulVennPlot_installed) {
  cat("\nTo use alternative Venn packages, you might need to modify your R script:\n")
  cat("1. Replace 'library(colorfulVennPlot)' with 'library(VennDiagram)' or another alternative\n")
  cat("2. Adjust function calls according to the alternative package's syntax\n")
  cat("3. Check package documentation for equivalent functionality\n")
}
