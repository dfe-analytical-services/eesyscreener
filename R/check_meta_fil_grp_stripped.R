#' Check filter groups are unique when stripping non-alphanumeric characters
#'
#' Throw error when there are not the same number of unique filter groups
#' when they are stripped of characters that are not alpha-numeric
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_fil_grp_stripped(example_data, example_meta)
#' check_meta_fil_grp_stripped(example_data, example_meta, verbose = TRUE)
#' @export
check_meta_fil_grp_stripped <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- test_name
  # Pull all filter_grouping_column entries that are neither empty nor NA
  meta_filter_groups <- meta |>
    dplyr::filter(
      !(is.na(.data$filter_grouping_column) |
        .data$filter_grouping_column == "") # nolint: indentation_linter
    ) |>
    dplyr::pull(.data$filter_grouping_column)
  # If there are no filter_grouping_column entries, pass test
  if (length(meta_filter_groups) == 0) {
    test_output(
      test_name,
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    # Pull unique filter group items for all entries in filter_grouping_column
    raw_filter_groups <- lapply(
      meta_filter_groups,
      function(column) {
        data |>
          dplyr::select(dplyr::all_of(column)) |>
          dplyr::distinct() |>
          dplyr::pull(1)
      }
    )
    # Strip non-alphanumeric characters from the filter group items, and
    # select uniques
    stripped_filter_groups <- lapply(
      raw_filter_groups,
      function(x) gsub("[^[:alnum:]]", "", x)
    ) |>
      lapply(unique)
    # Compare raw and stripped filter group items
    comparison <- unlist(lapply(raw_filter_groups, length)) ==
      unlist(lapply(stripped_filter_groups, length))
    # Encode filter group items that failed into failed_cols
    failed_cols <- which(!comparison)
    # If there are some (greater than 0) failed_cols, fail test
    if (length(failed_cols) > 0) {
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The number of unique filter groups should not change when ",
          "non-alphanumeric characters are stripped. Please check this list ",
          "for erroneous filter group values: '",
          paste0(unlist(raw_filter_groups[failed_cols]), collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
      # Else if there are no failed_cols (not greater than 0), pass test
    } else {
      test_output(
        test_name,
        "PASS",
        paste0(
          "There are no issues when stripping non-alphanumeric",
          " characters from filter groups."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
