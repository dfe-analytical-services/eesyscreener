#' Check that region columns are present and complete for Local authority rows
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
  test_name <- get_check_name()

  has_la <- data |>
    dplyr::filter(.data$geographic_level == "Local authority") |>
    dplyr::count() |>
    dplyr::pull("n") >
    0

  if (!has_la) {
    return(test_output(
      test_name,
      "PASS",
      "There is no Local authority level data in the data file.",
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
        "Local authority level data."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  la_region <- data |>
    dplyr::filter(.data$geographic_level == "Local authority") |>
    dplyr::select("region_code", "region_name")

  missing_codes <- la_region |>
    dplyr::filter(is.na(.data$region_code) | .data$region_code == "") |>
    dplyr::count() |>
    dplyr::pull("n")

  missing_names <- la_region |>
    dplyr::filter(is.na(.data$region_name) | .data$region_name == "") |>
    dplyr::count() |>
    dplyr::pull("n")

  if (missing_codes > 0 || missing_names > 0) {
    test_output(
      test_name,
      "WARNING",
      paste0(
        "region_code and / or region_name have missing values for Local ",
        "authority rows in the data file. It is recommended to include ",
        "the information from these columns for Local authority level data."
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
        "Local authority rows in the data file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
