#' Quick check of data columns vs metadata rows
#'
#' There are 5 mandatory observational unit columns in every data file, so
#' there should always be at least 5 more columns in the data file than there
#' are rows in the metadata file.
#'
#' @param data A data frame of the data file
#' @param meta A data frame of the metadata file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_col_to_rows(example_data, example_meta)
#' precheck_col_to_rows(example_data, example_meta, verbose = TRUE)
#' @export
precheck_col_to_rows <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  data_cols <- length(dplyr::tbl_vars(data)) - 5
  meta_rows <- nrow(meta)

  if (data_cols < meta_rows) {
    test_output(
      "col_to_rows",
      "FAIL",
      paste0(
        "There are more rows in the metadata file (",
        paste(format(meta_rows, big.mark = ",")),
        ") than the number of non-mandatory columns in the data file (",
        paste(format(data_cols, big.mark = ",")),
        "). This is not expected, please check the csv files. It can often",
        " be helpful open them in a text editor such as wordpad to investigate."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (data_cols == meta_rows) {
      test_output(
        "col_to_rows",
        "PASS",
        paste0(
          "There are an equal number of rows in the metadata file (",
          paste(format(meta_rows, big.mark = ",")),
          ") and non-mandatory columns in the data file (",
          paste(format(data_cols, big.mark = ",")),
          ")."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "col_to_rows",
        "PASS",
        paste0(
          "There are fewer rows in the metadata file (",
          paste(format(meta_rows, big.mark = ",")),
          ") than non-mandatory columns in the data file (",
          paste(format(data_cols, big.mark = ",")),
          ")."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
