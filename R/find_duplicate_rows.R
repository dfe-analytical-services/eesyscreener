#' Identify duplicate rows
#'
#' Identify duplicate rows in a data set
#'
#' @inheritParams check_filename_spaces
#'
#' @examples
#' find_duplicate_rows(
#'   dplyr::bind_rows(example_data, example_data),
#'   example_meta
#' )
#' find_duplicate_rows(
#'   dplyr::bind_rows(example_data, example_data |> dplyr::mutate(enrolment_count = 5)),
#'   example_meta
#' )
#'
#' @export
find_duplicate_rows <- function(data, meta) {
  columns <- c(
    "time_period",
    "time_identifier",
    "geographic_level",
    names(data)[
      names(data) %in%
        c(
          eesyscreener::geography_df$name_field,
          eesyscreener::geography_df$code_field
        )
    ],
    get_cols_meta(meta, filters_only = TRUE, grouping_cols = TRUE)
  )
  data |>
    dplyr::summarise(row_count = dplyr::n(), .by = columns) |>
    dplyr::filter(row_count > 1)
}
