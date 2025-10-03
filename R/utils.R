#' Handle null filenames
#'
#' Helper function to handle null filenames and return a string for the
#' message.
#'
#' @param string filename in to be transformed
#' @keywords internal
#' @noRd
#' @returns string
null_filename <- function(string = NULL) {
  ifelse(is.null(string), "the tested data frame", paste0("'", string, "'"))
}

#' Create test output
#'
#' Helper function to handle the output from an individual test, gives us an
#' easier way to make changes in the future if we want to change the output
#' format.
#'
#' Made available to users for documentation purposes to illustrate the output
#' format of the checks.
#'
#' @param test_name name of the test being run
#' @param result result of the test being run
#' @param message message to be returned
#' @param guidance_url optional url for more information
#' @param output "table" will return a single row data frame for
#' combining multiple test outputs, "console" prints feedback messages to
#' console, "error-only" will only return errors or warnings if there's an
#' issue
#'
#' @keywords internal
#' @noRd
#'
#' @returns messages to the console giving feedback to the user or a single
#' row data frame
test_output <- function(
  test_name,
  result,
  message,
  guidance_url = NA,
  output
) {
  if (output == "table") {
    return(
      data.frame(
        "check" = test_name,
        "result" = result,
        "message" = message,
        "guidance_url" = guidance_url,
        stringsAsFactors = FALSE,
        row.names = NULL
      )
    )
  } else if (result == "PASS") {
    if (output == "console") {
      cli::cli_alert_success(message)
      return(invisible(NULL))
    }
  } else if (result == "WARNING") {
    cli::cli_warn(message)
    return(invisible(NULL))
  } else if (result == "FAIL") {
    cli::cli_abort(message)
  }
}
