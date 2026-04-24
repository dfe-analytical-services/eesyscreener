#' Check that a ZIP file exists and is readable
#'
#' Verifies that the path points to an existing file with a `.zip` extension,
#' then attempts to list its contents with `zip::zip_list()`. Returns FAIL if
#' the file is missing, is not a `.zip`, or is corrupt/unreadable.
#'
#' @param zippath A character string giving the path to the ZIP file.
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @return a single row data frame
#'
#' @family check_zip
#'
#' @examples
#' \dontrun{
#' check_zip_readable("path/to/upload.zip")
#' }
#' @export
check_zip_readable <- function(zippath, verbose = FALSE, stop_on_error = FALSE) {
  test_name <- get_check_name()

  if (!file.exists(zippath) || isTRUE(file.info(zippath)$isdir)) {
    return(test_output(
      test_name,
      "FAIL",
      paste0("No file found at: '", zippath, "'."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (!grepl("\\.zip$", zippath, ignore.case = TRUE)) {
    return(test_output(
      test_name,
      "FAIL",
      paste0("File does not have a .zip extension: '", zippath, "'."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  zip_contents <- tryCatch(
    zip::zip_list(zippath),
    error = function(e) e
  )

  if (inherits(zip_contents, "error")) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "ZIP file could not be read: '", basename(zippath), "'. ",
        conditionMessage(zip_contents)
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    paste0("ZIP file is readable: '", basename(zippath), "'."),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
