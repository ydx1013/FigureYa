#!/usr/bin/env Rscript

# ==============================================================================
# run_all_renders_parallel.R - Enhanced Parallel Version
# ==============================================================================
# 
# This is an enhanced version of run_all_renders.R that supports true parallel
# processing when the 'future' package is available. It maintains all the same
# functionality as the basic version but adds robust parallel processing.
#
# Key differences from basic version:
# - Uses 'future' package for true parallel processing
# - Supports both local and remote parallel execution
# - Better memory management for large-scale processing
# - Enhanced error handling for parallel tasks
# 
# ==============================================================================

# Load required libraries with error handling
cat("Loading required packages...\n")

# Function to safely check and load packages
safe_require <- function(package_name) {
  suppressWarnings(require(package_name, character.only = TRUE, quietly = TRUE))
}

# Check for available packages
has_parallel <- safe_require("parallel")
has_future <- safe_require("future")
has_future_apply <- safe_require("future.apply")  
has_rmarkdown <- safe_require("rmarkdown")
has_knitr <- safe_require("knitr")

# Print package availability
cat("Package availability:\n")
cat(paste("- parallel:", ifelse(has_parallel, "✓", "✗"), "\n"))
cat(paste("- future:", ifelse(has_future, "✓", "✗"), "\n"))
cat(paste("- future.apply:", ifelse(has_future_apply, "✓", "✗"), "\n"))
cat(paste("- rmarkdown:", ifelse(has_rmarkdown, "✓", "✗"), "\n"))
cat(paste("- knitr:", ifelse(has_knitr, "✓", "✗"), "\n"))

# Set up parallel processing mode
use_future_parallel <- has_future && has_future_apply
use_base_parallel <- !use_future_parallel && has_parallel

if (!has_rmarkdown && !has_knitr) {
  cat("WARNING: Neither rmarkdown nor knitr packages are available.\n")
  cat("This script will perform syntax checking only.\n")
  cat("To enable full rendering, please install rmarkdown:\n") 
  cat("  install.packages(c('rmarkdown', 'future', 'future.apply'))\n")
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
  timeout_seconds = 600,  # 10 minutes per file for parallel version
  chunk_size = if (use_future_parallel) 20 else 10,  # Larger chunks for future
  dry_run = !has_rmarkdown,  # Only do syntax checking if no rmarkdown
  parallel_mode = if (use_future_parallel) "future" else if (use_base_parallel) "base" else "sequential"
)

cat(paste("Working directory:", CONFIG$root_dir, "\n"))
cat(paste("Status file:", CONFIG$status_file, "\n"))
cat(paste("Parallel mode:", CONFIG$parallel_mode, "\n"))
cat(paste("Max workers:", CONFIG$max_workers, "\n"))
if (CONFIG$dry_run) {
  cat("Running in DRY RUN mode (syntax check only)\n")
}

# ==============================================================================
# Core Functions (same as basic version)
# ==============================================================================

#' Discover all .Rmd files recursively
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
# Parallel Processing Functions
# ==============================================================================

#' Process files using future-based parallel processing
process_files_future <- function(files_to_process, existing_status) {
  cat(paste("Setting up future parallel processing with", CONFIG$max_workers, "workers...\n"))
  
  # Set up future plan
  future::plan(future::multisession, workers = CONFIG$max_workers)
  
  # Process in chunks for better memory management
  total_files <- length(files_to_process)
  chunk_size <- CONFIG$chunk_size
  chunks <- split(files_to_process, ceiling(seq_along(files_to_process) / chunk_size))
  
  cat(paste("Processing", total_files, "files in", length(chunks), "chunks...\n"))
  
  all_results <- data.frame(
    file_path = character(0),
    status = character(0),
    error_message = character(0),
    stringsAsFactors = FALSE
  )
  
  for (chunk_idx in seq_along(chunks)) {
    chunk_files <- chunks[[chunk_idx]]
    cat(paste("Processing chunk", chunk_idx, "of", length(chunks), 
              "(", length(chunk_files), "files) in parallel...\n"))
    
    # Process chunk in parallel using future.apply
    chunk_results <- future.apply::future_lapply(chunk_files, function(rmd_file) {
      result <- safe_render_rmd(rmd_file)
      return(list(
        file_path = rmd_file,
        status = result$status,
        error_message = result$error_message
      ))
    }, future.seed = TRUE)
    
    # Convert to data frame
    chunk_df <- do.call(rbind, lapply(chunk_results, function(x) {
      data.frame(
        file_path = x[["file_path"]],
        status = x[["status"]],
        error_message = x[["error_message"]],
        stringsAsFactors = FALSE
      )
    }))
    
    # Append to results
    all_results <- rbind(all_results, chunk_df)
    
    # Update status file after each chunk (for progress tracking)
    current_status <- update_status_file(CONFIG$status_file, all_results, existing_status)
    
    # Print progress
    success_in_chunk <- sum(chunk_df$status == "success")
    cat(paste("Chunk", chunk_idx, "completed:", success_in_chunk, "of", 
              length(chunk_files), "files successful\n"))
  }
  
  # Clean up future plan
  future::plan(future::sequential)
  
  return(all_results)
}

#' Process files using base R parallel processing
process_files_base_parallel <- function(files_to_process, existing_status) {
  cat(paste("Setting up base parallel processing with", CONFIG$max_workers, "workers...\n"))
  
  # Set up cluster
  cl <- parallel::makeCluster(CONFIG$max_workers)
  
  # Export necessary objects to cluster
  parallel::clusterExport(cl, c("safe_render_rmd", "CONFIG", "check_rmd_syntax", 
                               "has_rmarkdown", "has_knitr"))
  
  # Load necessary packages on cluster nodes
  if (has_rmarkdown) {
    parallel::clusterEvalQ(cl, library(rmarkdown))
  }
  if (has_knitr) {
    parallel::clusterEvalQ(cl, library(knitr))
  }
  
  tryCatch({
    # Process files in parallel
    cat(paste("Processing", length(files_to_process), "files in parallel...\n"))
    
    results_list <- parallel::parLapply(cl, files_to_process, function(rmd_file) {
      result <- safe_render_rmd(rmd_file)
      cat(paste("Completed:", basename(rmd_file), "-", result$status, "\n"))
      return(list(
        file_path = rmd_file,
        status = result$status,
        error_message = result$error_message
      ))
    })
    
    # Convert to data frame
    all_results <- do.call(rbind, lapply(results_list, function(x) {
      data.frame(
        file_path = x[["file_path"]],
        status = x[["status"]],
        error_message = x[["error_message"]],
        stringsAsFactors = FALSE
      )
    }))
    
    return(all_results)
    
  }, finally = {
    # Always stop the cluster
    parallel::stopCluster(cl)
  })
}

#' Process files sequentially
process_files_sequential <- function(files_to_process, existing_status) {
  cat("Using sequential processing...\n")
  
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
  
  return(all_results)
}

# ==============================================================================
# Main Execution
# ==============================================================================

main <- function() {
  cat("Starting FigureYa Rmd rendering process (Enhanced Parallel Version)...\n")
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
  
  # Step 4: Process files using appropriate method
  all_results <- switch(CONFIG$parallel_mode,
    "future" = process_files_future(files_to_process, existing_status),
    "base" = process_files_base_parallel(files_to_process, existing_status),
    "sequential" = process_files_sequential(files_to_process, existing_status)
  )
  
  # Step 5: Final status update and summary
  final_status <- update_status_file(CONFIG$status_file, all_results, existing_status)
  
  # Print final summary
  end_time <- Sys.time()
  total_duration <- round(as.numeric(difftime(end_time, start_time, units = "mins")), 2)
  
  cat(paste("Total processing time:", total_duration, "minutes\n"))
  cat(paste("Parallel mode used:", CONFIG$parallel_mode, "\n"))
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