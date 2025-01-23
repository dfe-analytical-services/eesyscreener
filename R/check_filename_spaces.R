#' Check for spaces in filename
#'
#' This function checks if the provided filename contains any spaces.
#'
#' @param data A character string representing the data filename.
#' @return A list containing:
#' \describe{
#'   \item{result}{Character string, either "PASS", "FAIL" or "ADVISORY".}
#'   \item{message}{Character string with feedback about the check.}
#'   \item{check}{Character string with the stage that the check belongs to.}
#' }
#' @examples
#' filename_spaces("datafile.csv", "data")
#' filename_spaces("data file.csv", "data")
#' filename_spaces("data_file.meta.csv", "metadata")
#' @export
check_filename_spaces <- function(filename, file_type) {
  output <- list("check" = paste0(file_type, "filename_spaces"))

  if (grepl(" ", filename)) {
    output$result <- "FAIL"
    output$message <- paste(
        "There are spaces that need removing in filename of the",
        file_type,
        "file."
      )
  } else {
    output$result <- "PASS"
    output$message <- paste("The", file_type, "filename does not have spaces.")
  }

  return(output)
}
