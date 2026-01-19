#' Check that no col_name values have spaces
#'
#' Checks the metadata file's col_name column for values that contain spaces.
#' 
#' NA in the column names don't contain spaces so won't count and are validated against elsewhere.' 
#' 
#' @inheritparams precheck_col_invalid_meta
#'
#' @family precheck_col
#'
#' @inherit check_filename_spaces return
#'
#' @examples
#' precheck_col_name_spaces(example_meta)
#' precheck_col_name_spaces(example_meta, verbose = TRUE)
#' @export
precheck_col_name_spaces <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  col_name_space_pos <- grep("\\s", meta$col_name)

  if (length(col_name_space_pos) > 0) {
    test_output(
      "col_name_spaces",
      "result" = "FAIL",
      "message" = paste0(
        c(
          cli::pluralize(
            "The following {length(col_name_space_pos)} col_name value{?s} have spaces in the metadata: "
          ),
          paste0(meta$col_name[col_name_space_pos], collapse = ", "),
          "."
        ),
        collapse = ""
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "col_name_spaces",
      "result" = "PASS",
      "message" = "There are no spaces in the col_name values.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
