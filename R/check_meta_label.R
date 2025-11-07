#' Check every row has a label
#'
#' Ensure there are no blank cells in the label column for every row in the metafile
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces_return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_label(example_meta)
#' check_meta_label(example_meta, verbose = TRUE)
#' @export
check_meta_label <- function(
    meta,
    verbose = FALSE,
    stop_on_error = FALSE
    )
  {

  blank_labels <- sum(is.na(meta$label) | meta$label == "" | meta$label == " ")

  if (blank_labels == 0) {
    test_output (
      test_name ,
      "PASS",
      "The label column is completed for every row in the metadata.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (blank_labels == 1) {
      test_output (
        test_name,
        "FAIL",
        paste0(
          "There is a label missing in ",
          paste(blank_labels),
          " row of the metadata file."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output (
        test_name,
        "FAIL",
        paste0(
          "There are labels missing in ",
          paste(blank_labels),
          " rows of the metadata file."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
