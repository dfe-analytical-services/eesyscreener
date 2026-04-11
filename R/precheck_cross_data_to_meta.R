#' Check all data variables exist in the metadata file
#'
#' Ensure that every variable in the data file is either an observational unit,
#' has only a single unique value, or is represented in the metadata file as
#' either a `col_name` or `filter_grouping_column` entry.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_cross
#'
#' @examples
#' precheck_cross_data_to_meta(example_data, example_meta)
#' precheck_cross_data_to_meta(example_data, example_meta, verbose = TRUE)
#' @export
precheck_cross_data_to_meta <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  ob_units <- get_acceptable_ob_units()
  data_names <- names(data)

  non_ob_cols <- setdiff(data_names, ob_units)

  # Find single-level columns (only one unique value) in one pass
  if (length(non_ob_cols) > 0) {
    n_distinct_df <- data |>
      dplyr::summarise(
        dplyr::across(dplyr::all_of(non_ob_cols), ~ dplyr::n_distinct(.x))
      ) |>
      dplyr::collect()
    single_level_cols <- names(n_distinct_df)[n_distinct_df[1, ] == 1]
  } else {
    single_level_cols <- character(0)
  }

  cols_to_check <- setdiff(non_ob_cols, single_level_cols)
  meta_cols <- get_cols_meta(meta, grouping_cols = TRUE)
  not_in_meta <- setdiff(cols_to_check, meta_cols)

  if (length(not_in_meta) == 0) {
    test_output(
      check_name,
      "PASS",
      paste0(
        "All variables in the data file are observational units or are",
        " represented in the metadata file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "WARNING",
      cli::pluralize(
        "The following {cli::qty(length(not_in_meta))}variable{?s} in the ",
        "data file {?is/are} not {?an observational unit/observational ",
        "units}, ",
        "{?does/do} not have a single level, and {?is/are} not represented in ",
        "the metadata: '",
        paste0(not_in_meta, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
