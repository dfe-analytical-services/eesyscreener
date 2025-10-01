#' Check for spaces in filename
#'
#' This function checks if the provided filename contains any spaces.
#'
#' @param filename A character string of the filename to check
#' @param custom_name An optional character string to customize the test name
#' in the output
#' @param verbose Logical, if TRUE then messages are printed to the console,
#' otherwise a data frame is returned so multiple results can be combined into
#' a single table. Default is TRUE
#'
#' @inherit check_empty_cols return
#'
#' @examples
#' check_filename_spaces("datafile.csv")
#' check_filename_spaces("data file.csv", verbose = FALSE)
#' check_filename_spaces("datafile.meta.csv", custom_name = "meta")
#' @export
check_filename_spaces <- function(
  filename,
  custom_name = NULL,
  verbose = TRUE
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
        console = verbose
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0("'", filename, "' does not have spaces in the filename."),
      console = verbose
    )
  }
}
