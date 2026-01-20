#' Check indicator_grouping is blank for all filters
#'
#' Throw an error if, for any filter, indicator_grouping is not blank.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_indicator_grouping(example_meta)
#' check_meta_indicator_grouping(example_meta, verbose = TRUE)
#' @export
check_meta_indicator_grouping <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  indicator_groups <- meta |>
    dplyr::filter(
      .data$col_type == "Filter",
      !is.na(.data$indicator_grouping),
      .data$indicator_grouping != ""
    ) |>
    dplyr::pull(.data$indicator_grouping)

  if (length(indicator_groups) == 0) {
    test_output(
      "indicator_grouping",
      "PASS",
      "No filters have an indicator_grouping value.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "indicator_grouping",
      "FAIL",
      "Filters should not have an indicator_grouping value in the metadata file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
