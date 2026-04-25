#' Check that a ZIP file contains a dataset_names.csv names file when required
#'
#' A `dataset_names.csv` names file is required whenever the ZIP contains more
#' than one data / meta pair. A ZIP with exactly one data / meta pair is
#' accepted without a names file (lenient single-pair path). Returns FAIL when
#' multiple pairs are present and no names file is found.
#'
#' @param file_entries A character vector of file paths as returned by
#'   `zip::zip_list(zippath)$filename`.
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
#' check_zip_names_file_presence(c("a.csv", "a.meta.csv", "dataset_names.csv"))
#' check_zip_names_file_presence(c("a.csv", "a.meta.csv"))
#' check_zip_names_file_presence(
#'   c("a.csv", "a.meta.csv", "b.csv", "b.meta.csv")
#' )
#' @export
check_zip_names_file_presence <- function(
  file_entries,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  has_names_file <- "dataset_names.csv" %in% file_entries

  if (has_names_file) {
    return(test_output(
      test_name,
      "PASS",
      "dataset_names.csv names file is present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  data_files <- file_entries[
    grepl("\\.csv$", file_entries) & !grepl("\\.meta\\.csv$", file_entries)
  ]
  meta_files <- file_entries[grepl("\\.meta\\.csv$", file_entries)]

  if (length(data_files) == 1 && length(meta_files) == 1) {
    return(test_output(
      test_name,
      "PASS",
      paste0(
        "No dataset_names.csv names file found. ",
        "Permitted for a single data / meta pair."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "FAIL",
    paste0(
      "dataset_names.csv names file is missing. ",
      "A names file is required when the ZIP contains ",
      "more than one data / meta pair."
    ),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
