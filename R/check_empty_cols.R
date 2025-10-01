# TODO: Consider if this test is still needed.
# There's potential with the other col specific tests we don't need this?

# Both "" + NA (1) ~ 4.7 seconds for 6 million rows
# NA only (2) ~ 1.4 seconds for 6 million rows

#' Check for empty columns
#'
#' This function checks for empty cols in a given data frame and returns a list
#' with the check result and a message.
#'
#' Filename is optional and is used to populate the feedback message.
#' @keywords internal
#' @param df The data frame to check
#' @inheritParams check_filename_spaces
#'
#' @return a console message with feedback from the check or the output from
#' `test_output()`
#' @examples
#' df <- eesyscreener::example_data
#' check_empty_cols(df)
#' check_empty_cols(df, verbose = FALSE)
#' @export
check_empty_cols <- function(
  df,
  filename = NULL,
  verbose = TRUE,
  custom_name = NULL
) {
  test_name <- paste0("check_empty_cols_", custom_name)
  filename <- null_filename(filename)

  # Check only for NA cols, as "" is ridiculously slow to check for large files
  blank_cols <- setdiff(
    names(df),
    names(janitor::remove_empty(df, which = "cols", quiet = TRUE))
  )

  # Get the unique values for each column and check if any only has ""
  col_uniques <- lapply(df, function(col) unique(col))
  names(col_uniques) <- names(df)
  blank_cols <- c(
    blank_cols,
    names(Filter(function(x) length(x) == 1 && identical(x, ""), col_uniques))
  )

  blank_cols_len <- length(blank_cols)

  if (blank_cols_len == 0) {
    return(
      test_output(
        test_name,
        "PASS",
        paste(filename, "does not have any blank columns."),
        console = verbose
      )
    )
  } else {
    if (blank_cols_len == 1) {
      return(
        test_output(
          test_name,
          "FAIL",
          paste0(
            "The following column in ",
            filename,
            " is empty: '",
            blank_cols,
            "'."
          ),
          console = verbose
        )
      )
    } else {
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following columns in ",
          filename,
          " are empty: '",
          paste0(blank_cols, collapse = "', '"),
          "'."
        ),
        console = verbose
      )
    }
  }
}


#' Check for empty columns2
#'
#' This function checks for empty cols in a given data frame and returns a list
#' with the check result and a message.
#'
#' Filename is optional and is used to populate the feedback message.
#'
#' @param df The data frame to check
#' @inheritParams check_filename_spaces
#' @keywords internal
#' @return the output from `test_output()`
#' @examples
#' df <- eesyscreener::example_data
#' check_empty_cols2(df)
#' check_empty_cols2(df, verbose = FALSE)
#' @export
check_empty_cols2 <- function(
  df,
  filename = NULL,
  verbose = TRUE,
  custom_name = NULL
) {
  test_name <- paste0("check_empty_cols_", custom_name)
  filename <- null_filename(filename)

  # Check only for NA cols, as "" is ridiculously slow to check for large files
  blank_cols <- setdiff(
    names(df),
    names(janitor::remove_empty(df, which = "cols", quiet = TRUE))
  )

  blank_cols_len <- length(blank_cols)

  if (blank_cols_len == 0) {
    return(
      test_output(
        test_name,
        "PASS",
        paste(filename, "does not have any blank columns."),
        console = verbose
      )
    )
  } else {
    if (blank_cols_len == 1) {
      return(
        test_output(
          test_name,
          "FAIL",
          paste0(
            "The following column in ",
            filename,
            " is empty: '",
            blank_cols,
            "'."
          ),
          console = verbose
        )
      )
    } else {
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following columns in ",
          filename,
          " are empty: '",
          paste0(blank_cols, collapse = "', '"),
          "'."
        ),
        console = verbose
      )
    }
  }
}
