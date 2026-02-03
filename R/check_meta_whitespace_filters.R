#' Check no filter values have leading or trailing whitespaces
#'
#' This function checks if the provided filter values contain any leading or trailing whitespaces.
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
  filters <- meta |>
    dplyr::filter(col_type == "Filter") |>
    dplyr::pull(col_name)

  geo_cols <- as.character(geography_df[, 2:4])
  geo_cols <- geo_cols[!is.na(geo_cols)]

  col_names <- data |>
    dplyr::mutate_if(lubridate::is.Date, as.character) |>
    dplyr::select(
      dplyr::all_of(filters),
      dplyr::any_of(geo_cols)
    ) |>
    dplyr::mutate_if(is.numeric, as.character) |>
    tidyr::pivot_longer(
      dplyr::everything(),
      values_drop_na = TRUE,
      names_to = "filter",
      values_to = "filter_label"
    ) |>
    dplyr::distinct()

  filter_values_trimmed <- filter_values |>
    dplyr::mutate(filter_label = stringr::str_trim(filter_label))

  white_spaces <- dplyr::setdiff(filter_values, filter_values_trimmed) |>
    dplyr::pull(filter_label)

  if (length(white_spaces) == 0) {
    test_output(
      "meta_whitespace_filters",
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
      glue::glue(
        "The following filter label",
        "{if (count_ws != 1) 's' else ''}",
        " contain{if (count_ws != 1) '' else 's'}",
        " leading or trailing whitespace: ",
        "'{paste0(white_spaces, collapse = \"', '\")}'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
