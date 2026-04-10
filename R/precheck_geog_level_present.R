#' Check we have the right columns for the geographic level
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_geog
#'
#' @examples
#' precheck_geog_level_present(example_data)
#' precheck_geog_level_present(example_data, verbose = TRUE)
#' precheck_geog_level_present(example_comma_data, verbose = TRUE)
#' @export
precheck_geog_level_present <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  geo_levels <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  if (all(geo_levels == "National")) {
    return(test_output(
      "geog_level_present",
      "PASS",
      "There is only National level data in the file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  expected_cols <- function(i) {
    # if a geographic level is present in the data, return its expected column
    # names (code_field, name_field, code_field_secondary) from geography_df
    if (i["geographic_level"] %in% geo_levels) {
      i[c("code_field", "name_field", "code_field_secondary")]
    }
  }
  # filter out the non table tool rows, then select only the columns needed
  geography_present <- eesyscreener::geography_df |>
    dplyr::filter(.data$geographic_level != "Planning area") |>
    dplyr::select(
      "geographic_level",
      "code_field",
      "name_field",
      "code_field_secondary"
    ) |>
    as.matrix()

  missing_cols <- unlist(apply(geography_present, 1, expected_cols))
  missing_cols <- missing_cols[!is.na(missing_cols)] |>
    setdiff(names(data))

  if (length(missing_cols) == 0) {
    test_output(
      "geog_level_present",
      "PASS",
      paste0(
        "The geography columns are present as expected for",
        " the geographic_level values in the file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    missing_cols <- paste0("'", missing_cols, "'", sep = "")
    test_output(
      "geog_level_present",
      "FAIL",
      paste0(
        "Given that the following geographic_level values are present: '",
        paste(geo_levels, collapse = "', '"),
        cli::pluralize(
          paste0(
            "'; the following column{?s} {?is/are} missing",
            " from the file: {missing_cols}."
          )
        )
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
