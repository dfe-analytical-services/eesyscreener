#' Check for spaces in variable names
#' This function checks for spaces in the variable names of a given data frame.
#' @param data A data frame to be checked for spaces in variable names.
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently. Default is FALSE.
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING". Default is FALSE.
#' @return a single row data frame indicating the result of the check.
#' @export
#' @examples
#' check_col_names_spaces(example_data)
#' @family check_col_names

check_col_names_spaces <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  #create a dataframe to store pre-results of checks on variable names
  pre_result <- data.frame(
    "ind" = colnames(data),
    "values" = ifelse(grepl("\\s", colnames(data)), "FAIL", "PASS")
  )

  # extract the names of columns that failed the check
  failed_cols <- pre_result |>
    dplyr::filter(values == "FAIL") |>
    dplyr::pull(ind)

  test_name <- "col_names_spaces"

  if (all(pre_result$values == "PASS")) {
    result <- "PASS"
    message <- sprintf(
      "There are no spaces in the variable names in the datafile."
    )
    #otherwise use the fail_results helper function
  } else {
    result <- "FAIL"
    message <- sprintf(
      "The following variable name%s %s at least one space that needs removing: '%s'.",
      if (length(failed_cols) > 1) "s" else "",
      if (length(failed_cols) > 1) "each have" else "has",
      paste(failed_cols, collapse = "', '")
    )
  }

  test_output(
    test_name,
    result,
    message,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
