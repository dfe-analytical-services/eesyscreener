#' Run all checks against files
#'
#' Run all of the checks in the eesyscreener package against your data file and
#' associated metadata file. It parses the files and runs the checks in four
#' stages, the function will return early if any check in a stage fails.
#'
#' @param api_only Logical value indicating whether to run only the API checks.
#' @return A table containing the full results of the checks with four columns:
#' \itemize{
#'   \item result of the check (PASS / FAIL / ADVISORY)
#'   \item message giving feedback about the check
#'   \item stage that the check belongs to
#'   \item name of the check
#' }
#'
#' @examples
#' eesyscreener::screen_files(
#'   eesyscreener::example_data,
#'   eesyscreener::example_metadata
#' )
#' @export
screen_files <- function(
    datafilename,
    metafilename,
    dataseparator,
    metaseparator,
    data_character,
    meta_character,
    datafile,
    metafile,
    api_only = FALSE) {

  # Stage 1 -----------------------------------------------------------------
  stage_1_results <- rbind(
    eesyscreener::check_filename_spaces(datafilename, "data"),
    eesyscreener::check_filename_spaces(metafilename, "metadata")
  ) |>
    cbind(
      "stage" = 1
    )

  if (any(stage_1_results[["result"]] == "FAIL")) {
    output <- list(
      "results_table" = stage_1_results,
      "stage" = "1",
      "message" = "Failed at stage 1"
    )

    return(output)
  }

  # Stage 2 -----------------------------------------------------------------


  # Stage 3 -----------------------------------------------------------------


  # Stage 4 -----------------------------------------------------------------


  # Success -----------------------------------------------------------------
  output <- list(
    "results_table" = rbind(
      stage_1_results
    ),
    "stage" = "Passed",
    "message" = "Passed all checks",
  )

  return(output)
}
