# FigureYa 批量渲染脚本 / FigureYa Batch Rendering Script

## 概述 / Overview

`run_all_renders.R` 是一个健壮的、可续跑的 R 脚本，专门设计用于并行渲染 FigureYa 代码库中所有的 `.Rmd` 文件（超过 300 个）。该脚本最大化任务成功率，并为失败的任务提供简单的重试机制。

`run_all_renders.R` is a robust, resumable R script designed for parallel rendering of all `.Rmd` files in the FigureYa repository (300+ files). It maximizes task success rate and provides simple retry mechanisms for failed tasks.

## 核心功能 / Key Features

### 1. 文件发现 / File Discovery
- 递归扫描整个代码库，自动发现所有 `.Rmd` 文件
- 过滤掉隐藏目录和临时文件
- Recursively scans the entire codebase to discover all `.Rmd` files
- Filters out hidden directories and temporary files

### 2. 并行处理 / Parallel Processing  
- 使用 R 的并行处理能力同时渲染多个文件
- 自动检测可用核心数，预留一个核心给系统
- Uses R's parallel processing capabilities to render multiple files simultaneously
- Automatically detects available cores, reserves one core for the system

### 3. 独立错误处理 / Independent Error Handling
- 每个文件的渲染任务完全独立
- 单个文件失败不会影响其他文件的处理
- 超时保护机制防止单个文件占用过多时间
- Each file's rendering task is completely independent
- Single file failures don't affect other file processing  
- Timeout protection prevents single files from taking too much time

### 4. 状态记录与日志 / Status Logging
- 生成详细的状态日志文件 `render_status.csv`
- 包含文件路径、状态（成功/失败）和错误信息
- 实时更新进度，支持中断恢复
- Generates detailed status log file `render_status.csv`
- Contains file path, status (success/failed), and error messages
- Real-time progress updates with interruption recovery support

### 5. 断点续跑功能 / Resumability
- 自动检测已有的状态日志文件
- 只重新处理失败的文件和新添加的文件
- 完美支持中断后继续执行
- Automatically detects existing status log files
- Only reprocesses failed files and newly added files
- Perfect support for continuing after interruption

## 使用方法 / Usage

### 基本运行 / Basic Usage

```bash
# 在 FigureYa 根目录下运行
# Run in the FigureYa root directory
Rscript run_all_renders.R
```

### 或者在 R 中运行 / Or run within R

```r
# 加载并运行脚本
# Load and run the script
source("run_all_renders.R")
main()
```

## 系统要求 / System Requirements

### 必需包 / Required Packages
- `rmarkdown` - 用于渲染 .Rmd 文件 / For rendering .Rmd files
- `parallel` - 并行处理（可选）/ Parallel processing (optional)

### 安装依赖包 / Install Dependencies
```r
install.packages(c("rmarkdown", "parallel"))
```

### 系统要求 / System Requirements
- R >= 4.0.0
- 足够的内存处理大量文件 / Sufficient memory for handling many files
- 对于 Unix 系统，推荐安装 `timeout` 命令 / For Unix systems, `timeout` command recommended

## 输出文件 / Output Files

### `render_status.csv`
状态日志文件，包含三列：
Status log file with three columns:

| 列名 / Column | 描述 / Description |
|--------------|-------------------|
| `file_path` | .Rmd 文件的完整路径 / Full path to .Rmd file |
| `status` | 渲染状态：`success` 或 `failed` / Render status: `success` or `failed` |
| `error_message` | 错误信息（成功时为空）/ Error message (empty for success) |

## 运行模式 / Running Modes

### 1. 完整渲染模式 / Full Rendering Mode
当安装了 `rmarkdown` 包时，脚本将执行完整的 .Rmd 文件渲染
When `rmarkdown` package is installed, full .Rmd rendering is performed

### 2. 语法检查模式 / Syntax Check Mode  
当缺少渲染包时，脚本将执行基本的语法检查
When rendering packages are missing, basic syntax checking is performed

## 脚本特性 / Script Features

### 自动恢复 / Auto Recovery
```bash
# 首次运行 - 处理所有文件
# First run - processes all files
Rscript run_all_renders.R

# 再次运行 - 只处理失败的文件
# Second run - only processes failed files  
Rscript run_all_renders.R
```

### 进度监控 / Progress Monitoring
脚本提供实时进度更新：
The script provides real-time progress updates:

```
Processing 50 of 323 files...
Progress: 45 of 50 files successful
```

### 错误报告 / Error Reporting
详细的错误报告和汇总统计：
Detailed error reporting and summary statistics:

```
RENDERING SUMMARY
Total files: 323
Successful: 319 (98.8%)
Failed: 4 (1.2%)

Failed files:
- FigureYa145target.Rmd
  Error: [DRY RUN] Unclosed R code chunk
```

## 配置选项 / Configuration Options

脚本内部的配置参数：
Internal script configuration parameters:

```r
CONFIG <- list(
  max_workers = max(1, parallel::detectCores() - 1),  # 并行工作线程数 / Parallel workers
  timeout_seconds = 300,  # 单文件超时时间（秒）/ Per-file timeout (seconds)
  chunk_size = 10  # 批处理大小 / Batch processing size
)
```

## 故障排除 / Troubleshooting

### 常见问题 / Common Issues

1. **缺少 rmarkdown 包 / Missing rmarkdown package**
   ```
   WARNING: Neither rmarkdown nor knitr packages are available.
   ```
   **解决方案 / Solution**: `install.packages("rmarkdown")`

2. **内存不足 / Insufficient memory**
   - 减少并行工作线程数 / Reduce parallel workers
   - 增加系统内存 / Increase system memory

3. **文件权限问题 / File permission issues**
   - 确保对输出目录有写权限 / Ensure write permissions to output directory
   - 检查 .Rmd 文件的读权限 / Check read permissions for .Rmd files

### 日志分析 / Log Analysis

检查失败的文件：
Check failed files:

```bash
# 查看失败的文件数量
# Count failed files
grep "failed" render_status.csv | wc -l

# 查看具体失败原因  
# View specific failure reasons
grep "failed" render_status.csv | head -5
```

## 性能优化 / Performance Optimization

### 并行设置 / Parallel Settings
- 默认使用 CPU 核心数 - 1 / Default uses CPU cores - 1
- 可以手动调整 `max_workers` 参数 / Can manually adjust `max_workers` parameter

### 内存管理 / Memory Management
- 使用分块处理避免内存溢出 / Uses chunked processing to avoid memory overflow
- 定期更新状态文件释放内存 / Regularly updates status file to free memory

## 扩展功能 / Extended Features

### 自定义过滤器 / Custom Filters
可以修改脚本以添加文件过滤规则：
Script can be modified to add file filtering rules:

```r
# 只处理特定目录的文件
# Only process files from specific directories
rmd_files <- rmd_files[grepl("FigureYa[1-9][0-9]", rmd_files)]
```

### 自定义渲染选项 / Custom Rendering Options
可以为不同文件设置不同的渲染参数：
Different rendering parameters can be set for different files:

```r
# 根据文件名选择输出格式
# Choose output format based on filename
output_format <- if(grepl("report", rmd_file)) "pdf_document" else "html_document"
```

## 版本历史 / Version History

- **v1.0** (2025-01-20): 初始版本，支持基本的并行渲染和续跑功能
- **v1.0** (2025-01-20): Initial version with basic parallel rendering and resumability

## 许可证 / License

本脚本遵循与 FigureYa 项目相同的许可证。
This script follows the same license as the FigureYa project.

## 贡献 / Contributing

欢迎提交问题报告和功能建议！
Issues and feature requests are welcome!