#' Shared implementation for geography column presence checks
#'
#' Checks that when any column for a given geographic level is present in the
#' data file, all required columns for that level are also present. If none of
#' the expected columns are present, the check passes immediately.
#'
#' Derives the check name from the calling public function via
#' `get_check_name()`, so the result is correctly labelled regardless of which
#' wrapper invoked it.
#'
#' @param data data.frame of the data file being screened
#' @param geographic_level character, the geographic level to check. Must match
#'   a value in `geography_df$geographic_level`.
#' @param verbose logical, passed through to `test_output()`
#' @param stop_on_error logical, passed through to `test_output()`
#'
#' @keywords internal
#' @noRd
#'
#' @returns a single row data frame as produced by `test_output()`
.check_geog_col_present <- function(
  data,
  geographic_level,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()
  level_label <- tolower(geographic_level)

  required_cols <- get_geog_level_cols(geographic_level)
  data_cols <- dplyr::tbl_vars(data)
  present <- intersect(required_cols, data_cols)
  missing <- setdiff(required_cols, data_cols)

  if (length(present) == 0) {
    return(test_output(
      test_name,
      "PASS",
      paste0("No ", level_label, " columns are present in this data file."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (length(missing) == 0) {
    return(test_output(
      test_name,
      "PASS",
      paste0("All ", level_label, " columns are present in the data file."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "FAIL",
    cli::pluralize(
      "The following ",
      level_label,
      " ",
      "{cli::qty(length(missing))}column{?s} ",
      "{?is/are} missing from the data file: '",
      paste0(missing, collapse = "', '"),
      "'. When any ",
      level_label,
      " column is present, all should be included."
    ),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check region code and name columns are both present
#'
#' When one of `region_code` or `region_name` is present in the data file,
#' checks that the other column is also present. If neither column is present,
#' the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_region_col_present(example_data)
#' check_geog_region_col_present(example_data, verbose = TRUE)
#' @export
check_geog_region_col_present <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_col_present(
    data,
    geographic_level = "Regional",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check that all local authority columns are present together
#'
#' When any of the three local authority columns (`new_la_code`, `la_name`,
#' `old_la_code`) appear in the data file, all three must be present. A partial
#' set of LA columns indicates a data quality issue.
#'
#' If none of the LA columns are present the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_la_col_present(example_data)
#' check_geog_la_col_present(example_data, verbose = TRUE)
#' @export
check_geog_la_col_present <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_col_present(
    data,
    geographic_level = "Local authority",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
