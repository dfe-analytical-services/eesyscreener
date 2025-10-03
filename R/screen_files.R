#' Run all checks against files
#'
#' Run all of the checks in the eesyscreener package against your data file and
#' associated metadata file. It parses the files and runs the checks in four
#' stages, the function will return early if any check in a stage fails.
#'
#' @param datafilename The name of the data file
#' @param metafilename The name of the metadata file
#' @param datafile A data frame containing the data file contents
#' @param metafile A data frame containing the metadata file contents
#' @param output Control the format of output, either 'table', 'error-only', or
#' 'console'
#' @return Console messages or a list containing
#' 1. A table with the full results of the checks with four columns:
#' \itemize{
#'   \item result of the check (PASS / FAIL / ADVISORY)
#'   \item message giving feedback about the check
#'   \item group that the check belongs to
#'   \item name of the check
#' }
#' 2. Overall stage the checks reached
#' 3. Overall message to give back to the user
#' @examples
#' screen_files(
#'   "data.csv",
#'   "data.meta.csv",
#'   example_data,
#'   example_meta
#' )
#' @export

# TODO: Break out filenames checks separate?

screen_files <- function(
  datafilename,
  metafilename,
  datafile,
  metafile,
  output = "table"
) {
  if (!is.character(datafilename) || length(datafilename) != 1) {
    cli::cli_abort("`datafilename` must be a single string.")
  }
  if (!is.character(metafilename) || length(metafilename) != 1) {
    cli::cli_abort("`metafilename` must be a single string.")
  }
  if (!is.data.frame(datafile)) {
    cli::cli_abort("`datafile` must be a data.frame.")
  }
  if (!is.data.frame(metafile)) {
    cli::cli_abort("`metafile` must be a data.frame.")
  }
  if (!(output %in% c("table", "console", "error-only"))) {
    cli::cli_abort(
      "`output` must be one of 'table', 'console', or 'error-only'."
    )
  }

  # TODO: Look into making the separate checks / stages run asynchronously

  # Filename stage ------------------------------------------------------------
  filename_results <- rbind(
    check_filename_spaces(datafilename, "data", output = output),
    check_filename_spaces(metafilename, "metadata", output = output),
    check_filename_special(datafilename, "data", output = output),
    check_filename_special(metafilename, "metadata", output = output),
    check_filenames_match(datafilename, metafilename, output = output)
  )

  # If output is table there will be rows
  if (nrow(filename_results) > 0) {
    filename_results <- filename_results |>
      cbind(
        "stage" = "Filename tests"
      )

    if (any(filename_results[["result"]] == "FAIL")) {
      return(
        list(
          "results_table" = as.data.frame(filename_results),
          "overall_stage" = "Filename checks",
          "overall_message" = "Failed filename checks"
        )
      )
    }
  }

  # Precheck meta -------------------------------------------------------------
  precheck_meta_results <- rbind(
    precheck_meta_col_type(metafile, output = output)
  )

  # If output is table there will be rows
  if (nrow(precheck_meta_results) > 0) {
    precheck_meta_results <- precheck_meta_results |>
      cbind(
        "stage" = "Precheck meta"
      )

    if (any(precheck_meta_results[["result"]] == "FAIL")) {
      return(
        list(
          "results_table" = as.data.frame(precheck_meta_results),
          "overall_stage" = "Meta prechecks",
          "overall_message" = "Failed meta prechecks"
        )
      )
    }
  }

  # Success -------------------------------------------------------------------
  if (output == "console") {
    cli::cli_alert_success("Passed all checks")
  } else if (output == "table") {
    list(
      "results_table" = as.data.frame(
        rbind(
          filename_results
        )
      ),
      "overall_stage" = "Passed",
      "overall_message" = "Passed all checks"
    )
  }
}
