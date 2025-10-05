#' Check all required columns are present in metadata
#'
#' Using the `mandatory_meta_cols` object.
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
  meta_col_check <- function(i) {
    if (i %in% names(meta)) {
      return("PASS")
    } else {
      return("FAIL")
    }
  }

  pre_result <- stack(sapply(req_meta_cols, meta_col_check))

  if (all(pre_result$values == "PASS")) {
    test_output(
      "col_req_meta",
      "PASS",
      "All of the mandatory columns are present in the metadata file.",
      output = output
    )
  } else {
    missing_cols <- filter(pre_result, values == "FAIL") |>
      dplyr::pull(ind)

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
