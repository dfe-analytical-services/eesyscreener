#' Check that a ZIP file has a flat (non-nested) structure
#'
#' Verifies that no file entry within the ZIP is inside a subdirectory.
#' Directory entries (trailing `/`) are normalised before checking. Any entry
#' that still contains a `/` after normalisation is considered nested and
#' causes a FAIL. This catches nested folders, OS artefacts such as
#' `__MACOSX/._file`, and any other non-root paths.
#'
#' @param file_entries A character vector of file paths as returned by
#'   `zip::zip_list(zippath)$filename`.
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_zip_readable return
#'
#' @family check_zip
#'
#' @examples
#' check_zip_flat_structure(c("data.csv", "data.meta.csv"))
#' check_zip_flat_structure(c("data.csv", "subdir/data.meta.csv"))
#' @export
check_zip_flat_structure <- function(
  file_entries,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  # Strip trailing slash from directory entries, then check for remaining
  # slashes
  normalized <- sub("/$", "", file_entries)
  nested <- grepl("/", normalized)

  if (any(nested)) {
    nested_files <- file_entries[nested]
    return(test_output(
      test_name,
      "FAIL",
      format_file_list(
        nested_files,
        "ZIP contains files in subdirectories: ",
        suffix = ""
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  test_output(
    test_name,
    "PASS",
    "All files are at the root level of the ZIP.",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
