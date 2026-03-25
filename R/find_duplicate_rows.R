#' Identify duplicate rows
#'
#' Identify duplicate rows in a data set
#'
#' @inheritParams precheck_col_req_data
#'
#' @examples
#' find_duplicate_rows(bind_rows(example_data, example_data), example_meta)
#' @export
find_duplicate_rows <- function(data, meta){
  columns <- c(
    "time_period",
    "time_identifier",
    "geographic_level",
    names(data)[names(data) %in% c(eesyscreener::geography_df$name_field, eesyscreener::geography_df$code_field)],
    get_cols_meta(meta, grouping_cols = TRUE)
  )
  data |> 
    dplyr::summarise(row_count = dplyr::n(), .by = columns) |>
    dplyr::filter(row_count > 1)
}