#' Check for special characters in filename
#'
#' This function checks if the provided filename contains any special
#' characters.
#'
#' @inheritParams check_filename_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family filename
#'
#' @examples
#' check_filename_special("datafile.csv")
#' check_filename_special("data+file.meta.csv", verbose = FALSE)
#' check_filename_special("datafile.meta.csv", custom_name = "meta")
#' @export
check_filename_special <- function(
  filename,
  custom_name = NULL,
  verbose = TRUE
) {
  test_name <- paste0("check_filename_", custom_name, "_special")

  strip_extension <- tools::file_path_sans_ext(filename)
  cleaned_filename <- gsub("\\.meta$", "", strip_extension)

  if (grepl("[^[:alnum:]]", gsub("-|_|\\s", "", cleaned_filename))) {
    present_special_characters <- unique(
      unlist(
        stringr::str_split(
          gsub("[A-Za-z0-9]|-|_|\\s", "", cleaned_filename),
          ""
        ),
        use.names = FALSE
      )
    )

    return(
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following special characters need removing from ",
          filename,
          " (filename): ",
          paste0(present_special_characters, collapse = " "),
          ". Filenames must only contain numbers, letters, hyphens or",
          " underscores."
        ),
        console = verbose
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0("'", filename, "' does not contain any special characters."),
      console = verbose
    )
  }
}
