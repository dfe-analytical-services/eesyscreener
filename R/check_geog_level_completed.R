#' Check geographic level columns are completed
#'
#' For each geographic level present in the data, checks that the associated
#' columns (code field, name field, and secondary code field where applicable)
#' contain no NA values. The `new_la_code` column is excluded from this check
#' as it can legitimately be blank for older Local authority records.
#' Rows at Planning area level are excluded as they are not used in the table
#' tool.
#'
#' Three cases result in a silent PASS, each intentionally caught by a
#' dedicated check elsewhere in the screening pipeline:
#'
#' - **Planning area rows**: excluded here; flagged by
#'   [check_geog_ignored_rows()].
#' - **Invalid geographic levels** (not present in `geography_df`): skipped
#'   here; caught upstream by `precheck_geog_level()`.
#' - **Missing geography columns** (e.g. `region_code` absent from the data
#'   entirely): silently skipped here; caught by [check_geog_la_col_present()]
#'   and [check_geog_region_col_present()].
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_level_completed(example_data)
#' check_geog_level_completed(example_data, verbose = TRUE)
#' @export
check_geog_level_completed <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  # Build testable geography reference:
  # - exclude Planning area (not used in the table tool)
  # - exclude new_la_code (legitimately blank for old LA records)
  testable_geog <- eesyscreener::geography_df |>
    dplyr::filter(.data$geographic_level != "Planning area") |>
    dplyr::mutate(
      code_field = dplyr::if_else(
        .data$code_field == "new_la_code",
        NA_character_,
        .data$code_field
      )
    )

  levels_in_data <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  # Levels not in geography_df (e.g. invalid values) silently produce 0 rows
  # here; precheck_geog_level() catches those upstream before this runs.
  testable_present <- testable_geog[
    testable_geog$geographic_level %in% levels_in_data,
  ]

  if (nrow(testable_present) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "No valid geographic levels present in the data to test.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  data_cols <- dplyr::tbl_vars(data)

  incomplete_cols <- lapply(seq_len(nrow(testable_present)), function(i) {
    level <- testable_present$geographic_level[i]
    expected_cols <- c(
      testable_present$code_field[i],
      testable_present$name_field[i],
      testable_present$code_field_secondary[i]
    )
    # Columns absent from the data entirely are silently skipped; their
    # absence is caught by check_geog_la_col_present() /
    # check_geog_region_col_present().
    expected_cols <- expected_cols[
      !is.na(expected_cols) & expected_cols %in% data_cols
    ]

    level_rows <- data |>
      dplyr::filter(.data$geographic_level == level)

    cols_with_na <- vapply(
      expected_cols,
      function(col) {
        col_sym <- rlang::sym(col)
        level_rows |>
          dplyr::filter(is.na(!!col_sym) | !!col_sym == "") |>
          dplyr::count() |>
          dplyr::pull("n") >
          0
      },
      logical(1)
    )

    expected_cols[cols_with_na]
  }) |>
    unlist()

  if (length(incomplete_cols) == 0) {
    test_output(
      test_name,
      "PASS",
      "All geographic level columns are completed as expected.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(incomplete_cols))}",
        "column{?s} {?is/are} incomplete for the associated geographic ",
        "level: '",
        paste0(incomplete_cols, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
