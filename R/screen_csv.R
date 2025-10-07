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
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
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
#'   verbose = TRUE
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
  verbose = FALSE,
  stop_on_error = FALSE
) {
  # TODO: Look into making the separate checks / stages run asynchronously

  # Validate inputs -----------------------------------------------------------
  if (!is.character(datapath) || length(datapath) != 1) {
    cli::cli_abort("`datapath` must be a single string.")
  }
  if (!is.character(metapath) || length(metapath) != 1) {
    cli::cli_abort("`metapath` must be a single string.")
  }

  validate_arg_logical(verbose, "verbose")
  validate_arg_logical(stop_on_error, "stop_on_error")

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
    verbose = verbose,
    stop_on_error = stop_on_error
  )

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

  # Screen data.frames --------------------------------------------------------
  dataframe_results <- screen_dfs(
    datafile,
    metafile,
    verbose = verbose,
    stop_on_error = stop_on_error
  )

  all_results <- rbind(filename_results, dataframe_results)

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

  # Success -------------------------------------------------------------------
  if (verbose) {
    cli::cli_alert_success("Passed all checks")
  }

  list(
    "results_table" = all_results,
    "overall_stage" = "Passed",
    "overall_message" = "Passed all checks"
  )
}
