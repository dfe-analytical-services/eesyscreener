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
#' check_meta_fil_grp(example_meta)
#' check_meta_fil_grp(example_meta, verbose = TRUE)
#' @export
check_meta_fil_grp <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()
  invalid_filter_grouping_column <- meta |>
    dplyr::filter(
      .data$col_type == "Indicator",
      !is.na(.data$filter_grouping_column) & .data$filter_grouping_column != ""
    ) |>
    dplyr::pull("col_name")

  if (length(invalid_filter_grouping_column) == 0) {
    test_output(
      test_name,
      "PASS",
      "No indicators have a filter_grouping_column value.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
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
