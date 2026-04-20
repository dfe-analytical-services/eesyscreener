#' Check for blank values in filter and filter group columns
#'
#' Checks that no filter or filter group columns contain blank (empty string)
#' values. Every cell in a filter or filter group column must have a value. If
#' a row represents no specific breakdown, such as 'All genders', the value
#' should be 'Total' rather than left blank.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_blanks(example_data, example_meta)
#' check_filter_blanks(example_data, example_meta, verbose = TRUE)
#' @export
check_filter_blanks <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  filter_cols <- get_filters(meta, include_filter_groups = TRUE) |> unique()

  if (length(filter_cols) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "There are no filter columns to check.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Single query across all filter columns. Filter columns are always character
  # so no type-mismatch risk with the empty-string literal.
  result_row <- data |>
    dplyr::summarise(dplyr::across(
      dplyr::all_of(filter_cols),
      ~ sum(. == "") > 0
    )) |>
    dplyr::collect()

  cols_with_blanks <- names(result_row)[unlist(result_row, use.names = FALSE)]

  if (length(cols_with_blanks) == 0) {
    test_output(
      test_name,
      "PASS",
      "There are no blank values in any filter or filter group columns.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "There {cli::qty(length(cols_with_blanks))}is at least one blank",
        " value in the following filter or filter group column{?s}: '",
        paste0(cols_with_blanks, collapse = "', '"),
        "'. All filter cells must have a value."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
