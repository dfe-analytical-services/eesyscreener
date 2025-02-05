#' Check for spaces in filename
#'
#' This function checks if the provided filename contains any spaces.
#'
#' @param filename A character string of the filename to check
#'
#' @inherit check_empty_cols return
#'
#' @examples
#' check_filename_spaces("datafile.csv")
#' check_filename_spaces("data file.meta.csv")
#' @export
check_filename_spaces <- function(filename) {
  output <- list("check" = "check_filename_spaces")

  if (grepl(" ", filename)) {
    output$result <- "FAIL"
    output$message <- paste0(
      "There are spaces that need removing in '",
      filename,
      "' (filename)."
    )
  } else {
    output$result <- "PASS"
    output$message <- paste0(
      "'", filename, "' does not have spaces in the filename."
    )
  }

  return(output)
}
