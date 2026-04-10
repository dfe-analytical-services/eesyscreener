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
#' that they are CSV (or gzipped CSV) files before reading.
#'
#' @param datapath Path to the data CSV (or gzipped CSV) file
#' @param metapath Path to the meta CSV (or gzipped CSV) file
#' @return a duckplyr data frame named 'data' and a data table named
#' 'meta'
#' @examples
#' # Create temp files for the example
#' data_file <- tempfile(fileext = ".csv")
#' meta_file <- tempfile(fileext = ".meta.csv")
#' write.csv(example_data, data_file, row.names = FALSE)
#' write.csv(example_meta, meta_file, row.names = FALSE)
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
  if (
    !identical(data_mime, "text/csv") &&
      !identical(data_mime, "application/gzip")
  ) {
    cli::cli_abort(
      sprintf(
        paste0(
          "Data file at %s does not have a CSV or GZIP MIME type.",
          "\nMIME type found: %s"
        ),
        datapath,
        data_mime
      )
    )
  }
  if (
    !identical(meta_mime, "text/csv") &&
      !identical(data_mime, "application.gzip")
  ) {
    cli::cli_abort(
      sprintf(
        paste0(
          "Meta data file at %s does not have a CSV or GZIP",
          " MIME type.\nMIME type found: %s"
        ),
        metapath,
        meta_mime
      )
    )
  }

  # Read in the CSV files -----------------------------------------------------
  # TODO: Add better handling for if there's issues reading the files

  # Check number of columns in data file in order to be able to set them all as
  # VARCHAR on the actual read in:
  n_data_cols <- datapath |>
    duckplyr::read_csv_duckdb(prudence = "thrifty") |>
    dplyr::tbl_vars() |>
    length()

  # Lazy reading of data for speed
  # Setting all columns to VARCHAR as everything can basically contain a
  # character (i.e. indicators often contain x, c, z, etc)
  datafile <- datapath |>
    duckplyr::read_csv_duckdb(
      options = list(
        types = list(rep("VARCHAR", n_data_cols)),
        quote = '"'
      )
    )

  # Issue with read.csv falling over when handed files from Azure, so using
  # ...duckplyr as a safer reading in method
  # Metadata is always tiny so reading fully into memory for simplicity and
  # ...avoiding fallbacks from duckdb
  metafile <- duckplyr::read_csv_duckdb(metapath) |>
    dplyr::collect()

  list(data = datafile, meta = metafile)
}

#' Write out CSV files
#'
#' Helper for writing out CSV files in a standard way. Provides some standard
#' cleaning for writing
#' data frame contents to CSV to handle things like NAs.
#'
#' @param data Data to be written out
#' @param meta Meta to be written out
#' @param outdir Output path
#' @param stub String for the filename stub
#' @return List of the file paths
#' @examples
#' # Create temp files for the example
#' temp_dir <- tempdir()
#' write_ees_files(
#'   example_data, example_meta, outdir = temp_dir, stub = "example"
#' )
#'
#' # Clean up temp files
#' file.remove(path(temp_dir, paste0("example.csv")))
#' file.remove(path(temp_dir, paste0("example.meta.csv")))
#' @keywords internal
#' @noRd
write_ees_files <- function(data, meta, outdir, stub) {
  # Check if directory exist
  if (!dir.exists(outdir)) {
    cli::cli_abort(sprintf("No directory found at %s", outdir))
  }

  data_path <- file.path(outdir, paste0(stub, ".csv"))
  meta_path <- file.path(outdir, paste0(stub, ".meta.csv"))

  readr::write_csv(data, data_path)
  # Clean up any issues in the meta
  meta <- meta |>
    dplyr::mutate(
      dplyr::across(dplyr::everything(), as.character),
      dplyr::across(dplyr::everything(), ~ dplyr::if_else(is.na(.), "", .))
    )
  readr::write_csv(meta, meta_path)
  # Output the file paths
  list(
    data_path = data_path,
    meta_path = meta_path
  )
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
#' @param excl_indicators logical, if TRUE will exclude indicators
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_cols_meta <- function(
  meta,
  grouping_cols = FALSE,
  excl_indicators = FALSE
) {
  if (excl_indicators) {
    meta <- meta |>
      dplyr::filter(.data$col_type != "Indicator")
  }
  cols <- meta$col_name
  if (grouping_cols) {
    cols <- c(cols, meta$filter_grouping_column)
  }

  cols |>
    remove_nas_blanks() |>
    unique()
}

#' Get all acceptable observation unit columns
#'
#' Gets the names of all acceptable observation unit columns, including time and
#' geographic identifiers.
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
    remove_nas_blanks()

  c(
    "time_period",
    "time_identifier",
    "geographic_level",
    geography_cols
  )
}

#' Get all geographic code columns
#'
#' Gets the names of all geographic code columns from the geography dataframe
#'
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_geo_code_cols <- function() {
  c(
    eesyscreener::geography_df$code_field,
    eesyscreener::geography_df$code_field_secondary
  ) |>
    remove_nas_blanks() |>
    unique()
}

#' Get all geographic name columns
#'
#' Gets the names of all geographic name columns from the geography dataframe
#'
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_geo_name_cols <- function() {
  eesyscreener::geography_df$name_field |>
    remove_nas_blanks() |>
    unique()
}

#' Get all filter grouping columns
#'
#' Gets the names of all filter grouping columns from the metadata
#'
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_filter_groups <- function(meta) {
  meta |>
    dplyr::pull("filter_grouping_column") |>
    remove_nas_blanks()
}

#' Get all filter and filter grouping columns
#'
#' Gets the names of all filter and filter grouping columns from the metadata
#'
#' @param include_filter_groups logical, if TRUE will include filter grouping
#' columns, if FALSE will only return filter columns, defaults to FALSE
#' @keywords internal
#' @noRd
#' @returns character vector of column names
get_filters <- function(meta, include_filter_groups = FALSE) {
  filter_cols <- meta |>
    dplyr::filter(.data$col_type == "Filter") |>
    dplyr::pull("col_name")

  if (!include_filter_groups) {
    return(filter_cols)
  }

  c(filter_cols, get_filter_groups(meta))
}

#' Remove NAs and blank strings from a vector
#'
#' Can be used at the end of a pipe to remove both NA values and blank strings.
#'
#' This is generally used to filter out valid blank values to allow the checks
#' to only look at anything that wouldn't be read as blank by EES.
#'
#' @param vector A vector
#' @returns The input with NAs and blank strings removed
#' @keywords internal
#' @noRd
remove_nas_blanks <- function(vector) {
  if (is.vector(vector)) {
    vector[!is.na(vector) & vector != ""]
  } else {
    stop("Input must be a vector.")
  }
}

#' Write eesyscreener results to log file
#'
#' @param results list of resuts returned by eesyscreener checks
#' @param file_details list of file details to pass to the log. Can include
#' filename and filesize
#' @param data_details list of data details to pass to the log. Can include
#' ncols and nrows
#' @inheritParams screen_dfs
#' @returns NULL
#' @keywords internal
#' @noRd
write_json_log <- function(
  results,
  log_key = NULL,
  log_dir = NULL,
  file_details = list(filename = NULL, filesize = NULL),
  data_details = list(nrows = NULL, ncols = NULL)
) {
  if (!is.null(log_key) && !is.null(log_dir)) {
    log_file <- paste0("eesyscreener_log_", log_key, ".json")
    log_path <- file.path(log_dir, log_file)
    if (file.exists(log_path)) {
      log <- jsonlite::read_json(log_path, simplifyVector = TRUE)
      if (!is.null(log$results)) {
        log_results <- log$results
        # TODO: See if I can remove this relatively hacky workaround
        # to make tests pass
        if ("guidance_url" %in% names(log_results)) {
          log_results$guidance_url[log_results$guidance_url == "NA"] <- NA
        }
        results <- log_results |>
          rbind(results) |>
          dplyr::distinct()
      }
      log$progress <- nrow(results) / nrow(eesyscreener::example_output) * 100.
      log$log_time <- Sys.time()
      log$results <- results
      if (!is.null(file_details$filename)) {
        log$filename <- file_details$filename
      }
      if (!is.null(file_details$filesize)) {
        log$filesize <- file_details$filesize
      }
      if (!is.null(data_details$nrows)) {
        log$nrows <- data_details$nrows
      }
      if (!is.null(data_details$ncols)) {
        log$ncols <- data_details$ncols
      }
    } else {
      log <- list(
        progress = nrow(results) / nrow(eesyscreener::example_output) * 100.,
        status = "Initiating screening",
        filename = file_details$filename,
        filesize = file_details$filesize,
        nrows = data_details$nrows,
        ncols = data_details$ncols,
        start_time = Sys.time(),
        log_time = Sys.time(),
        results = results
      )
    }
    if (is.null(results)) {
      log$progress <- 0
    }
    if (any(log$results[["result"]] == "FAIL")) {
      log$status <- "FAIL"
      log$progress <- 100.
    } else if (log$progress == 100) {
      log$status <- "PASS"
    } else {
      log$status <- "Screening not yet completed"
    }
    jsonlite::write_json(
      log,
      log_path,
      pretty = TRUE,
      na = "string"
    )
  }
}

#' Render standard URL
#'
#' @param slug string to paste to base domain
#' @param domain base domain. Can be "analysts_guide", "ees", "dfe_github"
#' or "screener_app_repo"
#' @returns String containing URL
#' @keywords internal
#' @noRd
render_url <- function(slug, domain = "analysts_guide") {
  if (
    !domain %in% c("analysts_guide", "ees", "dfe_github", "screener_app_repo")
  ) {
    stop("Please choose one of 'analysts_guide', 'ees' or 'dfe_github'")
  }
  url <- list(
    analysts_guide = paste0(
      "https://dfe-analytical-services.github.io/",
      "analysts-guide/"
    ),
    ees = "https://explore-education-statistics.service.gov.uk/",
    dfe_github = "https://github.com/dfe-analytical-services/",
    screener_app_repo = paste0(
      "https://raw.githubusercontent.com/dfe-analytical-services/",
      "dfe-published-data-qa/refs/heads/main/"
    )
  )
  paste0(
    url[domain],
    slug
  )
}

#' Run a check, log the results, and determine if early return is needed
#'
#' This is used in the screen_dfs function and appends new check results to
#' the existing results, updates (or creates) a JSON log, and checks if any
#' check has failed. If any result is "FAIL", it signals an early return is
#' needed.
#'
#' @param all_results A data frame containing all previous check results.
#' @param check_results A data frame with the results of the current check.
#' @param stage Character. The name of the current stage to annotate in the
#' results.
#' @param log_key Character. The key to use for logging.
#' @param log_dir Character. The directory where logs should be written.
#' @param data_details List. Additional details about the data to include in
#' the log.
#'
#' @return A list with two elements: {all_results} (the updated results data
#' frame)
#'   and {early_return} (logical, TRUE if any result is "FAIL").
#'
#' @keywords internal
#' @noRd
run_and_log_check <- function(
  all_results,
  check_results,
  stage,
  log_key,
  log_dir,
  data_details
) {
  all_results <- all_results |>
    rbind(
      check_results |>
        dplyr::mutate(stage = stage)
    )

  write_json_log(
    check_results |> dplyr::mutate(stage = stage),
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(list(all_results = all_results, early_return = TRUE))
  }
  list(all_results = all_results, early_return = FALSE)
}
