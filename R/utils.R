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
    }
  } else if (result == "WARNING") {
    cli::cli_warn(message)
  } else if (result == "FAIL") {
    cli::cli_abort(message)
  }
}

#' Group and handle test results for a stage
#'
#' Utility function to group test results, add a stage column, and optionally
#' return early if failures are found.
#'
#' @param ... Data frames or test result objects to combine (via rbind)
#' @param stage Character. The name of the stage to assign to the results
#' @param output Character. Output mode, e.g. "table" or "console"
#' @param fail_message Character. Message to return if any result == "FAIL"
#' @param return_on_fail Logical. If TRUE, returns a list immediately on
#' failure. Default TRUE
#' @returns Data frame of results, or a list if failures are found and
#' return_on_fail is TRUE
test_group <- function(
  ...,
  stage,
  output = "console",
  fail_message = NULL,
  return_on_fail = TRUE
) {
  # Collect all arguments into a list
  args_list <- list(...)

  # Validate that each argument is a single row data.frame
  for (i in seq_along(args_list)) {
    arg <- args_list[[i]]
    if (!is.data.frame(arg) || nrow(arg) != 1) {
      stop(
        sprintf("Argument %d is not a single row data.frame.", i),
       call. = FALSE
       )
    }
  }

  # Combine all data frames into one
  results <- do.call(rbind, args_list)
  if (nrow(results) > 0) {
    results <- cbind(results, stage = stage)
    if (
      !is.null(output) &&
        output == "table" &&
        any(results[["result"]] == "FAIL") &&
        return_on_fail
    ) {
      return(list(
        results_table = as.data.frame(results),
        stage = stage,
        message = if (!is.null(fail_message)) {
          fail_message
        } else {
          paste("Failed", stage)
        }
      ))
    }
  }
  results
}
