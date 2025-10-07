#' Check for spaces in filename
#'
#' This function checks if the provided filename contains any spaces.
#'
#' @param filename A character string of the filename to check
#' @param custom_name An optional character string to customize the test name
#' in the output
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @family filename
#'
#' @return a single row data frame
#'
#' @examples
#' check_filename_spaces("datafile.csv")
#' check_filename_spaces("data file.csv", verbose = TRUE)
#' check_filename_spaces("datafile.meta.csv", custom_name = "meta")
#' @export
check_filename_spaces <- function(
  filename,
  custom_name = NULL,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- paste0("check_filename_", custom_name, "_spaces")

  if (grepl(" ", filename)) {
    return(
      test_output(
        test_name,
        "FAIL",
        paste0(
          "There are spaces that need removing in '",
          filename,
          "' (filename)."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0("'", filename, "' does not have spaces in the filename."),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
