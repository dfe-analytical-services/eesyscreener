#' Check all filters have more than one level
#'
#' Validates that every filter column in the data has at least two distinct
#' values. A filter with only one level provides no analytical value and
#' should be removed from the metadata.
#'
#' @inheritParams precheck_cross_meta_to_data
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_filter
#'
#' @examples
#' precheck_filter_not_singular(example_data, example_meta)
#' precheck_filter_not_singular(example_data, example_meta, verbose = TRUE)
#' @export
precheck_filter_not_singular <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  filter_cols <- get_filters(meta)

  if (length(filter_cols) == 0) {
    return(test_output(
      check_name,
      "PASS",
      "There are no filters in the data to test.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  n_distinct_df <- data |>
    dplyr::summarise(
      dplyr::across(dplyr::all_of(filter_cols), ~ dplyr::n_distinct(.x))
    ) |>
    dplyr::collect()

  singular_filters <- names(n_distinct_df)[n_distinct_df[1, ] < 2]

  if (length(singular_filters) == 0) {
    test_output(
      check_name,
      "PASS",
      "All filters have two or more levels.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(singular_filters))}filter{?s}",
        " {?has/have} fewer than two levels and should be removed from the",
        " metadata: '",
        paste0(singular_filters, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
