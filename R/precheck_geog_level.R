#' Check that the geographic_level values are all valid.
#'
#' Throw an error if geographic_level values used in the data file are not
#' present in the list of acceptable geographic levels
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_geog
#'
#' @examples
#' precheck_geog_level(example_data)
#' precheck_geog_level(example_data, verbose = TRUE)
#' @export
precheck_geog_level <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- test_name
  # Pull all unique geographic levels from the data set
  present_geographic_levels <- data |>
    dplyr::pull(.data$geographic_level) |>
    unique()
  # Compare these geographic levels to the acceptable levels in geography_df
  invalid_geographic_levels <- setdiff(
    present_geographic_levels,
    eesyscreener::geography_df$geographic_level
  )
  # If there are no invalid geographic levels, pass the test
  if (length(invalid_geographic_levels) == 0) {
    test_output(
      test_name,
      "PASS",
      "The geographic_level values are all valid.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    # If there are any invalid geographic levels, fail the test and flag them
    test_output(
      test_name,
      "FAIL",
      paste0(
        "The following invalid geographic level(s) were found in the file: ",
        paste0(invalid_geographic_levels, collapse = "', '"),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
