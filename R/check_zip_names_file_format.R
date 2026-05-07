#' Check that dataset_names.csv has the correct format
#'
#' Validates that the names file data frame has exactly the columns
#' `file_name` and `dataset_name` (in that order), is non-empty, contains no
#' NA values, and has no duplicate `file_name` entries.
#'
#' @param names_file_df A data frame read from `dataset_names.csv`.
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
#' good <- data.frame(file_name = "data", dataset_name = "My data")
#' check_zip_names_file_format(good)
#'
#' bad <- data.frame(file = "data", name = "My data")
#' check_zip_names_file_format(bad)
#' @export
check_zip_names_file_format <- function(
  names_file_df,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  required_cols <- c("file_name", "dataset_name")
  actual_cols <- names(names_file_df)

  # The length check guards against duplicates that leave the set unchanged,
  # e.g. c("file_name", "dataset_name", "file_name") — setequal() ignores
  # multiplicity and would return TRUE.
  if (!setequal(actual_cols, required_cols) || length(actual_cols) != 2) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "dataset_names.csv must have exactly the columns 'file_name' and ",
        "'dataset_name'. Found: ",
        paste(actual_cols, collapse = ", "),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (nrow(names_file_df) == 0) {
    return(test_output(
      test_name,
      "FAIL",
      "dataset_names.csv is empty.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (anyNA(names_file_df$file_name) || anyNA(names_file_df$dataset_name)) {
    return(test_output(
      test_name,
      "FAIL",
      "dataset_names.csv contains NA values.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  dupes <- names_file_df$file_name[duplicated(names_file_df$file_name)]
  if (length(dupes) > 0) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "dataset_names.csv has duplicate file_name values: ",
        paste(dupes, collapse = ", "),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    "dataset_names.csv has valid format.",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
