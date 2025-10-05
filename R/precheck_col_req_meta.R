#' Check all required columns are present in metadata
#'
#' Using the `req_meta_cols` object.
#'
#' @inheritParams precheck_col_invalid_meta
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_req_meta(example_meta)
#' precheck_col_req_meta(example_meta, output = "table")
#' @export
precheck_col_req_meta <- function(meta, output = "console") {
  missing_cols <- req_meta_cols[!req_meta_cols %in% names(meta)]

  if (length(missing_cols) == 0) {
    test_output(
      "col_req_meta",
      "PASS",
      "All of the mandatory columns are present in the metadata file.",
      output = output
    )
  } else {
    if (length(missing_cols) == 1) {
      test_output(
        "col_req_meta",
        "FAIL",
        paste0(
          "The following mandatory column is missing from the metadata file: '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        output = output
      )
    } else {
      test_output(
        "col_req_meta",
        "FAIL",
        paste0(
          "The following mandatory columns are missing from the metadata file: '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        output = output
      )
    }
  }
}
