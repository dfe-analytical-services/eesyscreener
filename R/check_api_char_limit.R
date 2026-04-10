#' Check if any values are longer than a specified length
#'
#' Helper function to check if any values in a vector exceed a specified
#' length. Used for validating column names and values within columns.
#'
#' @param values character vector of values to check
#' @param max_length maximum allowed character length for values
#'
#' @returns a data.frame with columns 'value', 'length', and 'exceeds_max'
#' @keywords internal
#' @noRd
char_limits <- function(values, max_length) {
  lengths <- nchar(values)
  exceeds_max <- lengths > max_length

  data.frame(
    value = values,
    length = lengths,
    exceeds_max = exceeds_max
  )
}

#' Check if values exceed a character limit
#'
#' Helper function that can be used to check individual strings, or vectors
#' of strings.
#'
#' Uses the exported `api_char_limits` data.frame as a reference for the
#' limits.
#'
#' @param values A character vector of strings to check
#' @param type A character string specifying the type of values being checked,
#' one of "location-code", "column-name", "column-label" or "column-item".
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @examples
#' api_char_limit(names(example_data), "column-name")
#' api_char_limit(names(example_data), "column-name", verbose = TRUE)
#' @noRd
#' @keywords internal
api_char_limit <- function(
  values,
  type,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (!is.character(values)) {
    cli::cli_abort("`values` must be a character vector.")
  }
  if (!type %in% eesyscreener::api_char_limits$id) {
    cli::cli_abort(
      paste(
        "`type` must be one of: {paste(eesyscreener::api_char_limits$id,",
        "collapse = ', ')}"
      )
    )
  }

  type_to_name <- c(
    "column-name" = "col_name",
    "column-label" = "col_label",
    "location-code" = "loc_code",
    "column-item" = "filter_items"
  )
  test_name <- paste0("api_char_", type_to_name[[type]])
  max_length <- eesyscreener::api_char_limits$char_limit[
    eesyscreener::api_char_limits$id == type
  ]
  # Filter out NAs — missing values are not a character limit violation and
  # are caught by other checks (e.g. check_meta_label, check_meta_col_name)
  values <- values[!is.na(values)]

  results <- char_limits(values, max_length)
  pretty_type <- eesyscreener::api_char_limits$name[
    eesyscreener::api_char_limits$id == type
  ]

  if (any(results$exceeds_max)) {
    fail_values <- results$value[results$exceeds_max]
    return(
      test_output(
        test_name,
        "WARNING",
        paste0(
          "The following ",
          pretty_type,
          " exceed the character limit of ",
          max_length,
          " for type '",
          type,
          "': ",
          paste(shQuote(fail_values), collapse = ", "),
          "."
        ),
        render_url(
          paste0(
            "statistics-production/api-data-standards.html",
            "#character-limits-for-col_names-and-filter-items"
          )
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0(
        "All ",
        pretty_type,
        " are less than or equal to the character limit of ",
        max_length,
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

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
    data |> dplyr::tbl_vars(),
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
    data |> dplyr::tbl_vars(),
    get_geo_code_cols()
  )

  location_codes <- location_code_cols |>
    lapply(function(col) {
      data |>
        dplyr::select(dplyr::all_of(col)) |>
        dplyr::distinct() |>
        dplyr::pull(1)
    }) |>
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
    data |> dplyr::tbl_vars(),
    unique(c(filters_and_groups, location_name_cols))
  )

  values_to_check <- cols_to_check |>
    lapply(function(col) {
      data |>
        dplyr::select(dplyr::all_of(col)) |>
        dplyr::distinct() |>
        dplyr::pull(1)
    }) |>
    unlist(use.names = FALSE)

  api_char_limit(
    values_to_check,
    "column-item",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
