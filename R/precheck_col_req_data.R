#' Check all required columns are present in data
#'
#' Using the `req_data_cols` object.
#'
#' @param data A data frame of the data file
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_req_data(example_data)
#' precheck_col_req_data(example_data, output = "table")
#' @export
precheck_col_req_data <- function(data, output = "console") {
  missing_cols <- eesyscreener::req_data_cols[
    !eesyscreener::req_data_cols %in% names(data)
  ]

  if (length(missing_cols) == 0) {
    test_output(
      "col_req_data",
      "PASS",
      "All of the required columns are present in the data file.",
      output = output
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
        output = output
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
        output = output
      )
    }
  }
}
