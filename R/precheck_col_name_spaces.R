#' Check for spaces in the column names of metadata
#' (check that no value in col_name has any spaces)
#' NA in the column names don't contain spaces so won't count
#'
#' @param meta A data frame of the metadata file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @family precheck_col
#'
#' @inherit check_filename_spaces return
#'
#' @examples
#' precheck_col_invalid_meta(example_meta)
#' precheck_col_invalid_meta(example_meta, verbose = TRUE)
#' @export
precheck_col_name_spaces <- function(
    meta,
    verbose = FALSE,
    stop_on_error = FALSE) {

  col_name_space_pos <- grep("\\s",meta$col_name)

  if (length(col_name_space_pos)>0){
    test_output(
      "col_name_spaces",
      "result" = "FAIL",
      "message" = paste0(c(cli::pluralize("There are one or more spaces in {length(col_name_space_pos)} col_name value{?s} in the metadata file at column{?s}: "),paste0(col_name_space_pos,collapse=","),"."),collapse=""),
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
