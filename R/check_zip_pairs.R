#' Check that data / meta pairs in the ZIP are complete
#'
#' When a names file is supplied, verifies that for each `file_name` stem in
#' `dataset_names.csv` both `{stem}.csv` and `{stem}.meta.csv` exist at the
#' root of the ZIP, and that every root-level data CSV (excluding
#' `dataset_names.csv`) is referenced in the names file.
#'
#' When `names_file_df` is `NULL` (single-pair lenient path), stems are
#' derived from the union of root-level data CSVs and `.meta.csv` files in
#' the ZIP, and each stem must have both halves present. This catches
#' mismatched stems like `a.csv` paired with `b.meta.csv`, and orphan
#' metadata files with no matching data file.
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
#' entries <- c(
#'   "a.csv", "a.meta.csv", "b.csv", "b.meta.csv", "dataset_names.csv"
#' )
#' names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
#' check_zip_pairs(entries, names_file)
#'
#' bad_names_file <- data.frame(
#'   file_name = c("a", "c"), dataset_name = c("A", "C")
#' )
#' check_zip_pairs(entries, bad_names_file)
#'
#' # Lenient single-pair path: stems must match
#' check_zip_pairs(c("a.csv", "a.meta.csv"), NULL)
#' check_zip_pairs(c("a.csv", "b.meta.csv"), NULL)
#' @export
check_zip_pairs <- function(
  file_entries,
  names_file_df,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  data_files_in_zip <- file_entries[
    grepl("\\.csv$", file_entries) &
      !grepl("\\.meta\\.csv$", file_entries) &
      file_entries != "dataset_names.csv"
  ]
  data_stems_in_zip <- sub("\\.csv$", "", data_files_in_zip)
  meta_files_in_zip <- file_entries[grepl("\\.meta\\.csv$", file_entries)]
  meta_stems_in_zip <- sub("\\.meta\\.csv$", "", meta_files_in_zip)

  if (is.null(names_file_df)) {
    stems <- union(data_stems_in_zip, meta_stems_in_zip)
    unlisted <- character(0)
    missing_data_label <- "Missing data file: "
    missing_meta_label <- "Missing metadata file: "
    pass_message <- "Data and metadata files are correctly paired."
    lenient_multi_pair <- length(stems) > 1
  } else {
    lenient_multi_pair <- FALSE
    stems <- names_file_df$file_name
    unlisted <- data_stems_in_zip[!data_stems_in_zip %in% stems]
    missing_data_label <- "Names file references missing data files: "
    missing_meta_label <- "Names file references missing metadata files: "
    pass_message <-
      "All data / meta pairs are correctly referenced in the names file."
  }

  missing_data <- stems[!paste0(stems, ".csv") %in% file_entries]
  missing_meta <- stems[!paste0(stems, ".meta.csv") %in% file_entries]

  if (
    length(missing_data) > 0 || length(missing_meta) > 0 || length(unlisted) > 0
  ) {
    msgs <- character(0)
    if (length(missing_data) > 0) {
      msgs <- c(
        msgs,
        paste0(
          missing_data_label,
          paste(paste0(missing_data, ".csv"), collapse = ", "),
          "."
        )
      )
    }
    if (length(missing_meta) > 0) {
      msgs <- c(
        msgs,
        paste0(
          missing_meta_label,
          paste(paste0(missing_meta, ".meta.csv"), collapse = ", "),
          "."
        )
      )
    }
    if (length(unlisted) > 0) {
      msgs <- c(
        msgs,
        paste0(
          "Data files not listed in names file: ",
          paste(paste0(unlisted, ".csv"), collapse = ", "),
          "."
        )
      )
    }
    return(test_output(
      test_name,
      "FAIL",
      paste(msgs, collapse = " "),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (lenient_multi_pair) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "Lenient single-pair path requires exactly one data / meta pair, ",
        "found ",
        length(stems),
        ". A dataset_names.csv names file is required for multiple pairs."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    pass_message,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
