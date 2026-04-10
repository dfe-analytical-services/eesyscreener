#' Check that column names follow snake_case convention
#'
#' Check if all column names in the data file follow the snake_case convention
#' (lowercase letters, numbers, and underscores only). Flags any capital
#' letters or special characters as a warning.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family check_col
#'
#' @examples
#' check_col_snake_case(example_data)
#' check_col_snake_case(example_data, verbose = TRUE)
#' @export
check_col_snake_case <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  cap_special_char_check <- unique(unlist(
    stringr::str_split(gsub("[a-z0-9]|_", "", names(data)), ""),
    use.names = FALSE
  ))

  test_name <- get_check_name()

  if (length(cap_special_char_check) == 0) {
    test_output(
      test_name,
      "PASS",
      "The variable names in the data file follow the snake_case convention.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    char_word <- ifelse(
      length(cap_special_char_check) == 1,
      "character was",
      "characters were"
    )

    message <- sprintf(
      paste0(
        "The following invalid %s found in the variable",
        " names of the data file: %s"
      ),
      char_word,
      paste0("'", paste(cap_special_char_check, collapse = "', '"), "'.")
    )

    test_output(
      test_name,
      "WARNING",
      message,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
