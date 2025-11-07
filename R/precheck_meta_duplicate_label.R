#' Check there are no duplicate labels
#'
#' Ensure that each entry under label is unique in the metafile.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_meta
#'
#' @examples
#' precheck_met_duplicate_label(example_meta)
#' precheck_met_duplicate_label(example_meta, verbose = TRUE)
#' @export
precheck_meta_duplicate_label <- function(
    meta,
    verbose = FALSE,
    stop_on_error = FALSE
) {
  duplicated_labels <- meta$label[duplicated(meta$label)]

  if (length(duplicated_labels) == 0) {
    test_output(
      "meta_duplicate_label",
      "PASS",
      "All labels are unique.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(duplicated_labels) == 1) {
      test_output(
        "meta_duplicate_label",
        "FAIL",
        paste0(
          "The following label is duplicated in the metadata file: '",
          duplicated_labels,
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )

    } else {
      test_output(
        "meta_duplicate_label",
        "FAIL",
        paste0(
          "The following labels are duplicated in the metadata file: '",
          paste0(duplicated_labels, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
