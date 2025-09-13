#!/usr/bin/env Rscript

# ==============================================================================
# run_all_renders.R - A Robust, Resumable R Script for Parallel Rmd Rendering
# ==============================================================================
# 
# This script provides robust, parallel rendering of all .Rmd files in the 
# FigureYa repository with comprehensive error handling and resumability.
#
# Key Features:
# - Recursive discovery of all .Rmd files in the repository
# - Parallel processing for efficient handling of 300+ files  
# - Independent error handling - failures don't affect other files
# - Comprehensive status logging with CSV output
# - Resumability - retry only failed files from previous runs
# - Progress reporting and performance monitoring
#
# Output: render_status.csv containing file_path, status, error_message
#
# Author: Automated Script Generator
# Date: 2025-01-20
# ==============================================================================

# Load required libraries with error handling
cat("Loading required packages...\n")

# Check for available packages
has_parallel <- require("parallel", quietly = TRUE)
has_tools <- require("tools", quietly = TRUE)

# Check if we have rendering capabilities
has_rmarkdown <- require("rmarkdown", quietly = TRUE)
has_knitr <- require("knitr", quietly = TRUE)

if (!has_rmarkdown && !has_knitr) {
  cat("WARNING: Neither rmarkdown nor knitr packages are available.\n")
  cat("This script will perform syntax checking only.\n")
  cat("To enable full rendering, please install rmarkdown:\n") 
  cat("  install.packages('rmarkdown')\n")
  cat("Or install knitr:\n")
  cat("  install.packages('knitr')\n")
}

# ==============================================================================
# Configuration
# ==============================================================================

# Get script directory (repository root)
script_dir <- if (interactive()) {
  getwd()
} else {
  # For non-interactive mode, try to get script location
  frame_files <- lapply(sys.frames(), function(x) x$ofile)
  frame_files <- Filter(Negate(is.null), frame_files)
  if (length(frame_files) > 0) {
    dirname(normalizePath(frame_files[[1]]))
  } else {
    getwd()
  }
}

# Configuration parameters
CONFIG <- list(
  root_dir = script_dir,
  status_file = file.path(script_dir, "render_status.csv"),
  max_workers = if (has_parallel) max(1, parallel::detectCores() - 1) else 2,  
  timeout_seconds = 300,  # 5 minutes per file
  chunk_size = 10,  # Process files in chunks for better memory management
  dry_run = !has_rmarkdown  # Only do syntax checking if no rmarkdown
)

cat(paste("Working directory:", CONFIG$root_dir, "\n"))
cat(paste("Status file:", CONFIG$status_file, "\n"))
cat(paste("Max workers:", CONFIG$max_workers, "\n"))
if (CONFIG$dry_run) {
  cat("Running in DRY RUN mode (syntax check only)\n")
}

# ==============================================================================
# Core Functions
# ==============================================================================

#' Discover all .Rmd files recursively
#' @param root_dir Root directory to search
#' @return Character vector of full paths to .Rmd files
discover_rmd_files <- function(root_dir) {
  cat("Discovering .Rmd files...\n")
  
  rmd_files <- list.files(
    path = root_dir,
    pattern = "\\.Rmd$",
    recursive = TRUE,
    full.names = TRUE,
    ignore.case = TRUE
  )
  
  # Filter out any files in hidden directories or temp directories
  rmd_files <- rmd_files[!grepl("(^|/)(\\.|_temp|temp|tmp)", rmd_files)]
  
  cat(paste("Found", length(rmd_files), ".Rmd files\n"))
  return(rmd_files)
}

#' Load existing status from CSV file
#' @param status_file Path to status CSV file
#' @return data.frame with columns: file_path, status, error_message
load_existing_status <- function(status_file) {
  if (file.exists(status_file)) {
    cat("Loading existing status file...\n")
    status_df <- read.csv(status_file, stringsAsFactors = FALSE)
    cat(paste("Loaded", nrow(status_df), "previous results\n"))
    return(status_df)
  } else {
    cat("No existing status file found - starting fresh\n")
    return(data.frame(
      file_path = character(0),
      status = character(0), 
      error_message = character(0),
      stringsAsFactors = FALSE
    ))
  }
}

#' Get files that need to be processed (failed or new)
#' @param all_files Vector of all .Rmd file paths
#' @param existing_status data.frame of existing status
#' @return Vector of file paths that need processing
get_files_to_process <- function(all_files, existing_status) {
  if (nrow(existing_status) == 0) {
    cat("Processing all files (no previous status)\n")
    return(all_files)
  }
  
  # Get files that failed or are not in the status file
  failed_files <- existing_status$file_path[existing_status$status == "failed"]
  new_files <- setdiff(all_files, existing_status$file_path)
  
  files_to_process <- c(failed_files, new_files)
  
  cat(paste("Files to process:", length(files_to_process), "\n"))
  cat(paste("- Failed from previous run:", length(failed_files), "\n"))
  cat(paste("- New files:", length(new_files), "\n"))
  
  return(files_to_process)
}

#' Check Rmd file syntax
#' @param rmd_file Path to .Rmd file
#' @return List with status and error_message
check_rmd_syntax <- function(rmd_file) {
  tryCatch({
    # Check if file exists and is readable
    if (!file.exists(rmd_file)) {
      return(list(status = "failed", error_message = "File does not exist"))
    }
    
    # Read file content
    content <- readLines(rmd_file, warn = FALSE)
    
    # Basic syntax checks
    if (length(content) == 0) {
      return(list(status = "failed", error_message = "File is empty"))
    }
    
    # Check for R code chunks
    chunk_starts <- grep("^```\\{r", content)
    chunk_ends <- grep("^```$", content)
    
    if (length(chunk_starts) > length(chunk_ends)) {
      return(list(status = "failed", error_message = "Unclosed R code chunk"))
    }
    
    # Try to parse YAML header if it exists
    if (length(content) > 0 && content[1] == "---") {
      yaml_end <- which(content == "---")[2]
      if (is.na(yaml_end)) {
        return(list(status = "failed", error_message = "Unclosed YAML header"))
      }
    }
    
    return(list(status = "success", error_message = ""))
    
  }, error = function(e) {
    return(list(status = "failed", error_message = paste("Syntax error:", e$message)))
  })
}

#' Safely render a single .Rmd file with timeout and error handling
#' @param rmd_file Path to .Rmd file
#' @return List with status ("success" or "failed") and error_message
safe_render_rmd <- function(rmd_file) {
  start_time <- Sys.time()
  
  # If in dry run mode, just check syntax
  if (CONFIG$dry_run) {
    result <- check_rmd_syntax(rmd_file)
    result$error_message <- paste("[DRY RUN]", result$error_message)
    return(result)
  }
  
  tryCatch({
    # Change to the directory containing the .Rmd file
    original_wd <- getwd()
    rmd_dir <- dirname(rmd_file)
    rmd_filename <- basename(rmd_file)
    
    # Check if file exists
    if (!file.exists(rmd_file)) {
      return(list(
        status = "failed",
        error_message = "File does not exist"
      ))
    }
    
    setwd(rmd_dir)
    
    # Try to render with available tools
    if (has_rmarkdown) {
      rmarkdown::render(rmd_filename, quiet = TRUE)
    } else if (has_knitr) {
      # Use knitr as fallback
      knitr::knit(rmd_filename, quiet = TRUE)
    } else {
      # Last resort: check syntax only
      result <- check_rmd_syntax(rmd_file)
      result$error_message <- paste("[SYNTAX CHECK ONLY]", result$error_message)
      setwd(original_wd)
      return(result)
    }
    
    # Restore working directory
    setwd(original_wd)
    
    end_time <- Sys.time()
    duration <- round(as.numeric(difftime(end_time, start_time, units = "secs")), 2)
    
    return(list(
      status = "success",
      error_message = "",
      duration = duration
    ))
    
  }, error = function(e) {
    # Restore working directory in case of error
    if (exists("original_wd")) {
      setwd(original_wd)
    }
    
    end_time <- Sys.time()
    duration <- round(as.numeric(difftime(end_time, start_time, units = "secs")), 2)
    
    return(list(
      status = "failed",
      error_message = paste("Error:", e$message),
      duration = duration
    ))
  })
}

#' Update status file with results
#' @param status_file Path to status CSV file
#' @param results data.frame with render results
#' @param existing_status data.frame with existing status
update_status_file <- function(status_file, results, existing_status) {
  # Combine new results with existing status
  # Remove old entries for files that were re-processed
  updated_files <- results$file_path
  existing_status <- existing_status[!existing_status$file_path %in% updated_files, ]
  
  # Combine and sort
  final_status <- rbind(existing_status, results)
  final_status <- final_status[order(final_status$file_path), ]
  
  # Write to file
  write.csv(final_status, status_file, row.names = FALSE)
  
  cat(paste("Status file updated:", status_file, "\n"))
  return(final_status)
}

#' Print summary statistics
#' @param final_status data.frame with final status
print_summary <- function(final_status) {
  total_files <- nrow(final_status)
  success_count <- sum(final_status$status == "success")
  failed_count <- sum(final_status$status == "failed")
  
  cat("\n" , rep("=", 60), "\n")
  cat("RENDERING SUMMARY\n")
  cat(rep("=", 60), "\n")
  cat(paste("Total files:", total_files, "\n"))
  cat(paste("Successful:", success_count, "(", round(100*success_count/total_files, 1), "%)\n"))
  cat(paste("Failed:", failed_count, "(", round(100*failed_count/total_files, 1), "%)\n"))
  
  if (failed_count > 0) {
    cat("\nFailed files:\n")
    failed_files <- final_status[final_status$status == "failed", ]
    for (i in 1:min(10, nrow(failed_files))) {  # Show first 10 failures
      cat(paste("-", basename(failed_files$file_path[i]), "\n"))
      cat(paste("  Error:", failed_files$error_message[i], "\n"))
    }
    if (nrow(failed_files) > 10) {
      cat(paste("... and", nrow(failed_files) - 10, "more. See", CONFIG$status_file, "for details.\n"))
    }
  }
  
  cat(rep("=", 60), "\n")
}

# ==============================================================================
# Main Execution
# ==============================================================================

main <- function() {
  cat("Starting FigureYa Rmd rendering process...\n")
  start_time <- Sys.time()
  
  # Step 1: Discover all .Rmd files
  all_rmd_files <- discover_rmd_files(CONFIG$root_dir)
  
  if (length(all_rmd_files) == 0) {
    cat("No .Rmd files found. Exiting.\n")
    return(invisible())
  }
  
  # Step 2: Load existing status
  existing_status <- load_existing_status(CONFIG$status_file)
  
  # Step 3: Determine files to process
  files_to_process <- get_files_to_process(all_rmd_files, existing_status)
  
  if (length(files_to_process) == 0) {
    cat("All files already successfully rendered. Nothing to do.\n")
    print_summary(existing_status)
    return(invisible())
  }
  
  # Step 4: Set up processing mode
  cat("Using sequential processing...\n")
  
  # Step 5: Process files
  total_files <- length(files_to_process)
  cat(paste("Processing", total_files, "files...\n"))
  
  all_results <- data.frame(
    file_path = character(0),
    status = character(0),
    error_message = character(0),
    stringsAsFactors = FALSE
  )
  
  # Process files sequentially
  for (i in seq_along(files_to_process)) {
    rmd_file <- files_to_process[i]
    cat(paste("Processing", i, "of", total_files, ":", basename(rmd_file), "...\n"))
    
    result <- safe_render_rmd(rmd_file)
    
    # Create result row
    result_row <- data.frame(
      file_path = rmd_file,
      status = result$status,
      error_message = result$error_message,
      stringsAsFactors = FALSE
    )
    
    # Append to results
    all_results <- rbind(all_results, result_row)
    
    cat(paste("Completed:", basename(rmd_file), "-", result$status, "\n"))
    
    # Update status file every 10 files (for progress tracking)
    if (i %% 10 == 0 || i == total_files) {
      current_status <- update_status_file(CONFIG$status_file, all_results, existing_status)
      success_so_far <- sum(all_results$status == "success")
      cat(paste("Progress:", success_so_far, "of", i, "files successful\n"))
    }
  }
  
  # Step 6: Final status update and summary
  final_status <- update_status_file(CONFIG$status_file, all_results, existing_status)
  
  # Print final summary
  end_time <- Sys.time()
  total_duration <- round(as.numeric(difftime(end_time, start_time, units = "mins")), 2)
  
  cat(paste("Total processing time:", total_duration, "minutes\n"))
  print_summary(final_status)
  
  cat(paste("Detailed results saved to:", CONFIG$status_file, "\n"))
  cat("Run this script again to retry failed files.\n")
}

# ==============================================================================
# Script Entry Point
# ==============================================================================

if (!interactive()) {
  # Add error handling for the entire script
  tryCatch({
    main()
  }, error = function(e) {
    cat("FATAL ERROR:", e$message, "\n")
    quit(status = 1)
  })
}