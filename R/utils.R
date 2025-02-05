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
