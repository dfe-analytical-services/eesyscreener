#' Check for rows ignored by the EES table tool
#'
#' Identifies rows at geographic levels that are ignored by the EES table tool:
#' School, Provider, Institution, and Planning area. Highlights in the message
#' if any such rows are present alongside other levels, and fails if:
#' - School and Provider data have been mixed together
#' OR
#' - The file only contains Planning area or Institution data
#'
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_ignored_rows(example_data)
#' @export
check_geog_ignored_rows <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  # Count rows visible to the EES table tool
  # (excludes Institution and Planning area)
  table_tool_rows <- data |>
    dplyr::filter(
      !.data$geographic_level %in% c("Institution", "Planning area")
    ) |>
    dplyr::count() |>
    dplyr::pull("n")

  # If all rows are at levels invisible to the table tool, warn
  if (table_tool_rows == 0) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "This file only contains rows at Institution or Planning area level, ",
        "which are ignored by the EES table tool. Consider uploading this as ",
        "an ancillary file without the metadata."
      ),
      guidance_url = render_url("statistics-production/ud.html"),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Count rows that will be ignored by the table tool
  ignored_levels <- c("School", "Provider", "Institution", "Planning area")
  potential_ignored_rows <- data |>
    dplyr::filter(.data$geographic_level %in% ignored_levels) |>
    dplyr::count() |>
    dplyr::pull("n")

  if (potential_ignored_rows == 0) {
    return(test_output(
      test_name,
      "PASS",
      "No rows in the file will be ignored by the EES table tool.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Get distinct geographic levels present
  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  # Single School or Provider level data is acceptable
  if (
    length(levels_present) == 1 && levels_present %in% c("School", "Provider")
  ) {
    return(test_output(
      test_name,
      "PASS",
      "No rows in the file will be ignored by the EES table tool.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Mixed School and Provider is not allowed
  if (all(c("School", "Provider") %in% levels_present)) {
    return(test_output(
      test_name,
      "FAIL",
      paste0(
        "School and Provider data has been mixed - please contact the ",
        "Explore education statistics platforms team."
      ),
      guidance_url = render_url("statistics-production/ud.html"),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Some rows will be ignored by the table tool
  test_output(
    test_name,
    "PASS",
    cli::pluralize(
      "{potential_ignored_rows} row{?s} will be ignored by the EES table ",
      "tool, at School, Provider, Institution, or Planning area level."
    ),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
