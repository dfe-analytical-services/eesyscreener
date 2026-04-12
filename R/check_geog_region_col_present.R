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
  test_name <- get_check_name()

  col_names <- dplyr::tbl_vars(data)
  has_code <- "region_code" %in% col_names
  has_name <- "region_name" %in% col_names

  if (has_code && has_name) {
    return(test_output(
      test_name,
      "PASS",
      paste0(
        "Where one of region_code or region_name is present, ",
        "the other column is also present."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (!has_code && !has_name) {
    return(test_output(
      test_name,
      "PASS",
      "No regional columns are present in this data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  missing_col <- if (has_name) "region_code" else "region_name"
  present_col <- if (has_name) "region_name" else "region_code"

  test_output(
    test_name,
    "FAIL",
    paste0(
      "Where '",
      present_col,
      "' is included in the data file, '",
      missing_col,
      "' should also be included."
    ),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
