#' Check there are no invalid columns in the metadata
#'
#' Make sure that all column names are expected metadata columns. Checks across
#' both `req_meta_cols` and `optional_meta_cols`.
#'
#' @param meta A data frame of the metadata file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_invalid_meta(example_meta)
#' precheck_col_invalid_meta(example_meta, verbose = TRUE)
#' @export
precheck_col_invalid_meta <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  invalid_meta_cols <- setdiff(
    names(meta),
    c(eesyscreener::req_meta_cols, eesyscreener::optional_meta_cols)
  )

  if (length(invalid_meta_cols) == 0) {
    test_output(
      "col_invalid_meta",
      "result" = "PASS",
      "There are no invalid columns in the metadata file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(invalid_meta_cols) == 1) {
      test_output(
        "col_invalid_meta",
        "result" = "FAIL",
        paste(invalid_meta_cols, "is an invalid column in the metadata file."),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_invalid_meta",
        "result" = "FAIL",
        paste(
          "These are invalid columns in the metadata file:",
          paste(invalid_meta_cols, collapse = ", ")
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
