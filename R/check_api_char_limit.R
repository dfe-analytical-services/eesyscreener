#' Check if column names exceed a character limit
#'
#' Uses the `api_char_limit` function to check if any column names in the
#' provided data frame exceed the character limit specified in the
#' `api_char_limits` data frame.
#'
#' @inheritParams precheck_col_req_data
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_char_col_name(example_data)
#' @export
check_api_char_col_name <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  api_char_limit(
    names(data),
    "column-name",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
