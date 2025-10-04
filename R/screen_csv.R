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
#' data_file <- tempfile(fileext = ".csv")
#' meta_file <- tempfile(fileext = ".meta.csv")
#'
#' data.table::fwrite(example_data, data_file)
#' data.table::fwrite(example_meta, meta_file)
#'
#' output <- screen_csv(
#'   data_file,
#'   meta_file,
#'   "data.csv",
#'   "data.meta.csv"
#' )
#'
#' # Clean up temp files
#' file.remove(data_file)
#' file.remove(meta_file)
#' @export
screen_csv <- function(
  datapath,
  metapath,
  datafilename,
  metafilename,
  output = "table"
) {
  # Validate inputs -----------------------------------------------------------
  # Set the filenames from the filepath if not given
  if (!is.character(datapath) || length(datapath) != 1) {
    cli::cli_abort("`datapath` must be a single string.")
  }
  if (!is.character(metapath) || length(metapath) != 1) {
    cli::cli_abort("`metapath` must be a single string.")
  }
  if (missing(datafilename) || is.null(datafilename)) {
    datafilename <- basename(datapath)
  }
  if (missing(metafilename) || is.null(metafilename)) {
    metafilename <- basename(metapath)
  }
  if (!is.character(datafilename) || length(datafilename) != 1) {
    cli::cli_abort("`datafilename` must be a single string.")
  }
  if (!is.character(metafilename) || length(metafilename) != 1) {
    cli::cli_abort("`metafilename` must be a single string.")
  }
  if (!(output %in% c("table", "console", "error-only"))) {
    cli::cli_abort(
      "`output` must be one of 'table', 'console', or 'error-only'."
    )
  }

  # Read in the CSV files -----------------------------------------------------
  # Check if files exist before reading
  if (!file.exists(datapath)) {
    cli::cli_abort(sprintf("No file found at %s", datapath))
  }
  if (!file.exists(metapath)) {
    cli::cli_abort(sprintf("No file found at %s", metapath))
  }

  # Check if files are CSV files based on MIME type (if possible)
  # Use 'mime' package if available, otherwise fall back to extension check
  data_mime <- mime::guess_type(datapath)
  meta_mime <- mime::guess_type(metapath)
  if (!identical(data_mime, "text/csv")) {
    cli::cli_abort(
      sprintf("Data file at %s does not have a CSV MIME type.", datapath)
    )
  }
  if (!identical(meta_mime, "text/csv")) {
    cli::cli_abort(
      sprintf("Meta file at %s does not have a CSV MIME type.", metapath)
    )
  }

  # Lazy reading of files for speed
  datafile <- duckplyr::read_csv_duckdb(datapath)

  # Meta files are small enough it's faster to read straight to memory
  metafile <- data.table::fread(
    metapath,
    sep = ",",
    header = TRUE,
    encoding = "UTF-8",
    strip.white = FALSE,
    showProgress = FALSE
  )

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
