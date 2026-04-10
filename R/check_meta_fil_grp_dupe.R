#' Check all of the filter_group values are unique
#'
#' Ensure all filter groups from the meta data are unique.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_fil_grp_dupe(example_meta)
#' check_meta_fil_grp_dupe(example_meta, verbose = TRUE)
#' @export
check_meta_fil_grp_dupe <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  filter_groups <- meta |>
    dplyr::filter(
      !is.na(.data$filter_grouping_column),
      .data$filter_grouping_column != ""
    ) |>
    dplyr::pull(.data$filter_grouping_column)

  if (length(filter_groups) == 0) {
    test_output(
      get_check_name(),
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else if (length(filter_groups) != dplyr::n_distinct(filter_groups)) {
    duplicates <- unique(filter_groups[duplicated(filter_groups)])
    test_output(
      get_check_name(),
      "FAIL",
      paste0(
        "There are duplicate filter_group values: ",
        paste(duplicates, collapse = ", "),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      get_check_name(),
      "PASS",
      "All of the filter_group values are unique.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
