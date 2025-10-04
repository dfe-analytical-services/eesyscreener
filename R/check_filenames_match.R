#' Check filenames line up between data and metadata files
#'
#' Making sure the data and metadata file follow the pattern of:
#' - datafile.csv (data file)
#' - datafile.meta.csv (metadata file)
#'
#' @param datafilename A character string of the data filename to check
#' @param metafilename A character string of the metadata filename to check
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @inherit check_filename_spaces return
#'
#' @family filename
#'
#' @examples
#' check_filenames_match("datafile.csv", "datafile.meta.csv")
#' check_filenames_match("datafile.csv", "metafile.csv", output = "table")
#' @export
check_filenames_match <- function(
  datafilename,
  metafilename,
  output = "console"
) {
  test_name <- "check_filenames_match"

  if (
    metafilename == stringr::str_replace(datafilename, "\\.csv", "\\.meta.csv")
  ) {
    return(
      test_output(
        test_name,
        "PASS",
        paste(
          "The names of the files follow the recommended naming",
          "convention."
        ),
        output = output
      )
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      paste0(
        "The filenames do not follow the recommended naming convention.",
        " Based on the given data filename, the metadata filename is ",
        "expected to be '",
        stringr::str_replace(datafilename, ".csv", ".meta.csv'"),
        "'."
      ),
      output = output
    )
  }
}
