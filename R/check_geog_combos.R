#' Check geography code and name combinations
#'
#' Shared implementation for `check_geog_country_combos()` and
#' `check_geog_region_combos()`. Validates that all code and name combinations
#' in the data match the acceptable lookup for that geography type.
#'
#' When `restricted_level` is supplied, rows at that geographic level are
#' checked without any exclusions (NA and blank codes are treated as invalid).
#' Rows at other levels have NA, blank, and `na_code` entries excluded before
#' checking. When `restricted_level` is NULL, `na_code` rows are excluded from
#' all rows before checking.
#'
#' Derives the check name from the calling public function via
#' `get_check_name()`, so the result is correctly labelled regardless of which
#' wrapper invoked it.
#'
#' @param data data.frame of the data file being screened
#' @param code_col string, the name of the code column (e.g. `"region_code"`)
#' @param name_col string, the name of the name column (e.g. `"region_name"`)
#' @param acceptable_data data.frame with columns `code_col` and `name_col`
#'   containing the valid combinations for this geography type
#' @param guidance_url string URL for the guidance link in FAIL messages
#' @param na_code string, the GSS not-available code to exclude from
#'   non-restricted rows (default `"x"`)
#' @param restricted_level string or NULL. If supplied, rows at this
#'   geographic level must have valid combos with no exclusions. Default NULL.
#' @param verbose logical, passed through to `test_output()`
#' @param stop_on_error logical, passed through to `test_output()`
#'
#' @keywords internal
#' @noRd
#'
#' @returns a single row data frame as produced by `test_output()`
.check_geog_combos <- function(
  data,
  code_col,
  name_col,
  acceptable_data,
  guidance_url,
  na_code = "x",
  restricted_level = NULL,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  if (!all(c(code_col, name_col) %in% dplyr::tbl_vars(data))) {
    return(test_output(
      test_name,
      "PASS",
      paste0(
        "At least one of the ",
        code_col,
        " / ",
        name_col,
        " columns is not present in this data file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  valid_combos <- rbind(
    acceptable_data,
    eesyscreener::acceptable_extra_geog_options |>
      setNames(c(code_col, name_col))
  )

  if (!is.null(restricted_level)) {
    # For restricted level rows: check all combos (NA and blank are invalid)
    restricted_invalid <- data |>
      dplyr::filter(.data$geographic_level == restricted_level) |>
      dplyr::distinct(.data[[code_col]], .data[[name_col]]) |>
      dplyr::anti_join(valid_combos, by = c(code_col, name_col)) |>
      dplyr::collect()

    # For other rows: only check non-NA, non-empty, non-na_code combos
    other_invalid <- data |>
      dplyr::filter(.data$geographic_level != restricted_level) |>
      dplyr::filter(
        !is.na(.data[[code_col]]) &
          .data[[code_col]] != "" &
          .data[[code_col]] != na_code
      ) |>
      dplyr::distinct(.data[[code_col]], .data[[name_col]]) |>
      dplyr::anti_join(valid_combos, by = c(code_col, name_col)) |>
      dplyr::collect()

    invalid <- dplyr::bind_rows(restricted_invalid, other_invalid) |>
      dplyr::distinct(.data[[code_col]], .data[[name_col]])
  } else {
    # No restricted level: exclude na_code from all rows
    invalid <- data |>
      dplyr::filter(.data[[code_col]] != na_code) |>
      dplyr::distinct(.data[[code_col]], .data[[name_col]]) |>
      dplyr::anti_join(valid_combos, by = c(code_col, name_col)) |>
      dplyr::collect()
  }

  invalid_combos <- paste(invalid[[code_col]], invalid[[name_col]])

  if (length(invalid_combos) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0("All ", code_col, " and ", name_col, " combinations are valid."),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following ",
        code_col,
        " / ",
        name_col,
        " ",
        "{cli::qty(length(invalid_combos))}combination{?s}",
        " {?is/are} invalid: '",
        paste0(invalid_combos, collapse = "', '"),
        "'. We do not expect any combinations outside of the standard ",
        "geographies lookup (case sensitive), please check your name and ",
        "code combinations against this lookup."
      ),
      guidance_url = guidance_url,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

#' Check country code and name combinations
#'
#' Checks that all country_code and country_name combinations in the data file
#' are valid. Rows where country_code is "x" (the GSS not-available code) are
#' excluded from the check.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_country_combos(example_data)
#' check_geog_country_combos(example_data, verbose = TRUE)
#' @export
check_geog_country_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "country_code",
    name_col = "country_name",
    acceptable_data = eesyscreener::acceptable_countries,
    guidance_url = render_url("data/country.csv", domain = "screener_app_repo"),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check region code and name combinations
#'
#' Checks that all region_code and region_name combinations in the data file
#' are valid. For Regional rows, all combinations must be valid. For
#' non-Regional rows, only non-empty, non-NA combinations are checked.
#' Rows where region_code is "x" (the GSS not-available code) are excluded
#' from non-Regional checks.
#'
#' If either region column is absent from the data, the check passes
#' immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_region_combos(example_data)
#' check_geog_region_combos(example_data, verbose = TRUE)
#' @export
check_geog_region_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "region_code",
    name_col = "region_name",
    acceptable_data = eesyscreener::acceptable_regions,
    guidance_url = render_url(
      "data/regions.csv",
      domain = "screener_app_repo"
    ),
    restricted_level = "Regional",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
