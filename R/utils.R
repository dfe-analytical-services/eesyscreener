#' Handle null filenames
#'
#' Helper function to handle null filenames and return a string for the
#' message.
#'
#' @param string filename in to be transformed
#' @keywords internal
#' @returns string
null_filename <- function(string = NULL) {
  ifelse(is.null(string), "the tested data frame", paste0("'", string, "'"))
}

#' Controllable console messages
#'
#' Quick expansion to the `message()` function aimed for use in functions for
#' an easy addition of a global verbose TRUE / FALSE argument to toggle the
#' messages on or off
#'
#' @param ... any message you would normally pass into `message()`. See
#' \code{\link{message}} for more details
#'
#' @param verbose logical, usually a variable passed from the function you are
#' using this within
#'
#' @return No return value, called for side effects
#'
#' @keywords internal
toggle_message <- function(..., verbose) {
  if (verbose) {
    message(...)
  }
}
