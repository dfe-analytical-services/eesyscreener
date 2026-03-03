#' Check filter groups match in meta and data
#'
#' Ensure all filter groups from the meta data are found in the data file.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_filter_group_match(example_data, example_meta)
#' check_meta_filter_group_match(example_data, example_meta, verbose = TRUE)
#' @export
check_meta_filter_group_match <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  meta_filter_groups <- meta |>
    dplyr::filter(
      !(is.na(.data$filter_grouping_column) |
        .data$filter_grouping_column == "")
    )

  if (nrow(meta_filter_groups) == 0) {
    test_output(
      "filter_groups_match",
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    filter_groups_not_in_data <- setdiff(
      meta_filter_groups$filter_grouping_column,
      names(data)
    )
    number_filter_groups_not_in_data <- length(filter_groups_not_in_data)

    if (number_filter_groups_not_in_data == 0) {
      test_output(
        "filter_groups_match",
        "PASS",
        "All filter groups from the metadata were found in the data file.",
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      if (number_filter_groups_not_in_data == 1) {
        test_output(
          "filter_groups_match",
          "FAIL",
          paste0(
            "The following filter group from the metadata was not found ",
            "as a variable in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      } else {
        test_output(
          "filter_groups_match",
          "FAIL",
          paste0(
            "The following filter groups from the metadata were not found ",
            "as variables in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      }
    }
  }
}
