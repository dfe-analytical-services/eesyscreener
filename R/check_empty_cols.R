#' Check for empty columns
#'
#' This function checks for empty cols in a given data frame and returns a list
#' with the check result and a message.
#'
#' Filename is optional and is used to populate the feedback message.
#'
#' @param df The data frame to check
#' @inheritParams check_filename_spaces
#'
#' @return A list containing:
#' \describe{
#'   \item{check}{Character string with the stage that the check belongs to.}
#'   \item{result}{Character string, either "PASS", "FAIL" or "ADVISORY".}
#'   \item{message}{Character string with feedback about the check.}
#' }
#' @examples
#' df <- eesyscreener::example_data
#' check_empty_cols(df, "datafile.csv")
#' check_empty_cols(df)
#'
#' @export
check_empty_cols <- function(df, filename = NULL) {
  output <- list("check" = paste0("check_empty_cols"))

  # Check only for NA cols, as "" is ridiculously slow to check for large files
  blank_cols <- setdiff(
    names(df),
    names(janitor::remove_empty(df, which = "cols", quiet = TRUE))
  )

  filename <- null_filename(filename)
  blank_cols_len <- length(blank_cols)

  if (blank_cols_len == 0) {
    output$result <- "PASS"
    output$message <- paste(
      filename, "does not have any blank columns."
    )
  } else {
    if (blank_cols_len == 1) {
      output$result <- "FAIL"
      output$message <- paste0(
        "The following column in ", filename, " is empty: '", blank_cols,
        "'."
      )
    } else {
      output$result <- "FAIL"
      output$message <- paste0(
        "The following columns in ", filename, " are empty: '",
        paste0(blank_cols, collapse = "', '"), "'."
      )
    }
  }

  return(output)
}
