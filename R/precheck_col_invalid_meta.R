#' Check there are no invalid columns in the metadata
#'
#' Make sure that all column names are expected metadata columns. Checks across
#' both `req_meta_cols` and `optional_meta_cols`.
#'
#' @param meta A data frame of the metadata file
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_invalid_meta(example_meta)
#' precheck_col_invalid_meta(example_meta, output = "table")
#' @export
precheck_col_invalid_meta <- function(meta, output = "console") {
  invalid_meta_cols <- setdiff(
    names(meta),
    c(eesyscreener::req_meta_cols, eesyscreener::optional_meta_cols)
  )

  if (length(invalid_meta_cols) == 0) {
    test_output(
      "col_invalid_meta",
      "result" = "PASS",
      "There are no invalid columns in the metadata file.",
      output = output
    )
  } else {
    if (length(invalid_meta_cols) == 1) {
      test_output(
        "col_invalid_meta",
        "result" = "FAIL",
        paste(invalid_meta_cols, "is an invalid column in the metadata file."),
        output = output
      )
    } else {
      test_output(
        "col_invalid_meta",
        "result" = "FAIL",
        paste(
          "These are invalid columns in the metadata file:",
          paste(invalid_meta_cols, collapse = ", ")
        ),
        output = output
      )
    }
  }
}
