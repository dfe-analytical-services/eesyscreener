#' Run all checks against files
#'
#' Run all of the checks in the eesyscreener package against your data file and
#' associated metadata file. It takes in the paths to the CSV files then reads
#' and parses the files and runs the checks in multiple stages, the function
#' will return early if any check in a stage fails.
#'
#' Currently if the data file is smaller than 5 MB it will be read fully into
#' memory as a data frame, and over 5 MB it will be read lazily using duckdb
#' to avoid memory issues and speed up the processing of large files.
#'
#' @param datapath Path to the data CSV file
#' @param metapath Path to the meta CSV file
#' @param datafilename Optional - the name of the data file, if not given it
#' will be assumed from the path
#' @param metafilename Optional - the name of the metadata file, if not given
#' it will be assumed from the path
#' @inheritParams screen_dfs
#'
#' @return A list containing
#' 1. A table with the full results of the checks with four columns:
#' \itemize{
#'   \item result of the check (PASS / FAIL / WARNING)
#'   \item message giving feedback about the check
#'   \item group that the check belongs to
#'   \item name of the check
#' }
#' 2. Overall stage the checks reached
#' 3. Boolean indicating if the data passed the screening
#' 4. Boolean indicating if the data is suitable for the API
#'
#' If the files cannot be read (e.g. file not found, unsupported encoding, or
#' non-CSV format), the function returns early with `passed = FALSE` and
#' `overall_stage = "File read"` rather than throwing an error.
#' @examples
#' # Create temp files for the example
#' data_path <- file.path(tempdir(), "example.csv")
#' meta_path <- file.path(tempdir(), "example.meta.csv")
#'
#' write.csv(example_data, data_path, row.names = FALSE)
#' write.csv(example_meta, meta_path, row.names = FALSE)
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
#' invisible(file.remove(data_path))
#' invisible(file.remove(meta_path))
#' @export
screen_csv <- function(
  datapath,
  metapath,
  datafilename = NULL,
  metafilename = NULL,
  log_key = NULL,
  log_dir = "./",
  dd_checks = TRUE,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  # TODO: Look into making the separate checks / stages run asynchronously

  # Validate inputs -----------------------------------------------------------
  if (!is.character(datapath) || length(datapath) != 1) {
    cli::cli_abort(
      sprintf(
        "`datapath` must be a single string: %s.",
        paste(datapath, collapse = ", ")
      )
    )
  }
  if (!is.character(metapath) || length(metapath) != 1) {
    cli::cli_abort(
      sprintf(
        "`metapath` must be a single string: %s.",
        paste(metapath, collapse = ", ")
      )
    )
  }

  validate_arg_logical(verbose, "verbose")
  validate_arg_logical(stop_on_error, "stop_on_error")

  if (!is.null(log_key) && !is.null(log_dir)) {
    log_file <- paste0("eesyscreener_log_", log_key, ".json")
    log_path <- file.path(log_dir, log_file)
    if (file.exists(log_path)) {
      warning(
        paste0(
          "Log file already exists, the default is currently",
          " to append distinct results."
        )
      )
    }
  }

  data_file_size <- file.info(datapath)$size

  file_details_log <- list(
    filename = datafilename,
    filesize = paste(
      (data_file_size / 10^6) |> round(digits = 3),
      "MB"
    )
  )

  # Use plain dplyr for small CSV files under 5 MB to avoid duckdb overhead
  use_duckdb <- data_file_size >= 5 * 1024^2

  write_json_log(
    results = NULL,
    log_key = log_key,
    log_dir = log_dir,
    file_details = file_details_log
  )

  # Read in CSV files ---------------------------------------------------------
  files <- tryCatch(
    read_ees_files(datapath, metapath, use_duckdb = use_duckdb),
    error = function(e) e
  )

  if (inherits(files, "error")) {
    return(
      list(
        "results_table" = data.frame(
          check = "file_read",
          result = "FAIL",
          message = conditionMessage(files),
          guidance_url = NA_character_,
          stage = "File read",
          row.names = NULL
        ),
        "overall_stage" = "File read",
        "passed" = FALSE,
        "api_suitable" = FALSE
      )
    )
  }

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
    log_key = log_key,
    log_dir = log_dir,
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
        "passed" = FALSE,
        "api_suitable" = FALSE
      )
    )
  }

  # Screen data.frames --------------------------------------------------------
  dataframe_results <- screen_dfs(
    datafile,
    metafile,
    log_key = log_key,
    log_dir = log_dir,
    dd_checks = dd_checks,
    verbose = verbose,
    stop_on_error = stop_on_error,
    use_duckdb = use_duckdb
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
        "passed" = FALSE,
        "api_suitable" = FALSE
      )
    )
  }

  # Success -------------------------------------------------------------------
  api_pass <- all(
    all_results[all_results[["stage"]] == "Check API", "result"] == "PASS"
  )

  if (api_pass && verbose) {
    cli::cli_alert_success("Data and metadata passed all checks")
  } else if (verbose) {
    cli::cli_alert_info(
      paste(
        "Data and metadata passed, but warnings prevent it being suitable for",
        "the API"
      )
    )
  }

  list(
    "results_table" = all_results,
    "overall_stage" = "Passed",
    "passed" = TRUE,
    "api_suitable" = api_pass
  )
}
