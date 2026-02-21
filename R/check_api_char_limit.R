#' Check if column names exceed a character limit
#'
#' Uses the `api_char_limit` function to check if any column names in the
#' provided data frame exceed the character limit specified in the
#' `api_char_limits` data frame.
#'
#' @inheritParams precheck_col_req_data
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_char_col_name(example_data)
#' @export
check_api_char_col_name <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  api_char_limit(
    names(data),
    "column-name",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check if column labels exceed a character limit
#'
#' Uses the `api_char_limit` function to check if any column labels in the
#' provided metadata frame exceed the character limit specified in the
#' `api_char_limits` data frame.
#'
#' @inheritParams precheck_col_req_meta
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_char_col_label(example_meta)
#' @export
check_api_char_col_label <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  labels <- as.character(meta$label)

  api_char_limit(
    labels,
    "column-label",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check if location codes exceed a character limit
#'
#' Uses the `api_char_limit` function to check if any location codes in the
#' provided metadata frame exceed the character limit specified in the
#' `api_char_limits` data frame.
#'
#' @inheritParams precheck_col_req_data
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_char_loc_code(example_data)
#' @export
check_api_char_loc_code <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  location_code_cols <- intersect(
    names(data),
    get_geo_code_cols()
  )

  location_codes <- location_code_cols |>
    lapply(function(col) unique(data[[col]])) |>
    unlist(use.names = FALSE)

  api_char_limit(
    location_codes,
    "location-code",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check if filter items or location names exceed character limit
#'
#' Checks if any values in filters, filter groups, or location names exceed the
#' character limit specified in the `api_char_limits` data frame, using the
#' `api_char_limit` function.
#'
#' @inheritParams precheck_col_to_rows
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_char_filter_items(example_data, example_meta)
#' @export
check_api_char_filter_items <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  location_name_cols <- get_geo_name_cols()
  filters_and_groups <- get_filters(meta, include_filter_groups = TRUE)

  cols_to_check <- intersect(
    names(data),
    unique(c(filters_and_groups, location_name_cols))
  )

  values_to_check <- cols_to_check |>
    lapply(function(col) unique(data[[col]])) |>
    unlist(use.names = FALSE)

  api_char_limit(
    values_to_check,
    "column-item",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
