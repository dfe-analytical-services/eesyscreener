#' Check all required columns are present in data
#'
#' Using the `req_data_cols` object.
#'
#' @param data A data frame of the data file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_req_data(example_data)
#' precheck_col_req_data(example_data, verbose = TRUE)
#'
#' @export
precheck_col_req_data <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  missing_cols <- eesyscreener::req_data_cols[
    !eesyscreener::req_data_cols %in% names(data)
  ]

  if (length(missing_cols) == 0) {
    test_output(
      "col_req_data",
      "PASS",
      "All of the required columns are present in the data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(missing_cols) == 1) {
      test_output(
        "col_req_data",
        "FAIL",
        paste0(
          "The following required column is missing from the data file: '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_req_data",
        "FAIL",
        paste0(
          "The following required columns are missing from the data file:",
          " '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
