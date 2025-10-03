#' Check col_type entries are valid
#'
#' Make sure that all col_type values are either 'Filter' or 'Indicator'
#'
#' @param meta A data frame of the metadata file
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_meta
#'
#' @examples
#' precheck_meta_col_type(example_meta)
#' precheck_meta_col_type(example_meta, output = "table")
#' @export
precheck_meta_col_type <- function(meta, output = "console") {
  unique_types <- unique(meta$col_type)
  invalid_types <- setdiff(unique_types, c("Filter", "Indicator"))

  if (length(invalid_types) == 0) {
    test_output(
      "meta_col_type",
      "PASS",
      "col_type is always 'Filter' or 'Indicator'.",
      output = output
    )
  } else {
    if (length(invalid_types) == 1) {
      test_output(
        "meta_col_type",
        "FAIL",
        paste0(
          "The following invalid col_type value was found in the metadata",
          " file: '",
          invalid_types
        ),
        output = output
      )
    } else {
      test_output(
        "meta_col_type",
        "FAIL",
        paste0(
          "The following invalid col_type values were found in the metadata",
          " file: '",
          paste0(invalid_types, collapse = "', '")
        ),
        output = output
      )
    }
  }
}
