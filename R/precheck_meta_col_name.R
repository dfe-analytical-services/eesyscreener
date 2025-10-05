#' Check col_name is completed for all rows
#'
#' Ensure there are no blank cells for col_name in the metafile.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_meta
#'
#' @examples
#' precheck_meta_col_name(example_meta)
#' precheck_meta_col_name(example_meta, output = "table")
#' @export
precheck_meta_col_name <- function(meta, output = "console") {
  blank_col_names <- sum(is.na(meta$col_name) | trimws(meta$col_name) == "")

  if (blank_col_names == 0) {
    test_output(
      "meta_col_name",
      "PASS",
      "The col_name column is completed for every row in the metadata.",
      output = output
    )
  } else {
    if (blank_col_names == 1) {
      test_output(
        "meta_col_name",
        "FAIL",
        "There is a col_name missing in 1 row of the metadata file.",
        output = output
      )
    } else {
      test_output(
        "meta_col_name",
        "FAIL",
        paste0(
          "There are col_name values missing in ",
          blank_col_names,
          " rows of the metadata file."
        ),
        output = output
      )
    }
  }
}
