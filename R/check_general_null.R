#' Check for null and legacy no-data symbols
#'
#' Checks for null-like values (such as "NULL", "NA", and similar) in the
#' data and metadata files, and for legacy no-data symbols (such as "N/A",
#' ".", "..") in the data file.
#'
#' Null-like symbols cause a failure; finding legacy no-data symbols produces
#' a warning. The GSS provides guidance on the accepted symbols to use for
#' representing missing or suppressed data.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_general
#'
#' @examples
#' check_general_null(example_data, example_meta)
#' @export
check_general_null <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  start_time <- Sys.time()
  test_name <- get_check_name()

  null_symbols <- c("NULL", "Null", "null", "NA", "na")
  legacy_symbols <- c("N/A", "n/a", ".", "..", "-")

  gss_guidance_url <- paste0(
    "https://analysisfunction.civilservice.gov.uk/policy-store/",
    "symbols-in-tables-definitions-and-help/"
  )

  # Check meta first — in-memory, so effectively free.
  null_in_meta <- null_symbols[
    null_symbols %in% unlist(meta, use.names = FALSE)
  ]

  # Character column names pre-computed outside the pipeline (schema only, no
  # data read). String symbols cannot appear in numeric columns, so numeric
  # columns are safely skipped.
  char_cols <- names(dplyr::select(data, dplyr::where(is.character)))

  has_null_in_data <- FALSE
  has_legacy_in_data <- FALSE

  if (length(char_cols) > 0) {
    # Single scan: find which columns contain *any* bad symbol (null or legacy).
    # For clean files (the common case) this is the only data query needed.
    combined_scan <- data |>
      dplyr::summarise(dplyr::across(
        dplyr::all_of(char_cols),
        ~ sum(. %in% c(null_symbols, legacy_symbols)) > 0
      )) |>
      dplyr::collect()

    cols_with_bad <- names(combined_scan)[unlist(combined_scan, use.names = FALSE)]

    if (length(cols_with_bad) > 0) {
      # Second, targeted scan restricted to columns that actually contain bad
      # values. Determines whether the bad values are null or legacy symbols.
      null_scan <- data |>
        dplyr::summarise(dplyr::across(
          dplyr::all_of(cols_with_bad),
          ~ sum(. %in% null_symbols) > 0
        )) |>
        dplyr::collect()

      has_null_in_data <- any(unlist(null_scan, use.names = FALSE), na.rm = TRUE)
      # If none of the bad-value columns contain null symbols, the bad values
      # must be legacy symbols (the two sets are disjoint).
      has_legacy_in_data <- !has_null_in_data
    }
  }

  if (has_null_in_data || length(null_in_meta) > 0) {
    parts <- character(0)
    if (has_null_in_data) {
      parts <- c(
        parts,
        paste0(
          "Problematic null or NA symbols were found in the data file.",
          " The symbols checked for are: '",
          paste0(null_symbols, collapse = "', '"),
          "'."
        )
      )
    }
    if (length(null_in_meta) > 0) {
      parts <- c(
        parts,
        cli::pluralize(
          "The following problematic {cli::qty(length(null_in_meta))}",
          "symbol{?s} {?was/were} found in the metadata file: '",
          paste0(null_in_meta, collapse = "', '"),
          "'."
        )
      )
    }
    return(test_output(
      test_name,
      "FAIL",
      paste(parts, collapse = " "),
      guidance_url = gss_guidance_url,
      duration = Sys.time() - start_time,
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (has_legacy_in_data) {
    return(test_output(
      test_name,
      "WARNING",
      paste0(
        "Legacy no-data symbols were found in the data file.",
        " The symbols checked for are: '",
        paste0(legacy_symbols, collapse = "', '"),
        "'. Please check the GSS guidance for advice on the symbols to",
        " use for no data."
      ),
      guidance_url = gss_guidance_url,
      duration = Sys.time() - start_time,
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    paste0(
      "No problematic null or legacy no-data symbols were found in the",
      " data or metadata files."
    ),
    duration = Sys.time() - start_time,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
