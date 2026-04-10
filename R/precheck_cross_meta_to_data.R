#' Check all metadata variables exist in the data file
#'
#' Ensure that every variable named in the metadata file can be found as a
#' column in the data file. This covers both `col_name` entries and any
#' `filter_grouping_column` values.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_cross
#'
#' @examples
#' precheck_cross_meta_to_data(example_data, example_meta)
#' precheck_cross_meta_to_data(example_data, example_meta, verbose = TRUE)
#' @export
precheck_cross_meta_to_data <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  filter_groups <- meta |>
    dplyr::filter(
      !(is.na(.data$filter_grouping_column) |
          .data$filter_grouping_column == "")
    ) |>
    dplyr::pull(.data$filter_grouping_column)

  meta_variables <- unique(c(meta$col_name, filter_groups))
  missing_variables <- setdiff(meta_variables, names(data))

  if (length(missing_variables) == 0) {
    test_output(
      check_name,
      "PASS",
      "All variables from the metadata were found in the data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(missing_variables))}variable{?s} ",
        "{?was/were} found in the metadata file, but could not be found in ",
        "the data file: '",
        paste0(missing_variables, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
