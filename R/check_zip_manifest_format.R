#' Check that dataset_names.csv has the correct format
#'
#' Validates that the manifest data frame has exactly the columns
#' `file_name` and `dataset_name` (in that order), is non-empty, contains no
#' NA values, and has no duplicate `file_name` entries.
#'
#' @param manifest_df A data frame read from `dataset_names.csv`.
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
#' check_zip_manifest_format(good)
#'
#' bad <- data.frame(file = "data", name = "My data")
#' check_zip_manifest_format(bad)
#' @export
check_zip_manifest_format <- function(
  manifest_df,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  required_cols <- c("file_name", "dataset_name")

  if (!identical(names(manifest_df), required_cols)) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "dataset_names.csv must have exactly the columns 'file_name' and ",
        "'dataset_name' (in that order). Found: ",
        paste(names(manifest_df), collapse = ", "), "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (nrow(manifest_df) == 0) {
    return(test_output(
      test_name,
      "FAIL",
      "dataset_names.csv is empty.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (anyNA(manifest_df$file_name) || anyNA(manifest_df$dataset_name)) {
    return(test_output(
      test_name,
      "FAIL",
      "dataset_names.csv contains NA values.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  dupes <- manifest_df$file_name[duplicated(manifest_df$file_name)]
  if (length(dupes) > 0) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "dataset_names.csv has duplicate file_name values: ",
        paste(dupes, collapse = ", "), "."
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
