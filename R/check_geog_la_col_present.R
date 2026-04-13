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
  test_name <- get_check_name()

  la_cols <- c("new_la_code", "la_name", "old_la_code")
  data_cols <- dplyr::tbl_vars(data)
  present <- intersect(la_cols, data_cols)
  missing <- setdiff(la_cols, data_cols)

  if (length(present) == 0 || length(missing) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "Where local authority columns are present, all three are present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "FAIL",
    cli::pluralize(
      "The following local authority ",
      "{cli::qty(length(missing))}column{?s} ",
      "{?is/are} missing from the data file: '",
      paste0(missing, collapse = "', '"),
      "'. When any of new_la_code, la_name, or old_la_code is present, ",
      "all three should be included."
    ),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
