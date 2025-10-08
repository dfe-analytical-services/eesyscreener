#' Check indicator_dp is set for all indicator rows
#'
#' Throw warning if there are any blank cells for indicator_dp in rows, to
#' encourage users to explicitly specify the behaviour they want.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_ind_dp_set(example_meta)
#' check_meta_ind_dp_set(example_meta, verbose = TRUE)
#' @export
check_meta_ind_dp_set <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  blank_ind_dp <- meta |>
    dplyr::filter(.data$col_type == "Indicator") |>
    dplyr::filter(
      is.na(.data$indicator_dp) | trimws(.data$indicator_dp) == ""
    ) |>
    dplyr::pull("col_name")

  if (length(blank_ind_dp) == 0) {
    test_output(
      "meta_col_name",
      "PASS",
      "The indicator_dp column is completed for all indicators.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(blank_ind_dp) == 1) {
      test_output(
        "meta_col_name",
        "WARNING",
        paste0(
          paste(blank_ind_dp, collapse = "', '"),
          " does not have a specified number of decimal places in the",
          " metadata file, this should be explicitly stated where possible."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "meta_col_name",
        "WARNING",
        paste0(
          "The following indicators do not have a specified number of decimal",
          " places in the indicator_dp column of metadata file, explicitly ",
          "state this if possible: '",
          paste(blank_ind_dp, collapse = "', '"),
          "'"
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
