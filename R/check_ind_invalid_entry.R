#' Check for invalid values in indicators
#'
#' Check all values in indicator columns for blanks or obsolete no data symbols.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_ind
#'
#' @examples
#' check_ind_invalid_entry(example_data, example_meta)
#' check_ind_invalid_entry(example_data, example_meta, verbose = TRUE)
#' @export
check_ind_invalid_entry <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  indicators <- meta |>
    dplyr::filter(.data$col_type == "Indicator") |>
    dplyr::pull(.data$col_name) |>
    as.vector()

  bad_vals <- c(eesyscreener::legacy_gss_symbols, "")

  # Restrict to character columns: numeric indicators cannot contain string
  # bad_vals, so they trivially pass. Pre-computing char cols from the schema
  # avoids a type-mismatch error when DuckDB tries to compare BIGINT to string
  # literals. Single query across all character indicators.
  char_indicators <- intersect(
    indicators,
    names(dplyr::select(data, tidyselect::where(is.character)))
  )

  if (length(char_indicators) > 0) {
    result_row <- data |>
      dplyr::summarise(dplyr::across(
        dplyr::all_of(char_indicators),
        ~ sum(. %in% bad_vals) > 0
      )) |>
      dplyr::collect()
    invalid_indicators <- names(result_row)[unlist(
      result_row,
      use.names = FALSE
    )]
  } else {
    invalid_indicators <- character(0)
  }

  if (length(invalid_indicators) == 0) {
    test_output(
      test_name,
      "PASS",
      "There are no blank values or GSS legacy symbols in any indicators.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      paste0(
        cli::pluralize(
          paste0(
            "{cli::no(length(invalid_indicators))} indicator{?s}",
            " with invalid entries"
          )
        ),
        ": ",
        paste0(invalid_indicators, collapse = ", "),
        " contains either a blank or at least one of '",
        paste0(bad_vals[bad_vals != ""], collapse = "', '"),
        "'"
      ),
      guidance_url = paste0(
        "https://gss.civilservice.gov.uk/wp-content/uploads/2017/03/",
        "GSS-Website-Harmonised-Symbols-Supporting-Documentation.pdf"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
