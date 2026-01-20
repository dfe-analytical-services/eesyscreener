check_col_snake_case <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  # do a check for capital letters and special characters in column names

  cap_special_char_check <- unique(unlist(
    stringr::str_split(gsub("[a-z0-9]|_", "", names(data)), ""),
    use.names = FALSE
  ))

  test_name <- "col_snake_case"

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
      "The following invalid %s found in the variable names of the data file: %s",
      char_word,
      paste0("'", paste(cap_special_char_check, collapse = "', '"), "'")
    )

    result <- "ADVISORY"
    test_output(
      test_name,
      result,
      message,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
