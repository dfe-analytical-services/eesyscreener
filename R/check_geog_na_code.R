#' Check 'Not available' location codes
#'
#' Checks that for geographic levels with code and name column pairs, any
#' location with a name of 'Not available' has the corresponding GSS
#' not-available code 'x'. Levels without a code column (RSC region) and
#' levels with their own combo lookups (National, Regional etc)
#' are excluded. Rows at Institution and Planning area level are also
#' excluded as they are ignored by EES.
#'
#' If no applicable geographic levels are present in the data, the check
#' passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_na_code(example_data)
#' check_geog_na_code(example_data, verbose = TRUE)
#' @export
check_geog_na_code <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  test_name <- get_check_name()

  # Levels excluded from this check:
  # - National, Regional, LA etc: have dedicated combo lookup checks
  # - RSC region: has no code column
  # - Institution, Planning area: ignored by EES
  excluded_levels <- c(
    "National",
    "Regional",
    "Local authority",
    "Local authority district",
    "Parliamentary constituency",
    "Ward",
    "Local enterprise partnership",
    "Local skills improvement plan area",
    "English devolved area",
    "RSC region",
    "Institution",
    "Planning area"
  )

  testable <- eesyscreener::geography_df |>
    dplyr::filter(!.data$geographic_level %in% excluded_levels)

  levels_in_data <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  testable_present <- testable[testable$geographic_level %in% levels_in_data, ]

  if (nrow(testable_present) == 0) {
    return(test_output(
      test_name,
      "PASS",
      paste0(
        "No applicable geographic levels to check for 'Not available' codes."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  data_cols <- dplyr::tbl_vars(data)

  failing_levels <- lapply(seq_len(nrow(testable_present)), function(i) {
    level <- testable_present$geographic_level[i]
    code_col <- testable_present$code_field[i]
    name_col <- testable_present$name_field[i]

    if (!all(c(code_col, name_col) %in% data_cols)) {
      return(NULL)
    }

    code_sym <- rlang::sym(code_col)
    name_sym <- rlang::sym(name_col)

    n_bad <- data |>
      dplyr::filter(.data$geographic_level == level) |>
      dplyr::filter(!!name_sym == "Not available", !!code_sym != "x") |>
      dplyr::count() |>
      dplyr::pull("n")

    if (n_bad > 0) level else NULL
  }) |>
    Filter(Negate(is.null), x = _) |>
    unlist()

  if (length(failing_levels) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0(
        "No locations have a name of 'Not available' without the ",
        "corresponding code 'x'."
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
        "{?has/have} at least one location with a name of 'Not available' ",
        "that does not have the corresponding code 'x': '",
        paste0(failing_levels, collapse = "', '"),
        "'. The code for 'Not available' should always be 'x'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
