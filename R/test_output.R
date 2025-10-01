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
#' @param console (optional) if FALSE, will return a single row data frame for
#' combining multiple test outputs, otherwise prints feedback messages to
#' console, default is TRUE
#'
#' @returns messages to the console giving feedback to the user or a single
#' row data frame if console = FALSE
test_output <- function(
  test_name,
  result,
  message,
  guidance_url = NA,
  console = TRUE
) {
  if (!console) {
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
  } else {
    if (result == "PASS") {
      cli::cli_alert_success(message)
    } else if (result == "WARNING") {
      cli::cli_warn(message)
    } else {
      cli::cli_abort(message)
    }
  }
}
