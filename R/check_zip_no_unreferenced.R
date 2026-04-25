#' Check that the ZIP contains no unreferenced files
#'
#' When a names file is present, the only allowed files are `dataset_names.csv`
#' plus `{stem}.csv` and `{stem}.meta.csv` for each `file_name` stem in the
#' names file. When no names file is present (single-pair lenient path,
#' indicated by `names_file_df = NULL`), the only allowed files are the single
#' data CSV and its paired `.meta.csv`. Any other file — including OS artefacts
#' (`.DS_Store`, `__MACOSX/`), README files, orphan metadata, or stray CSVs
#' — causes a FAIL.
#'
#' @param file_entries A character vector of file paths as returned by
#'   `zip::zip_list(zippath)$filename`.
#' @param names_file_df A data frame read from `dataset_names.csv` with columns
#'   `file_name` and `dataset_name`, or `NULL` for the single-pair lenient
#'   path.
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_zip_readable return
#'
#' @family check_zip
#'
#' @examples
#' entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
#' names_file <- data.frame(file_name = "a", dataset_name = "A")
#' check_zip_no_unreferenced(entries, names_file)
#'
#' # Single-pair lenient path (no names file)
#' check_zip_no_unreferenced(c("a.csv", "a.meta.csv"), NULL)
#'
#' # Stray file causes FAIL
#' check_zip_no_unreferenced(c("a.csv", "a.meta.csv", "readme.txt"), NULL)
#' @export
check_zip_no_unreferenced <- function(
  file_entries,
  names_file_df,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  if (is.null(names_file_df)) {
    data_files <- file_entries[
      grepl("\\.csv$", file_entries) & !grepl("\\.meta\\.csv$", file_entries)
    ]
    meta_files <- file_entries[grepl("\\.meta\\.csv$", file_entries)]
    allowed <- c(data_files, meta_files)
  } else {
    stems <- names_file_df$file_name
    allowed <- c(
      "dataset_names.csv",
      paste0(stems, ".csv"),
      paste0(stems, ".meta.csv")
    )
  }

  # Directory entries (trailing slash) are normalised for comparison
  is_dir_entry <- grepl("/$", file_entries)
  normalized <- sub("/$", "", file_entries)

  unreferenced <- normalized[!normalized %in% allowed & !is_dir_entry]

  if (length(unreferenced) > 0) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "ZIP contains unreferenced files: ",
        paste(unreferenced, collapse = ", "),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    "No unreferenced files found in the ZIP.",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
