check_col_snake_case <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  # do a check for capital letters and special characters in column names

  cap_special_char_check <- unique(unlist(
    stringr::str_split(gsub("[a-z0-9]|_", "", names(data)), ""),
    use.names = FALSE
  ))

  if (length(cap_special_char_check) == 0) {
    test_output(
      "col_snake_case",
      "PASS",
      "The variable names in the data file follow the snake_case convention.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(cap_special_char_check) == 1) {
      test_output(
        "col_snake_case",
        "ADVISORY",
        paste0(
          "The following invalid characters were found in the variable names of the data file: ",
          paste0("'", cap_special_char_check, collapse = "', '"),
          "'. <br> - Variable names should follow the snake_case convention and only contain lowercase letters, underscores or numbers."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_snake_case",

        "ADVISORY",
        paste0(
          "The following invalid characters were found in the variable names of the data file: ",
          paste0("'", cap_special_char_check, collapse = "', '"),
          "'. <br> - Variable names should follow the snake_case convention and only contain lowercase letters, underscores or numbers."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
