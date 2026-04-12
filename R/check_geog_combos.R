#' Check geography code and name combinations
#'
#' Shared implementation for `check_geog_*_combos()`. Validates that all
#' code and name combinations in the data match the acceptable lookup
#' for that geography type.
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
#' @param acceptable_data data.frame with columns matching `code_col`,
#'   `name_col`, and (when supplied) `extra_code_col`, containing the valid
#'   combinations for this geography type
#' @param guidance_url string URL for the guidance link in FAIL messages
#' @param na_code string, the GSS not-available code to exclude from
#'   non-restricted rows (default `"x"`)
#' @param restricted_level string or NULL. If supplied, rows at this
#'   geographic level must have valid combos with no exclusions. Default NULL.
#' @param extra_code_col string or NULL. An additional code column to include
#'   in the combination check (e.g. `"old_la_code"` for the LA check). When
#'   supplied, rows where this column is NA are excluded. Rows where
#'   `extra_code_col` is `"z"` combined with valid
#'   `acceptable_extra_geog_options`
#'   entries are also accepted. Default NULL.
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
  extra_code_col = NULL,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  all_cols <- c(extra_code_col, code_col, name_col)

  if (!all(all_cols %in% dplyr::tbl_vars(data))) {
    return(test_output(
      test_name,
      "PASS",
      paste0(
        "At least one of the ",
        paste(all_cols, collapse = " / "),
        " columns is not present in this data file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  extra_geog <- eesyscreener::acceptable_extra_geog_options |>
    setNames(c(code_col, name_col))

  if (!is.null(extra_code_col)) {
    extra_geog <- extra_geog |>
      dplyr::mutate(!!rlang::sym(extra_code_col) := "z")
  }

  valid_combos <- dplyr::bind_rows(acceptable_data, extra_geog)

  code_sym <- rlang::sym(code_col)
  distinct_syms <- lapply(all_cols, rlang::sym)

  if (!is.null(restricted_level)) {
    # For restricted level rows: check all combos (NA and blank are invalid)
    restricted_invalid <- data |>
      dplyr::filter(.data$geographic_level == restricted_level) |>
      dplyr::distinct(!!!distinct_syms) |>
      dplyr::anti_join(valid_combos, by = all_cols) |>
      dplyr::collect()

    # For other rows: only check non-NA, non-empty, non-na_code combos
    other_invalid <- data |>
      dplyr::filter(.data$geographic_level != restricted_level) |>
      dplyr::filter(
        !is.na(!!code_sym) &
          !!code_sym != "" &
          !!code_sym != na_code
      ) |>
      dplyr::distinct(!!!distinct_syms) |>
      dplyr::anti_join(valid_combos, by = all_cols) |>
      dplyr::collect()

    invalid <- dplyr::bind_rows(restricted_invalid, other_invalid) |>
      dplyr::distinct(!!!distinct_syms)
  } else {
    # No restricted level: exclude na_code (and extra_code_col NAs) from all
    filtered_data <- data |>
      dplyr::filter(!!code_sym != na_code)

    if (!is.null(extra_code_col)) {
      filtered_data <- filtered_data |>
        dplyr::filter(!is.na(!!rlang::sym(extra_code_col)))
    }

    invalid <- filtered_data |>
      dplyr::distinct(!!!distinct_syms) |>
      dplyr::anti_join(valid_combos, by = all_cols) |>
      dplyr::collect()
  }

  invalid_combos <- do.call(paste, invalid[all_cols])

  cols_label <- paste(all_cols, collapse = " / ")

  if (length(invalid_combos) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0("All ", cols_label, " combinations are valid."),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following ",
        cols_label,
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

#' Check local authority code and name combinations
#'
#' Checks that all old_la_code, new_la_code, and la_name combinations in the
#' data file are valid. Rows where any of the three columns is NA are excluded.
#' Rows where new_la_code is blank or "x" (the GSS not-available code) are
#' also excluded.
#'
#' If any of the three LA columns is absent from the data, the check passes
#' immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_la_combos(example_data)
#' check_geog_la_combos(example_data, verbose = TRUE)
#' @export
check_geog_la_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "new_la_code",
    name_col = "la_name",
    acceptable_data = eesyscreener::acceptable_las,
    guidance_url = render_url("data/las.csv", domain = "screener_app_repo"),
    extra_code_col = "old_la_code",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
