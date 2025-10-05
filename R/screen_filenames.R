#' Run all checks against filenames
#'
#' Run all of the checks from the package that relate to the names of the files
#' themselves.
#'
#' Provide a pair of filenames, e.g. "myfile.csv" and "myfile.meta.csv" and it
#' will check they follow the filename conventions.
#'
#' @param datafilename Character string, name of the data file
#' @param metafilename Character string, name of the metadata file
#' @param output Control the format of output, either 'table', 'error-only', or
#' 'console'
#'
#' @return data.frame containing the results of the screening
#'
#' @examples
#' screen_filenames("myfile.csv", "myfile.meta.csv")
#' screen_filenames("myfile.csv", "mymeta.csv", output = "table")
#' @export
screen_filenames <- function(
  datafilename,
  metafilename,
  output = "console"
) {
  validate_arg_filenames(datafilename, metafilename)
  validate_arg_output(output)

  results <- rbind(
    check_filename_spaces(datafilename, "data", output = output),
    check_filename_spaces(metafilename, "metadata", output = output),
    check_filename_special(datafilename, "data", output = output),
    check_filename_special(metafilename, "metadata", output = output),
    check_filenames_match(datafilename, metafilename, output = output)
  )

  if (output == "console") {
    cli::cli_alert_success("Filenames passed all checks")
  } else if (output == "table") {
    results |>
      cbind(stage = "filename")
  }
}
