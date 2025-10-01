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
#' @param api_only Logical value indicating whether to run only the API checks
#' @return A list containing
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
screen_files <- function(
  datafilename,
  metafilename,
  datafile,
  metafile,
  api_only = FALSE
) {
  # TODO: Look into making the separate checks / stages run asynchronously

  # Filename stage ------------------------------------------------------------
  filename_results <- rbind(
    check_filename_spaces(datafilename, "data", verbose = FALSE),
    check_filename_spaces(metafilename, "metadata", verbose = FALSE),
    check_filename_special(datafilename, "data", verbose = FALSE),
    check_filename_special(metafilename, "metadata", verbose = FALSE),
    check_filenames_match(datafilename, metafilename, verbose = FALSE)
  ) |>
    cbind(
      "stage" = "Filename tests"
    )

  if (any(filename_results[["result"]] == "FAIL")) {
    output <- list(
      "results_table" = as.data.frame(filename_results),
      "stage" = "Filename checks",
      "message" = "Failed filename checks"
    )

    return(output)
  }

  # General stage -------------------------------------------------------------
  general_results <- rbind(
    # Placeholder data frame to allow rbind
    data.frame(
      "check" = "placeholder_general",
      "result" = "PASS",
      "message" = "Placeholder",
      "guidance_url" = NA,
      stringsAsFactors = FALSE
    )
  ) |>
    cbind(
      "stage" = "General file tests"
    )

  if (any(general_results[["result"]] == "FAIL")) {
    output <- list(
      "results_table" = as.data.frame(general_results),
      "stage" = "General file checks",
      "message" = "Failed general file checks"
    )

    return(output)
  }

  # Success -------------------------------------------------------------------
  output <- list(
    "results_table" = as.data.frame(
      rbind(
        filename_results,
        general_results
      )
    ),
    "overall_stage" = "Passed",
    "overall_message" = "Passed all checks"
  )

  return(output)
}
