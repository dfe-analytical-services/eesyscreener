#' Check NA geography codes have the correct name
#'
#' For geographic levels that have both a code and a name column, checks that
#' any location with the GSS not-available code `"x"` also has the
#' corresponding name `"Not available"`. Applies to all geographic levels
#' except National, Regional, Local authority, RSC region, Institution, and
#' Planning area.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_na(example_data)
#' check_geog_na(example_data, verbose = TRUE)
#' @export
check_geog_na <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  test_name <- get_check_name()

  excluded_levels <- c(
    "National",
    "Regional",
    "Local authority",
    "Institution",
    "Planning area"
  )

  testable_geog <- eesyscreener::geography_df[
    !eesyscreener::geography_df$geographic_level %in% excluded_levels &
      !is.na(eesyscreener::geography_df$code_field) &
      !is.na(eesyscreener::geography_df$name_field),
  ]

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  testable_present <- testable_geog[
    testable_geog$geographic_level %in% levels_present,
  ]

  if (nrow(testable_present) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "No applicable geographic levels to test.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  failing_levels <- character(0)

  for (i in seq_len(nrow(testable_present))) {
    code_col <- testable_present$code_field[i]
    name_col <- testable_present$name_field[i]
    level <- testable_present$geographic_level[i]

    if (!all(c(code_col, name_col) %in% dplyr::tbl_vars(data))) {
      next
    }

    code_sym <- rlang::sym(code_col)
    name_sym <- rlang::sym(name_col)

    invalid <- data |>
      dplyr::distinct(!!code_sym, !!name_sym) |>
      dplyr::filter(
        !!code_sym == "x" & !!name_sym != "Not available"
      ) |>
      dplyr::collect()

    if (nrow(invalid) > 0) {
      failing_levels <- c(failing_levels, level)
    }
  }

  if (length(failing_levels) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0(
        "No tested locations have a code of 'x' without the corresponding ",
        "name 'Not available'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following geographic ",
        "{cli::qty(length(failing_levels))}level{?s} ",
        "{?has/have} at least one location with a code of 'x' but without ",
        "the corresponding name 'Not available': '",
        paste0(failing_levels, collapse = "', '"),
        "'. The name for 'x' should always be 'Not available'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
