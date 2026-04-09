#' Check that filter groups are filters
#'
#' Throw warning if filter groups are not included in the col_name column.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_filter_group_is_filter(example_meta)
#' check_meta_filter_group_is_filter(example_meta, verbose = TRUE)
#' @export
check_meta_filter_group_is_filter <- function(
  # nolint: object_length_linter.
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  meta_filter_groups <- get_filter_groups(meta)

  if (length(meta_filter_groups) == 0) {
    test_output(
      "filter_group_is_filter",
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    filter_group_not_in_filter <- meta_filter_groups[
      !meta_filter_groups %in% meta$col_name
    ]

    if (length(filter_group_not_in_filter) == 0) {
      test_output(
        "filter_group_is_filter",
        "PASS",
        "All filter groups are included in the col_name column.",
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "filter_group_is_filter",
        "WARNING",
        paste0(
          "Filter groups should appear in the col_name column in the ",
          "metadata file. Please add rows for the following col_name(s): '",
          paste0(filter_group_not_in_filter, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
