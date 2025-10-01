#' Check for spaces in filename
#'
#' This function checks if the provided filename contains any spaces.
#'
#' @param filename A character string of the filename to check
#' @param custom_name An optional character string to customize the test name
#' in the output
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @family filename
#'
#' @return a console message with feedback from the check or a single row data
#' frame if verbose = FALSE
#'
#' @examples
#' check_filename_spaces("datafile.csv")
#' check_filename_spaces("data file.csv", output = "table")
#' check_filename_spaces("datafile.meta.csv", custom_name = "meta")
#' @export
check_filename_spaces <- function(
  filename,
  custom_name = NULL,
  output = "console"
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
        output = output
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0("'", filename, "' does not have spaces in the filename."),
      output = output
    )
  }
}
