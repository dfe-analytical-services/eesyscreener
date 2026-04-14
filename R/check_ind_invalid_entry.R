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
  ind_invalid_entry_check <- function(i) {
    col_vals <- data |>
      dplyr::select(dplyr::all_of(i)) |>
      dplyr::distinct() |>
      dplyr::pull(1)
    if (any(c(eesyscreener::legacy_gss_symbols, "") %in% col_vals)) {
      "FAIL"
    } else {
      "PASS"
    }
  }

  test_name <- get_check_name()
  indicators <- meta |>
    dplyr::filter(.data$col_type == "Indicator") |>
    dplyr::pull(.data$col_name) |>
    as.vector()

  pre_result <- utils::stack(sapply(indicators, ind_invalid_entry_check))

  invalid_indicators <- as.character(pre_result$ind[pre_result$values == "FAIL"])

  if (all(pre_result$values == "PASS")) {
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
        ifelse(
          length(invalid_indicators) > 0,
          paste(
            ":",
            paste0(invalid_indicators, collapse = ", "),
            "contains either a blank or at least one of",
            paste0(eesyscreener::legacy_gss_symbols, collapse = "', '")
          ),
          ""
        )
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
