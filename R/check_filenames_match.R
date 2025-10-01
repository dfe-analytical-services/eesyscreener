#' Check filenames line up between data and metadata files
#'
#' Making sure the data and metadata file follow the pattern of:
#' - datafile.csv (data file)
#' - datafile.meta.csv (metadata file)
#'
#' @param datafilename A character string of the data filename to check
#' @param metafilename A character string of the metadata filename to check
#' @param verbose Logical, if TRUE then messages are printed to the console,
#' otherwise a data frame is returned so multiple results can be combined into
#' a single table. Default is TRUE
#'
#' @inherit check_empty_cols return
#'
#' @examples
#' check_filenames_match("datafile.csv", "datafile.meta.csv")
#' check_filenames_match("datafile.csv", "metafile.csv", verbose = FALSE)
#' @export
check_filenames_match <- function(
  datafilename,
  metafilename,
  verbose = TRUE
) {
  test_name <- "check_filenames_match"

  if (
    tools::file_ext(datafilename) != "csv" &&
      tools::file_ext(metafilename) != "csv"
  ) {
    return(
      test_output(
        test_name,
        "FAIL",
        paste(
          "Neither file is saved as a CSV. Please save your files as CSV's",
          "and re-upload."
        ),
        console = verbose
      )
    )
  } else {
    if (tools::file_ext(datafilename) != "csv") {
      return(
        test_output(
          test_name,
          "FAIL",
          paste(
            "The data file is not a CSV. Please save the file as a CSV and",
            "re-upload."
          ),
          console = verbose
        )
      )
    } else {
      if (tools::file_ext(metafilename) != "csv") {
        return(
          test_output(
            test_name,
            "FAIL",
            paste(
              "The metadata file is not a CSV. Please save the file as a CSV",
              "and re-upload."
            ),
            console = verbose
          )
        )
      } else {
        if (
          metafilename ==
            stringr::str_replace(datafilename, "\\.csv", "\\.meta.csv")
        ) {
          return(
            test_output(
              test_name,
              "PASS",
              paste(
                "The names of the files follow the recommended naming",
                "convention."
              ),
              console = verbose
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
            console = verbose
          )
        }
      }
    }
  }
}
