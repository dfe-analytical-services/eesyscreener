#' Run all checks against files
#'
#' Run all of the checks in the eesyscreener package against your data file and
#' associated metadata file. It parses the files and runs the checks in four
#' stages, the function will return early if any check in a stage fails.
#'
#' @param datafilename The name of the data file.
#' @param metafilename The name of the metadata file.
#' @param datafile A data frame containing the data file contents.
#' @param metafile A data frame containing the metadata file contents.
#' @param api_only Logical value indicating whether to run only the API checks.
#' @return A list containing
#' 1. A table with the full results of the checks with four columns:
#' \itemize{
#'   \item result of the check (PASS / FAIL / ADVISORY)
#'   \item message giving feedback about the check
#'   \item stage that the check belongs to
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
    api_only = FALSE) {
  # TODO: Work out if the file reading comes in here or is handled separately
  # TODO: Look into making the separate checks run asynchronously

  # Stage 1 -----------------------------------------------------------------
  stage_1_results <- rbind(
    eesyscreener::check_filename_spaces(datafilename),
    eesyscreener::check_filename_spaces(metafilename),
    eesyscreener::check_empty_rows(datafile, datafilename),
    eesyscreener::check_empty_rows(metafile, metafilename)
  ) |>
    cbind(
      "stage" = 1
    )

  if (any(stage_1_results[["result"]] == "FAIL")) {
    output <- list(
      "results_table" = as.data.frame(stage_1_results),
      "stage" = "1",
      "message" = "Failed at stage 1"
    )

    return(output)
  }

  # Stage 2 -----------------------------------------------------------------
  # Up for debate whether we keep the stages or change the approach!

  # Success -----------------------------------------------------------------
  output <- list(
    "results_table" = as.data.frame(stage_1_results),
    "overall_stage" = "Passed",
    "overall_message" = "Passed all checks"
  )

  return(output)
}
