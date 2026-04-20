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
  test_name <- get_check_name()

  null_symbols <- c("NULL", "Null", "null", "NA", "na")
  legacy_symbols <- c("N/A", "n/a", ".", "..", "-")

  gss_guidance_url <- paste0(
    "https://analysisfunction.civilservice.gov.uk/policy-store/",
    "symbols-in-tables-definitions-and-help/"
  )

  # Check data columns in two queries (one per symbol family) rather than one
  # query per column. Character column names are pre-computed in R from the
  # schema — string symbols cannot appear in numeric columns, so numeric columns
  # are safely skipped.
  char_cols <- names(dplyr::select(data, where(is.character)))

  if (length(char_cols) > 0) {
    has_null_in_data <- data |>
      dplyr::summarise(dplyr::across(
        dplyr::all_of(char_cols),
        ~ sum(. %in% null_symbols) > 0
      )) |>
      dplyr::collect() |>
      any(na.rm = TRUE)

    has_legacy_in_data <- data |>
      dplyr::summarise(dplyr::across(
        dplyr::all_of(char_cols),
        ~ sum(. %in% legacy_symbols) > 0
      )) |>
      dplyr::collect() |>
      any(na.rm = TRUE)
  } else {
    has_null_in_data <- FALSE
    has_legacy_in_data <- FALSE
  }

  # Check for null symbols in meta (already in memory)
  null_in_meta <- null_symbols[
    null_symbols %in% unlist(meta, use.names = FALSE)
  ]

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
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
