#' Check for duplicate rows in data
#'
#' Checks for duplicate rows across observational unit and filter columns.
#' School, Provider, Institution, and Planning area rows are handled specially:
#' when data contains exclusively School or Provider rows, only Institution and
#' Planning area rows are excluded before checking. In all other cases, School,
#' Provider, Institution, and Planning area rows are all excluded from the
#' duplicate check.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_general
#'
#' @examples
#' check_general_dupes(example_data, example_meta)
#' check_general_dupes(example_data, example_meta, verbose = TRUE)
#' @export
check_general_dupes <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  ob_units <- get_acceptable_ob_units()
  filters_and_groups <- get_filters(meta, include_filter_groups = TRUE)
  check_cols <- intersect(c(ob_units, filters_and_groups), names(data))

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  school_provider_only <- length(levels_present) == 1 &&
    levels_present %in% c("School", "Provider")

  if (school_provider_only) {
    exclude_levels <- c("Institution", "Planning area")
    note <- paste0(
      "Note that Institution and Planning area rows were",
      " not included in this check."
    )
  } else {
    exclude_levels <- c("School", "Provider", "Institution", "Planning area")
    note <- paste0(
      "Note that School, Provider, Institution, and Planning area rows",
      " were not included in this check."
    )
  }

  filtered_data <- data |>
    dplyr::filter(!.data$geographic_level %in% exclude_levels) |>
    dplyr::select(dplyr::all_of(check_cols))

  # count() is used rather than nrow(), and distinct() is compared against the
  # total count rather than using count(across(everything())), to avoid
  # materialisation under duckplyr stingy mode.
  n_total <- filtered_data |>
    dplyr::count() |>
    dplyr::pull("n")

  n_distinct <- filtered_data |>
    dplyr::distinct() |>
    dplyr::count() |>
    dplyr::pull("n")

  n_dupe_rows <- n_total - n_distinct

  if (n_dupe_rows == 0) {
    test_output(
      test_name,
      "PASS",
      paste0("There are no duplicate rows in the data file. ", note),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      paste0(
        cli::pluralize(
          "{cli::qty(n_dupe_rows)}There {?is/are} {n_dupe_rows}",
          " duplicate row{?s} in the data file."
        ),
        " ",
        note
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
