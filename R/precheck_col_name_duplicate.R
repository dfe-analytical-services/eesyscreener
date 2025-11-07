#' Check there are no duplicated column names
#'
#' Make sure that all column names are unique.
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
#' precheck_col_name_duplicate(example_meta)
#' precheck_col_name_duplicate(example_meta, verbose = TRUE)
#' @export
precheck_col_name_duplicate <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  duplicated_col_names <- meta$col_name[duplicated(meta$col_name)]

  if (length(duplicated_col_names) == 0) {
    test_output(
      "col_name_duplicate",
      "result" = "PASS",
      "All col_name values are unique.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(duplicated_col_names) == 1) {
      test_output(
        "col_name_duplicate",
        "result" = "FAIL",
        paste0(
          "The following col_name value is duplicated in the metadata file: '",
          paste(duplicated_col_names),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_name_duplicate",
        "result" = "FAIL",
        paste0(
          "The following col_name values are duplicated in the metadata file: '",
          paste0(duplicated_col_names, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
