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
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @keywords internal
#' @noRd
#'
#' @returns a single row data frame
test_output <- function(
  test_name,
  result,
  message,
  guidance_url = NA,
  verbose,
  stop_on_error
) {
  show_message <- (verbose) || (stop_on_error && result != "PASS")

  if (show_message) {
    if (result == "PASS") {
      cli::cli_alert_success(message)
    } else if (result == "WARNING") {
      if (stop_on_error) {
        cli::cli_warn(message)
      } else {
        cli::cli_alert_warning(message)
      }
    } else if (result == "FAIL") {
      if (stop_on_error) {
        cli::cli_abort(message)
      } else {
        cli::cli_alert_danger(message)
      }
    }
  }

  data.frame(
    "check" = test_name,
    "result" = result,
    "message" = message,
    "guidance_url" = guidance_url,
    row.names = NULL
  )
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

#' Validate logical argument
#'
#' Helper function to validate logical argument is logical
#'
#' @param logical logical argument to validate
#' @keywords internal
#' @noRd
#' @returns silently, error if logical option is incorrectly supplied
validate_arg_logical <- function(logical, name) {
  if (!is.logical(logical) || length(logical) != 1) {
    cli::cli_abort(
      sprintf("`%s` must be a single logical value.", name)
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
#' files <- read_ees_files(data_file, meta_file)
#' files
#'
#' # Clean up temp files
#' file.remove(data_file)
#' file.remove(meta_file)
#' @keywords internal
#' @noRd
read_ees_files <- function(datapath, metapath) {
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

  # Meta files are so small it's fastest to read using base R
  #             expr     min      lq     mean   median      uq     max neval
  # dt(example_meta)   891.9   955.6  1184.28  1048.10  1321.8  2093.3    10
  # readr(example_meta) 11232.2 11532.4 11999.88 11831.15 12604.4 12946.6  10
  # duck(example_meta)  1241.6  1259.5  1647.03  1404.40  1690.7  2915.3   10
  # base(example_meta)   514.8   528.3   675.26   590.30   616.3  1472.4   10
  metafile <- utils::read.csv(metapath)

  list(data = datafile, meta = metafile)
}

#' Get all column names referenced in metadata
#'
#' Get the names of all indicators, filters, and filter groups that are
#' referenced in the metadata.
#'
#' Assumes the col_name, and filter_grouping_column are present in the
#' metadata.
#'
#' @param meta data.frame of the metadata
#' @param grouping_cols logical, if TRUE will include filter grouping columns
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_cols_meta <- function(meta, grouping_cols = FALSE) {
  cols <- meta$col_name
  if (grouping_cols) {
    cols <- c(cols, meta$filter_grouping_column)
  }
  unique(cols[!is.na(cols) & cols != ""])
}

#' Get all column names referenced in metadata
#'
#' Get the names of all indicators, filters, and filter groups that are
#' referenced in the metadata.
#'
#' Assumes the col_name, and filter_grouping_column are present in the
#' metadata.
#'
#' @param meta data.frame of the metadata
#' @param grouping_cols logical, if TRUE will include filter grouping columns
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_acceptable_ob_units <- function() {
  geography_cols <- unlist(
    eesyscreener::geography_df[, c(
      "code_field",
      "name_field",
      "code_field_secondary"
    )],
    use.names = FALSE
  ) |>
    stats::na.omit()

  c(
    "time_period",
    "time_identifier",
    "geographic_level",
    geography_cols
  )
}

#' Check if any values are longer than a specified length
#'
#' Helper function to check if any values in a vector exceed a specified
#' length. Used for validating column names and values within columns.
#'
#' @param values character vector of values to check
#' @param max_length maximum allowed character length for values
#'
#' @returns a data.frame with columns 'value', 'length', and 'exceeds_max'
#' @keywords internal
#' @noRd
char_limits <- function(values, max_length) {
  lengths <- nchar(values)
  exceeds_max <- lengths > max_length

  data.frame(
    value = values,
    length = lengths,
    exceeds_max = exceeds_max
  )
}
