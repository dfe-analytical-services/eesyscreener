#' Check for empty rows
#'
#' This function checks for empty rows in a given data frame and returns a list
#' with the check result and a message.
#'
#' Filename is optional and is used to populate the feedback message.
#'
#' @param df The data frame to be check
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
#' check_empty_rows(df, "datafile.csv")
#' check_empty_rows(df)
#'
#' @export
check_empty_rows <- function(df, filename = NULL) {
  output <- list("check" = paste0("check_empty_rows"))

  # blank_rows <- nrow(data) - nrow(
  #   janitor::remove_empty(data, which = "rows", quiet = TRUE)
  # )

  blank_rows <- sum(rowSums(is.na(df) | df == "") == ncol(df))

  filename <- ifelse(
    is.null(filename),
    "the tested data frame",
    paste0("'", filename, "'")
  )

  if (blank_rows == 0) {
    output$result <- "PASS"
    output$message <- paste(
      filename, "does not have any blank rows."
    )
  } else {
    if (blank_rows == 1) {
      output$result <- "FAIL"
      output$message <- paste0(
        "There is 1 blank row in ", filename, ". Try opening the CSV ",
        "in notepad if you're not sure where the blank rows are."
      )
    } else {
      output$result <- "FAIL"
      output$message <- paste0(
        "There are ", format(blank_rows, big.mark = ","), " blank rows in ",
        filename, ". Try opening the CSV in notepad if you're not ",
        "sure where the blank rows are."
      )
    }
  }

  return(output)
}
