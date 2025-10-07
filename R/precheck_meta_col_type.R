#' Check col_type entries are valid
#'
#' Make sure that all col_type values are either 'Filter' or 'Indicator'
#'
#' @param meta A data frame of the metadata file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_meta
#'
#' @examples
#' precheck_meta_col_type(example_meta)
#' precheck_meta_col_type(example_meta, verbose = TRUE)
#' @export
precheck_meta_col_type <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  unique_types <- unique(meta$col_type)
  invalid_types <- setdiff(unique_types, c("Filter", "Indicator"))

  if (length(invalid_types) == 0) {
    test_output(
      "meta_col_type",
      "PASS",
      "col_type is always 'Filter' or 'Indicator'.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(invalid_types) == 1) {
      test_output(
        "meta_col_type",
        "FAIL",
        paste0(
          "The following invalid col_type value was found in the metadata",
          " file: '",
          invalid_types,
          "'"
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "meta_col_type",
        "FAIL",
        paste0(
          "The following invalid col_type values were found in the metadata",
          " file: '",
          paste0(invalid_types, collapse = "', '"),
          "'"
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
