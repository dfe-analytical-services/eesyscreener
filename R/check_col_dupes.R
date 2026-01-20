#' Check for duplicate column names in a data frame
#' 
#' @description
#' This function checks for duplicate column names in the provided data frame.
#' If duplicates are found, it returns a detailed message listing the duplicate names.
#' If no duplicates are found, it confirms that all variable names are unique.
#' @param data A data frame to check for duplicate column names.

check_col_dupes <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  duplicate_variable_names <- names(data)[duplicated(names(data))]

  if (length(duplicate_variable_names) == 0) {
    test_output(
      "col_dupes",
      "PASS",
      "All variable names are unique in the datafile.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else if (length(duplicate_variable_names) == 1) {
    test_output(
      "col_dupes",
      "FAIL",
      paste0(
        "The following variable name is duplicated in the data file: '",
        paste(duplicate_variable_names),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "col_dupes",
      "FAIL",
      paste0(
        "The following variable names are duplicated in the datafile: ",
        paste(duplicate_variable_names, collapse = ", "),
        ". Variable names must be unique."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
