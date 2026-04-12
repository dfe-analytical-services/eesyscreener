#' Check for geography name to code duplicates in lower-level geographies
#'
#' Checks that each geography name maps to only one code for Opportunity area,
#' MAT, and Sponsor rows. A geography name with multiple different codes
#' indicates a data quality issue.
#'
#' If none of the lower-level geography levels (Opportunity area, MAT, Sponsor)
#' are present in the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_other_dupes(example_data)
#' check_geog_other_dupes(example_data, verbose = TRUE)
#' @export
check_geog_other_dupes <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  lower_level_geogs <- list(
    list(
      level = "Opportunity area",
      code_col = "opportunity_area_code",
      name_col = "opportunity_area_name"
    ),
    list(
      level = "MAT",
      code_col = "trust_id",
      name_col = "trust_name"
    ),
    list(
      level = "Sponsor",
      code_col = "sponsor_id",
      name_col = "sponsor_name"
    )
  )

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  relevant_geogs <- Filter(
    function(g) g$level %in% levels_present,
    lower_level_geogs
  )

  if (length(relevant_geogs) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "Lower-level geography data is not present in this data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  multi_code_names <- character(0)

  for (g in relevant_geogs) {
    col_names <- c(g$code_col, g$name_col)

    if (!all(col_names %in% dplyr::tbl_vars(data))) {
      next
    }

    code_sym <- rlang::sym(g$code_col)
    name_sym <- rlang::sym(g$name_col)

    dupe_rows <- data |>
      dplyr::filter(.data$geographic_level == g$level) |>
      dplyr::distinct(!!name_sym, !!code_sym) |>
      dplyr::count(!!name_sym, name = "n_codes") |>
      dplyr::filter(.data$n_codes > 1) |>
      dplyr::collect()

    if (nrow(dupe_rows) > 0) {
      multi_code_names <- c(
        multi_code_names,
        paste0(
          dupe_rows[[g$name_col]],
          " - ",
          dupe_rows$n_codes,
          " different codes"
        )
      )
    }
  }

  if (length(multi_code_names) == 0) {
    test_output(
      test_name,
      "PASS",
      "Every geography has one code.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following ",
        "{cli::qty(length(multi_code_names))}{?geography/geographies}",
        " {?has/have} multiple codes: '",
        paste0(multi_code_names, collapse = "', '"),
        "'. Each geography should have only one code."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
