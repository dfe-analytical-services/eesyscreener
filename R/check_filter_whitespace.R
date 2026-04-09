#' Check no filter values have leading or trailing whitespace
#'
#' This function checks if the provided filter values contain any leading or trailing whitespace.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_whitespace(example_data, example_meta)
#' check_filter_whitespace(example_data, example_meta, verbose = TRUE)
#' @export
check_filter_whitespace <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  filters <- get_filters(meta)

  if (length(filters) == 0) {
    test_output(
      "filter_whitespace",
      "PASS",
      "No filters present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    geo_cols <- as.character(geography_df[, 2:4])
    geo_cols <- geo_cols[!is.na(geo_cols)]

    cols_to_check <- intersect(
      c(filters, geo_cols),
      dplyr::tbl_vars(data)
    )

    white_spaces <- unlist(lapply(cols_to_check, function(col) {
      vals <- data |>
        dplyr::select(dplyr::all_of(col)) |>
        dplyr::distinct() |>
        dplyr::pull(1) |>
        as.character()
      vals <- vals[!is.na(vals)]
      vals[vals != stringr::str_trim(vals)]
    }))

    if (length(white_spaces) == 0) {
      test_output(
        "filter_whitespace",
        "PASS",
        "No filter labels contain leading or trailing whitespace.",
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      count_ws <- length(white_spaces)

      test_output(
        "filter_whitespace",
        "FAIL",
        paste0(
          count_ws,
          " filter label(s) contain leading or trailing whitespace: ",
          paste0("'", white_spaces, "'", collapse = ", ")
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
