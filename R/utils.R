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
      return(invisible(NULL))
    }
  } else if (result == "WARNING") {
    cli::cli_warn(message)
    return(invisible(NULL))
  } else if (result == "FAIL") {
    cli::cli_abort(message)
  }
}

#' Validate filenames in function arguments
#'
#' Helper function to validate filename arguments are correct format
#'
#' @param datafilename data file filename
#' @param metafilename metadata file filename
#' @keywords internal
#' @noRd
#' @returns silently, error if filename is incorrectly supplied
validate_arg_filenames <- function(datafilename, metafilename) {
  if (!is.character(datafilename) || length(datafilename) != 1) {
    cli::cli_abort("`datafilename` must be a single string.")
  }
  if (!is.character(metafilename) || length(metafilename) != 1) {
    cli::cli_abort("`metafilename` must be a single string.")
  }
}

#' Validate data frames in function arguments
#'
#' Helper function to validate data object arguments are correct format
#'
#' @param datafile datafile object
#' @param metafile metadata object
#' @keywords internal
#' @noRd
#' @returns silently, error if data object is incorrectly supplied
validate_arg_dfs <- function(datafile, metafile) {
  if (!is.data.frame(datafile)) {
    cli::cli_abort("`datafile` must be a data frame.")
  }
  if (!is.data.frame(metafile)) {
    cli::cli_abort("`metafile` must be a data frame.")
  }
}

#' Validate output argument
#'
#' Helper function to validate output argument is one of the expected values
#'
#' @param output string representing the output type
#' @keywords internal
#' @noRd
#' @returns silently, error if output option is incorrectly supplied
validate_arg_output <- function(output) {
  if (is.null(output)) {
    cli::cli_abort(
      "`output` must be one of 'table', 'console', or 'error-only'."
    )
  }
  if (!(output %in% c("table", "console", "error-only"))) {
    cli::cli_abort(
      "`output` must be one of 'table', 'console', or 'error-only'."
    )
  }
}

#' Read in CSV files
#'
#' Helper for reading in CSV files in a standard way. Provides validation
#' that they are CSV files before reading.
#'
#' @param datapath Path to the data CSV file
#' @param metapath Path to the meta CSV file
#' @return a duckplyr data frame named 'data' and a data table named
#' 'meta'
#' @examples
#' # Create temp files for the example
#' data_file <- tempfile(fileext = ".csv")
#' meta_file <- tempfile(fileext = ".meta.csv")
#' data.table::fwrite(example_data, data_file)
#' data.table::fwrite(example_meta, meta_file)
#'
#' files <- read_files(data_file, meta_file)
#'
#' files
#'
#' # Clean up temp files
#' file.remove(data_file)
#' file.remove(meta_file)
#' @keywords internal
#' @noRd
read_files <- function(datapath, metapath) {
  # Check if files exist
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
      sprintf("Metadata file at %s does not have a CSV MIME type.", metapath)
    )
  }

  # Read in the CSV files -----------------------------------------------------
  # TODO: Add better handling for if there's issues reading the files
  # Lazy reading of data for speed
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

  list(data = datafile, meta = metafile)
}
