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
#' precheck_col_req_meta(example_meta, verbose = TRUE)
#' @export
precheck_col_req_meta <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- test_name
  missing_cols <- eesyscreener::req_meta_cols[
    !eesyscreener::req_meta_cols %in% names(meta)
  ]

  if (length(missing_cols) == 0) {
    test_output(
      test_name,
      "PASS",
      "All of the required columns are present in the metadata file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(missing_cols) == 1) {
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following required column is missing from the metadata file: '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following required columns are missing from the metadata file:",
          " '",
          paste(missing_cols, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
