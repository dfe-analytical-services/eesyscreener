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
#' precheck_geog_geographic_level(example_data)
#' precheck_geog_geographic_level(example_data, verbose = TRUE)
#' @export
precheck_geog_geographic_level <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {

}
