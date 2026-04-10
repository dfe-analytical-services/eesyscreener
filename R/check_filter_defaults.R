#' Check default filter values are present in data
#'
#' Ensures that all filter columns and filter groups in the metadata have a
#' default filter value (usually "Total"), and that this value is present in
#' the corresponding columns of the data file.
#'
#' @param data A character string of the data filename to check
#' @param meta A character string of the metadata filename to check
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_defaults(example_data, example_meta)
#' check_filter_defaults(example_filter_group, example_filter_group_meta)
#' @export
check_filter_defaults <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()
  guidance_url <- render_url(
    "statistics-production/ud.html#aggregates-and-default-filters"
  )

  # --- Extract filter defaults from meta (base R only, no dplyr) ---
  filter_names <- get_filters(meta)

  if (length(filter_names) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "There are no filters in the data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Get custom defaults where set, otherwise "Total"
  if ("filter_default" %in% names(meta)) {
    filter_rows <- meta$col_type == "Filter"
    raw_defaults <- meta$filter_default[filter_rows]
    defaults <- ifelse(
      is.na(raw_defaults) | raw_defaults == "",
      "Total",
      raw_defaults
    )
  } else {
    defaults <- rep("Total", length(filter_names))
  }
  filter_defaults <- stats::setNames(defaults, filter_names)

  # Add filter groups that aren't already in col_name (default always "Total")
  fg <- get_filter_groups(meta)
  fg_new <- fg[!fg %in% meta$col_name]
  if (length(fg_new) > 0) {
    filter_defaults <- c(
      filter_defaults,
      stats::setNames(rep("Total", length(fg_new)), fg_new)
    )
  }

  # --- Check each default exists in data (dplyr on duckplyr tibble) ---
  # pull() is the single intentional materialization point per column
  pre_result <- vapply(
    names(filter_defaults),
    function(column) {
      unique_vals <- data |>
        dplyr::select(dplyr::all_of(column)) |>
        dplyr::distinct() |>
        dplyr::pull(1)
      filter_defaults[[column]] %in% unique_vals
    },
    logical(1)
  )

  if (all(pre_result)) {
    test_output(
      test_name,
      "PASS",
      "All filters and groups have a default filter item present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    missing_total <- names(pre_result[!pre_result])
    test_output(
      test_name,
      "WARNING",
      paste0(
        "A 'Total' entry or default filter item should be",
        " specified for the following filters and",
        " / or filter_groups where applicable: '",
        paste(missing_total, collapse = "', '"),
        "'."
      ),
      guidance_url = guidance_url,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
