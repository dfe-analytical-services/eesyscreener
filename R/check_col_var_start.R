#' Check that variable names start with a lowercase letter
#'
#' Check that all variable names in the data file start with a lowercase letter.
#' Flags any variables that start with a non-lowercase character as a warning.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family check_col
#'
#' @examples
#' check_col_var_start(example_data)
#' check_col_var_start(example_data, verbose = TRUE)
#' @export
check_col_var_start <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  invalid_vars <- names(data)[!grepl("^[a-z]", names(data))]

  if (length(invalid_vars) == 0) {
    test_output(
      check_name,
      "PASS",
      "All variable names in the data file start with a lowercase letter.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "WARNING",
      cli::pluralize(
        "The following {cli::qty(length(invalid_vars))}variable name{?s} ",
        "{?starts/start} with a character that isn't a lowercase letter: '",
        paste0(invalid_vars, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
