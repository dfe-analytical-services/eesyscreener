#' Check that region columns are complete for a given geographic level
#'
#' Shared implementation for `check_geog_region_for_la()` and
#' `check_geog_region_for_lad()`. Filters data to rows matching `level_label`,
#' checks that `region_code` and `region_name` are present and contain no
#' missing values, and returns a `test_output()` result.
#'
#' Derives the check name from the calling public function via
#' `get_check_name()`, so the result is correctly labelled regardless of which
#' wrapper invoked it.
#'
#' @param data data.frame of the data file being screened
#' @param level_label string, the geographic level to filter on, e.g.
#' `"Local authority"` or `"Local authority district"`
#' @param verbose logical, passed through to `test_output()`
#' @param stop_on_error logical, passed through to `test_output()`
#'
#' @keywords internal
#' @noRd
#'
#' @returns a single row data frame as produced by `test_output()`
.check_geog_region_for_level <- function(
  data,
  level_label,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  has_level <- data |>
    dplyr::filter(.data$geographic_level == level_label) |>
    dplyr::count() |>
    dplyr::pull("n") >
    0

  if (!has_level) {
    return(test_output(
      test_name,
      "PASS",
      paste0("There is no ", level_label, " level data in the data file."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  data_cols <- dplyr::tbl_vars(data)
  missing_cols <- setdiff(c("region_code", "region_name"), data_cols)

  if (length(missing_cols) > 0) {
    return(test_output(
      test_name,
      "WARNING",
      cli::pluralize(
        "The following region {cli::qty(length(missing_cols))}column{?s} ",
        "{?is/are} missing from the data file: '",
        paste0(missing_cols, collapse = "', '"),
        "'. Regional information should ideally be given for all ",
        level_label,
        " level data."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  level_region <- data |>
    dplyr::filter(.data$geographic_level == level_label) |>
    dplyr::select("region_code", "region_name")

  missing_codes <- level_region |>
    dplyr::filter(is.na(.data$region_code) | .data$region_code == "") |>
    dplyr::count() |>
    dplyr::pull("n")

  missing_names <- level_region |>
    dplyr::filter(is.na(.data$region_name) | .data$region_name == "") |>
    dplyr::count() |>
    dplyr::pull("n")

  if (missing_codes > 0 || missing_names > 0) {
    test_output(
      test_name,
      "WARNING",
      paste0(
        "region_code and / or region_name have missing values for ",
        level_label,
        " rows in the data file. It is recommended to include ",
        "the information from these columns for ",
        level_label,
        " level data."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0(
        "Both region_code and region_name are completed for all ",
        level_label,
        " rows in the data file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

#' Check that region columns are complete for Local authority rows
#'
#' Checks that `region_code` and `region_name` columns are present in the data
#' file and contain no missing values for rows at the Local authority geographic
#' level. Regional information should ideally be provided for all Local
#' authority level data.
#'
#' If no Local authority level data is present in the file, the check passes
#' immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_region_for_la(example_data)
#' @export
check_geog_region_for_la <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_region_for_level(
    data,
    level_label = "Local authority",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check that region columns are complete for Local authority district rows
#'
#' Checks that `region_code` and `region_name` columns are present in the data
#' file and contain no missing values for rows at the Local authority district
#' geographic level. Regional information should ideally be provided for all
#' Local authority district level data.
#'
#' If no Local authority district level data is present in the file, the check
#' passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_region_for_lad(example_data)
#' @export
check_geog_region_for_lad <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_region_for_level(
    data,
    level_label = "Local authority district",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
