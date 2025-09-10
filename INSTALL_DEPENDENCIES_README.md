# R Package Dependencies Installation Scripts

This repository now contains automatically generated `install_dependencies.R` scripts for each subdirectory containing R Markdown (.Rmd) files.

## What was done

- **Scanned all subdirectories** containing .Rmd files (323 .Rmd files found across 314 directories)
- **Extracted R package dependencies** from all `library()` and `require()` calls in R code blocks
- **Generated 304 install_dependencies.R scripts** - one for each directory containing .Rmd files with identifiable package dependencies

## Features of the generated scripts

Each `install_dependencies.R` script provides:

1. **Automatic package detection**: Checks if packages are already installed before attempting installation
2. **Smart source handling**: Automatically separates CRAN and Bioconductor packages
3. **Mirror configuration**: Uses Chinese mirrors for better download performance:
   - CRAN: `https://mirrors.tuna.tsinghua.edu.cn/CRAN/`
   - Bioconductor: `http://mirrors.tuna.tsinghua.edu.cn/bioconductor/`
4. **Error handling**: Graceful error handling with informative messages
5. **Executable scripts**: All scripts are made executable with proper shebang

## How to use

To install dependencies for any project, simply navigate to the directory and run:

```bash
# Make sure the script is executable
chmod +x install_dependencies.R

# Run the installation script
Rscript install_dependencies.R
```

Or directly:
```bash
./install_dependencies.R
```

## Script structure

Each generated script follows this pattern:

1. Sets up CRAN and Bioconductor mirrors
2. Defines helper functions for package installation
3. Installs CRAN packages first
4. Installs Bioconductor packages (if any)
5. Provides status feedback throughout the process

## Dependencies extraction method

The extraction process identified packages from:
- Direct `library(package)` calls
- `require(package)` calls with various parameter combinations
- Package vector definitions like `c("pkg1", "pkg2")`
- Installation commands in code blocks

## Bioconductor packages detected

The script automatically identifies common Bioconductor packages including:
- DESeq2, edgeR, limma
- ComplexHeatmap, EnhancedVolcano
- GenomicRanges, Biostrings, BSgenome
- TCGAbiolinks, maftools
- clusterProfiler, fgsea, GSVA
- And many more...

## Notes

- Scripts are designed to be idempotent - safe to run multiple times
- Packages are only installed if not already present
- All installation includes dependencies automatically
- Scripts work in GitHub Actions and other automated environments