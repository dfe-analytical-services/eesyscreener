#' Check that there are no obsolete symbols (i.e.  ~, : ) in any indicators.
#'
#' Throw an error if any obsolete symbols (i.e.  ~, : ), are present in the indicator values.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_ind
#'
#' @examples
#' check_ind_obsolete_symbols(example_data, example_meta)
#' check_ind_obsolete_symbols(example_data, example_meta, verbose = TRUE)
#' @export
check_ind_obsolete_symbols <- function(
    data,
    meta,
    verbose = FALSE,
    stop_on_error = FALSE
    ) {
  mindicators <- dplyr::filter(meta, col_type == "Indicator")

  present_indicators <- intersect(mindicators$col_name, names(data))

  obsolete_symbols_check <- function(i) {
    if (any(legacy_gss_symbols %in% data[[i]])) {
      return("FAIL")
    } else {
      return("PASS")
    }
  }

  pre_result <- utils::stack(sapply(present_indicators, obsolete_symbols_check))

  if ("FAIL" %in% pre_result$values) {
    test_output(
      "check_ind_obsolete_symbols",
      "ADVISORY",
      paste0(
        "Obsolete symbols (one or more of ",
        paste0(legacy_gss_symbols, collapse = ", "),
        ") found in the indicator values, please refer to the GSS recommended symbols."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "check_ind_obsolete_symbols",
      "PASS",
      paste(
        "Obsolete symbols (i.e. ",
        paste0(legacy_gss_symbols, collapse = ", "),
        "), are not present in the indicator values."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
