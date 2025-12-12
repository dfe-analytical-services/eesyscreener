#' Check indicator_dp is blank for all filters
#'
#' Throw an error if, for any filter, indicator_dp is not blank.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_indicator_dp(example_meta)
#' check_meta_indicator_dp(example_meta, verbose = TRUE)
#' @export
check_meta_indicator_dp <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  indicator_dps <- meta |>
    dplyr::filter(
      col_type == "Filter",
      !is.na(indicator_dp),
      indicator_dp != ""
    ) |>
    dplyr::pull(indicator_dp)

  if (length(indicator_dps) == 0) {
    test_output(
      "indicator_dp",
      "PASS",
      "No filters have an indicator_dp value.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "indicator_dp",
      "FAIL",
      "Filters should not have an indicator_dp value in the metadata file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
