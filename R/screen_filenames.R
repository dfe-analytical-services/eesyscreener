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
#' @param log_key Keystring for creating log file. If given, the screening will
#' write a log file to disk called eesyscreening_log_<log_key>.json default=NULL
#' @param log_dir Directory within which to place the log file if `log_key` 
#' is given, default = "./"
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @return data.frame containing the results of the screening
#'
#' @examples
#' screen_filenames("myfile.csv", "myfile.meta.csv")
#' screen_filenames("myfile.csv", "mymeta.csv", verbose = TRUE)
#' @export
screen_filenames <- function(
  datafilename,
  metafilename,
  log_key = NULL,
  log_dir = "./",
  verbose = FALSE,
  stop_on_error = FALSE
) {
  validate_arg_filenames(datafilename, metafilename)
  validate_arg_logical(verbose, "verbose")
  validate_arg_logical(stop_on_error, "stop_on_error")

  results <- rbind(
    check_filename_spaces(
      datafilename,
      "data",
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    check_filename_spaces(
      metafilename,
      "metadata",
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    check_filename_special(
      datafilename,
      "data",
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    check_filename_special(
      metafilename,
      "metadata",
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    check_filenames_match(
      datafilename,
      metafilename,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  if (verbose) {
    cli::cli_alert_success("Filenames passed all checks")
  }

  results <- results |>
    cbind(stage = "filename")

  write_json_log(results, log_key = log_key, log_dir = log_dir)

  results
}
