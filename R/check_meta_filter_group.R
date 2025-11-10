#' Check filter_group is not set for indicator rows
#'
#' Throw warning if there are any indicator rows that have filter_group as
#' non-blank, to encourage users to correct the metadata.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_filter_group(example_meta)
#' check_meta_filter_group(example_meta, verbose = TRUE)
#' @export
check_meta_filter_group <- function(
    meta,
    verbose = FALSE,
    stop_on_error = FALSE
) {
  invalid_filter_grouping_column <- meta |>
    dplyr::filter(
      .data$col_type == "Indicator",
      !is.na(.data$filter_grouping_column) & .data$filter_grouping_column != ""
    ) |>
    dplyr::pull("col_name")

  if (length(invalid_filter_grouping_column) == 0) {
    test_output(
      "meta_col_name",
      "PASS",
      "No indicators have a filter_grouping_column value.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "meta_col_name",
      "FAIL",
      paste0(
        "Indicators should not have a filter_grouping_column value in 
        the metadata file. ",
        "The following indicator rows have filter_grouping_column values: '",
        paste(invalid_filter_grouping_column, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
