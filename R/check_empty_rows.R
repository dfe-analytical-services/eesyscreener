#' Check for empty rows in data
#'
#' This function checks for empty rows in a given data set and returns a list
#' with the check result and a message.
#'
#' @param data A data frame to be checked for empty rows.
#' @param file_type An optional string indicating the type of file being
#' checked. This will be included in the output check name.
#'
#' @return A list containing:
#' \describe{
#'   \item{check}{Character string with the stage that the check belongs to.}
#'   \item{result}{Character string, either "PASS", "FAIL" or "ADVISORY".}
#'   \item{message}{Character string with feedback about the check.}
#' }
#' @examples
#' data <- data.frame(a = c(1, 2, NA, 4), b = c(NA, 2, 3, 4))
#' check_empty_rows(data)
#'
#' @export
check_empty_rows <- function(data, file_type = NULL) {
  output <- list("check" = paste0("check_", file_type, "_empty_rows"))

  blank_rows <- sum(apply(data, 1, function(row) all(is.na(row) | row == "")))

  if (blank_rows == 0) {
    output$result <- "PASS"
    output$message <- paste(
      "The", file_type, "file does not have any blank rows."
    )
  } else {
    if (blank_rows == 1) {
      output$result <- "FAIL"
      output$message <- paste(
        "There is 1 blank row in the", file_type, "file. Try opening the CSV",
        "in notepad if you're not sure where the blank rows are."
      )
    } else {
      output$result <- "FAIL"
      output$message <- paste(
        "There are", format(blank_rows, big.mark = ","), "blank rows in the",
        file_type, "file. Try opening the CSV in notepad if you're not sure",
        "where the blank rows are."
      )
    }
  }

  return(output)
}
