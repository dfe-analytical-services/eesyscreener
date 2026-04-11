#' Check for characteristic or characteristic_group variable names
#'
#' Check whether the fields 'characteristic' or 'characteristic_group' have
#' been included in the metadata. These are not recommended for use with the
#' EES Table Tool.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_col
#'
#' @examples
#' check_col_var_characteristic(example_meta)
#' check_col_var_characteristic(example_meta, verbose = TRUE)
#' @export
check_col_var_characteristic <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  characteristic_found <- "characteristic" %in%
    meta$col_name ||
    "characteristic_group" %in% meta$col_name ||
    "characteristic_group" %in% meta$filter_grouping_column

  if (!characteristic_found) {
    test_output(
      check_name,
      "PASS",
      paste0(
        "Neither 'characteristic' nor 'characteristic_group' were found",
        " as listed fields in the metadata file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "WARNING",
      paste0(
        "The fields 'characteristic' and / or 'characteristic_group' have been",
        " included in the data. These are not recommended for use with the EES",
        " Table Tool. Please refer to the guidance pages on filters."
      ),
      guidance_url = render_url(
        "statistics-production/ud.html#introduction-to-filters"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
