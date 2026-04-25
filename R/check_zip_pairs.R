#' Check that all data / meta pairs in the names file exist in the ZIP
#'
#' For each `file_name` stem in `dataset_names.csv`, verifies that both
#' `{stem}.csv` and `{stem}.meta.csv` are present at the root of the ZIP.
#' Also verifies that every root-level data CSV (excluding `dataset_names.csv`)
#' is referenced in the names file. Returns FAIL if any file is missing or
#' unlisted.
#'
#' Orphan `.meta.csv` files (metadata with no matching data file) are not
#' detected here — that is handled by `check_zip_no_unreferenced()`.
#'
#' @param file_entries A character vector of file paths as returned by
#'   `zip::zip_list(zippath)$filename`.
#' @param names_file_df A data frame read from `dataset_names.csv` with columns
#'   `file_name` and `dataset_name`. Each `file_name` is a stem (without
#'   `.csv` extension).
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
#' @export
check_zip_pairs <- function(
  file_entries,
  names_file_df,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  stems <- names_file_df$file_name

  missing_data <- stems[!paste0(stems, ".csv") %in% file_entries]
  missing_meta <- stems[!paste0(stems, ".meta.csv") %in% file_entries]

  data_files_in_zip <- file_entries[
    grepl("\\.csv$", file_entries) &
      !grepl("\\.meta\\.csv$", file_entries) &
      file_entries != "dataset_names.csv"
  ]
  data_stems_in_zip <- sub("\\.csv$", "", data_files_in_zip)
  unlisted <- data_stems_in_zip[!data_stems_in_zip %in% stems]

  if (
    length(missing_data) > 0 || length(missing_meta) > 0 || length(unlisted) > 0
  ) {
    msgs <- character(0)
    if (length(missing_data) > 0) {
      msgs <- c(
        msgs,
        paste0(
          "Names file references missing data files: ",
          paste(paste0(missing_data, ".csv"), collapse = ", "),
          "."
        )
      )
    }
    if (length(missing_meta) > 0) {
      msgs <- c(
        msgs,
        paste0(
          "Names file references missing metadata files: ",
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

  test_output(
    test_name,
    "PASS",
    "All data / meta pairs are correctly referenced in the names file.",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
