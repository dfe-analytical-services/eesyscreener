#' Check no filter labels have leading or trailing whitespaces
#'
#' This function checks if the provided filter labels contain any leading or trailing whitespaces.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_whitespace_filters(example_data, example_meta)
#' check_meta_whitespace_filters(example_data, example_meta, verbose = TRUE)
#' @export
check_meta_whitespace_filters <- function(
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

  col_names_trimmed <- col_names |>
    dplyr::mutate(filter_label = stringr::str_trim(filter_label))

  white_spaces <- dplyr::setdiff(col_names, col_names_trimmed) |>
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
    if (length(white_spaces) == 1) {
      test_output(
        "meta_whitespace_filters",
        "FAIL",
        paste0(
          "The following filter label contains leading or trailing whitespace: '",
          paste0(white_spaces, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "meta_whitespace_filters",
        "FAIL",
        paste0(
          "The following filter labels contain leading or trailing whitespace: '",
          paste0(white_spaces, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
