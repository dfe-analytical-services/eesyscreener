#' Check indicator values are valid
#'
#' Throw error if indicator unit values used in the meta file are not
#' present in the list of acceptable indicator unit values
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_indicator_unit_validation(example_meta)
#' check_meta_indicator_unit_validation(example_meta, verbose = TRUE)
#' @export
check_meta_indicator_unit_validation <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  # Pull all unique indicator_unit entries that are neither empty nor NA
  present_indictor_units <- meta |>
    dplyr::filter(
      col_type == "Indicator",
      !(is.na(indicator_unit) | indicator_unit == "")
    ) |>
    dplyr::pull(indicator_unit) |>
    unique()
  # Compare present indicator unit values to the acceptable values
  invalid_indicator_units <- setdiff(
    present_indictor_units,
    acceptable_indicator_units
  )
  # If there are no invalid indicator units, pass the test
  if (length(invalid_indicator_units) == 0) {
    test_output(
      "indicator_unit_validation",
      "PASS",
      "The indicator_unit values are valid",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    # If there are invalid indicator units, fail the test and flag the units
    test_output(
      "indiator_unit_validation",
      "FAIL",
      paste0(
        "The following invalid indicator unit(s) is / are present in the ",
        "meta data file: ",
        paste0(invalid_indicator_units, collapse = "', '"),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
