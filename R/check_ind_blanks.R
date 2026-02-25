#' Check that there are no blank values in any indicators.
#'
#' Throw an error if, for any filter, indicator_dp is not blank.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_ind
#'
#' @examples
#' check_ind_blanks(example_data, example_meta)
#' check_ind_blanks(example_data, example_meta, verbose = TRUE)
#' @export
check_ind_blanks <- function(data, meta) {
blanks_check <- function(i) {
  if ("" %in% data[[i]]) {
    return("FAIL")
  } else {
    return("PASS")
  }
}

indicators <- meta |>
  dplyr::filter(col_type == "Indicator") |>
  dplyr::pull(col_name) |>
  as.vector()

pre_result <- utils::stack(sapply(indicators, blanks_check))

indicators_with_blanks <- dplyr::filter(pre_result, values == "FAIL") |>
  dplyr::pull(ind)

if (all(pre_result$values == "PASS")) {
  test_output(
    "check_ind_blanks",
    "PASS",
    "There are no blank values in any indicators.",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
} else {
  if (length(indicators_with_blanks) == 1) {
    test_output(
      "check_ind_blanks",
      "FAIL",
      paste0(
        "There are blanks in the following indicator: '",
        indicators_with_blanks,
        "'. <br> - Blank cells are problematic and must be avoided. <br> - Please check the ",
        "<a href='https://gss.civilservice.gov.uk/wp-content/uploads/2017/03/GSS-Website-Harmonised-Symbols-Supporting-Documentation.pdf' target='_blank'>GSS guidance</a>",
        " for advice on the symbols to use for no data."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "check_ind_blanks",
      "FAIL",
      paste0(
        "There are blanks in the following indicators: '",
        paste(indicators_with_blanks, collapse = "', '"),
        "'. <br> - Blank cells are problematic and must be avoided. <br> - Please check the ",
        "<a href='https://gss.civilservice.gov.uk/wp-content/uploads/2017/03/GSS-Website-Harmonised-Symbols-Supporting-Documentation.pdf' target='_blank'>GSS guidance</a>",
        " for advice on the symbols to use for no data."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
}
