#' Run all checks against files
#'
#' Run all of the checks in the eesyscreener package against your data file and
#' associated metadata file. It takes in the paths to the CSV files then reads
#' and parses the files and runs the checks in multiple stages, the function
#' will return early if any check in a stage fails.
#'
#' @param datapath Path to the data CSV file
#' @param metapath Path to the meta CSV file
#' @param datafilename Optional - the name of the data file, if not given it
#' will be assumed from the path
#' @param metafilename Optional - the name of the metadata file, if not given
#' it will be assumed from the path
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
#' # Create temp files for the example
#' data_path <- file.path(tempdir(), "example.csv")
#' meta_path <- file.path(tempdir(), "example.meta.csv")
#'
#' data.table::fwrite(example_data, data_path)
#' data.table::fwrite(example_meta, meta_path)
#'
#' screen_csv(data_path, meta_path)
#'
#' screen_csv(
#'   data_path,
#'   meta_path,
#'   "data.csv",
#'   "data.meta.csv",
#'   output = "console"
#' )
#'
#' # Clean up temp files
#' file.remove(data_path)
#' file.remove(meta_path)
#' @export
screen_csv <- function(
  datapath,
  metapath,
  datafilename = NULL,
  metafilename = NULL,
  output = "table"
) {
  # TODO: Look into making the separate checks / stages run asynchronously

  # Validate inputs -----------------------------------------------------------
  if (!is.character(datapath) || length(datapath) != 1) {
    cli::cli_abort("`datapath` must be a single string.")
  }
  if (!is.character(metapath) || length(metapath) != 1) {
    cli::cli_abort("`metapath` must be a single string.")
  }

  validate_arg_output(output)

  # Read in CSV files ---------------------------------------------------------
  files <- read_ees_files(datapath, metapath)

  datafile <- files$data
  metafile <- files$meta

  # Check the filenames -------------------------------------------------------
  if (is.null(datafilename)) {
    datafilename <- normalizePath(datapath, winslash = "/") |>
      basename()
  }
  if (is.null(metafilename)) {
    metafilename <- normalizePath(metapath, winslash = "/") |>
      basename()
  }

  validate_arg_filenames(datafilename, metafilename)

  filename_results <- screen_filenames(
    datafilename,
    metafilename,
    output = output
  )

  if (output == "table") {
    if (any(filename_results[["result"]] == "FAIL")) {
      stage <- filename_results[["stage"]] |>
        unique()

      return(
        list(
          "results_table" = as.data.frame(filename_results),
          "overall_stage" = paste(stage, "checks"),
          "overall_message" = paste("Failed", stage, "checks")
        )
      )
    }
  }

  # Screen data.frames --------------------------------------------------------
  dataframe_results_full <- screen_dfs(datafile, metafile, output = output)

  if (output == "table") {
    dataframe_results <- dataframe_results_full$results_table

    all_results <- rbind(
      filename_results,
      dataframe_results
    )

    if (any(all_results[["result"]] == "FAIL")) {
      # We know only one group can fail at a time
      # Grab the group that has a fail
      stage <- all_results[
        all_results[["result"]] == "FAIL",
        "stage"
      ] |>
        unique()

      return(
        list(
          "results_table" = as.data.frame(all_results),
          "overall_stage" = paste(stage, "checks"),
          "overall_message" = paste("Failed", stage, "checks")
        )
      )
    }
  }

  # Success -------------------------------------------------------------------
  if (output == "console") {
    cli::cli_alert_success("Passed all checks")
  } else if (output == "table") {
    list(
      "results_table" = all_results,
      "overall_stage" = "Passed",
      "overall_message" = "Passed all checks"
    )
  }
}
