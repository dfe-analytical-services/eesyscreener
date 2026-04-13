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

  # Single pass over data columns collecting null and legacy symbols found.
  # Uses select + distinct + pull per column, which duckplyr can translate to
  # SQL. as.character() ensures numeric columns compare correctly against the
  # string literals in null_symbols / legacy_symbols (applied in R after pull,
  # not in SQL, so it does not affect duckplyr translation).
  data_cols <- dplyr::tbl_vars(data)
  null_in_data <- character(0)
  legacy_in_data <- character(0)

  for (col in data_cols) {
    col_vals <- data |>
      dplyr::select(dplyr::all_of(col)) |>
      dplyr::distinct() |>
      dplyr::pull(1) |>
      as.character()
    null_in_data <- union(null_in_data, intersect(null_symbols, col_vals))
    legacy_in_data <- union(legacy_in_data, intersect(legacy_symbols, col_vals))
  }

  # Check for null symbols in meta (already in memory)
  null_in_meta <- null_symbols[
    null_symbols %in% unlist(meta, use.names = FALSE)
  ]

  if (length(null_in_data) > 0 || length(null_in_meta) > 0) {
    parts <- character(0)
    if (length(null_in_data) > 0) {
      parts <- c(
        parts,
        cli::pluralize(
          "The following problematic {cli::qty(length(null_in_data))}",
          "symbol{?s} {?was/were} found in the data file: '",
          paste0(null_in_data, collapse = "', '"),
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

  if (length(legacy_in_data) > 0) {
    return(test_output(
      test_name,
      "WARNING",
      cli::pluralize(
        "The following legacy no-data {cli::qty(length(legacy_in_data))}",
        "symbol{?s} {?was/were} found in the data: '",
        paste0(legacy_in_data, collapse = "', '"),
        "'. Please check the GSS guidance for advice on the symbols to use",
        " for no data."
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
