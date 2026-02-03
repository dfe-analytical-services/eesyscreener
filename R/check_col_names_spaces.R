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

  # create a helper function to print out results if all checks PASS

  pass_result <- function() {
    test_output(
      "col_names_spaces",
      "PASS",
      "There are no spaces in the variable names in the datafile.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }

  # create a helper function to print out results if any checks FAIL
  fail_results <- function() {
    # extract the names of columns that failed the check
    failed_cols <- pre_result |>
      dplyr::filter(values == "FAIL") |>
      dplyr::pull(ind)
    # if only one column failed, use singular message, otherwise plural
    if (length(failed_cols) == 1) {
      test_output(
        "col_names_spaces",
        "FAIL",
        paste0(
          "The following variable name has at least one space that needs removing: '",
          paste(failed_cols),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_names_spaces",
        "FAIL",
        paste0(
          "The following variable names each have at least one space that needs removing: '",
          paste(failed_cols, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
  # if all checks pass then pass use the pass_result helper function
  if (all(pre_result$values == "PASS")) {
    pass_result()
    #otherwise use the fail_results helper function
  } else {
    fail_results()
  }
}
