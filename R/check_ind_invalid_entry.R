#' Check that there are no blank values in any indicators.
#'
#' Throw an error if, for any filter, indicator_dp is not blank.
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
    if (any(c(legacy_gss_symbols, "") %in% data[[i]])) {
      return("FAIL")
    } else {
      return("PASS")
    }
  }

  indicators <- meta |>
    dplyr::filter(col_type == "Indicator") |>
    dplyr::pull(col_name) |>
    as.vector()

  pre_result <- utils::stack(sapply(indicators, ind_invalid_entry_check))

  invalid_indicators <- dplyr::filter(pre_result, values == "FAIL") |>
    dplyr::pull(ind)

  if (all(pre_result$values == "PASS")) {
    test_output(
      "check_ind_invalid_entry",
      "PASS",
      "There are no blank values or GSS legacy symbols in any indicators.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
      test_output(
        "check_ind_invalid_entry",
        "FAIL",
        paste0(
          cli::pluralize(
            "{cli::no(length(invalid_indicators))} indicator{?s} with invalid entries"),
          ifelse(
            length(invalid_indicators) > 0,
            paste(
              ":",
              paste0(invalid_indicators, collapse=", "),
              "contains either a blank or at least one of",
              paste0(legacy_gss_symbols, collapse = "', '")
            ),
            ""
          )
        ),
        guidance_url = 'https://gss.civilservice.gov.uk/wp-content/uploads/2017/03/GSS-Website-Harmonised-Symbols-Supporting-Documentation.pdf',
        verbose = verbose,
        stop_on_error = stop_on_error
      )

  }
}
