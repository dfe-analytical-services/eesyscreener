#' Check geography code and name combinations
#'
#' Shared implementation for `check_geog_*_combos()`. Validates that all
#' code and name combinations in the data match the acceptable lookup
#' for that geography type.
#'
#' When `restricted_level` is supplied, rows at that geographic level are
#' checked without any exclusions (NA and blank codes are treated as invalid).
#' Rows at other levels have NA, blank, and `na_code` entries excluded before
#' checking. This two-tier approach prevents false FAIL results on rows at
#' non-home geographic levels, where a geography column being blank or NA is
#' expected (e.g. `region_code` is NA on National-level rows). The legacy
#' `region_combinations()` in dfe-published-data-qa used this same split.
#'
#' When `restricted_level` is NULL, only `na_code` rows are excluded before
#' checking, and the same filter is applied to every row regardless of
#' geographic level. This matches the legacy `country_combinations()` behaviour,
#' which simply filtered out `gssNAvcode` ("x") across all rows without any
#' geographic_level distinction. Country columns are mandatory in the data
#' standard, so blank or NA values are genuine errors at any level and should
#' not be silently excluded.
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
#' excluded. All other combinations, including any with blank or NA codes, are
#' checked against the standard geographies lookup and will fail if not found.
#'
#' No geographic_level distinction is made. This matches the legacy
#' `country_combinations()` behaviour in dfe-published-data-qa, which filtered
#' out "x" uniformly across all rows. Country columns are mandatory in the data
#' standard, so blank or NA values at any geographic level are genuine errors.
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

#' Check local authority district code and name combinations
#'
#' Checks that all lad_code and lad_name combinations in the data file are
#' valid. For Local authority district rows, all combinations must be valid.
#' For non-LAD rows, only non-empty, non-NA combinations are checked.
#' Rows where lad_code is "x" (the GSS not-available code) are excluded
#' from non-LAD checks.
#'
#' If either LAD column is absent from the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_lad_combos(example_data)
#' check_geog_lad_combos(example_data, verbose = TRUE)
#' @export
check_geog_lad_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "lad_code",
    name_col = "lad_name",
    acceptable_data = eesyscreener::acceptable_lads,
    guidance_url = render_url("data/lads.csv", domain = "screener_app_repo"),
    restricted_level = "Local authority district",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check parliamentary constituency code and name combinations
#'
#' Checks that all pcon_code and pcon_name combinations in the data file are
#' valid. For Parliamentary constituency rows, all combinations must be valid.
#' For non-PCON rows, only non-empty, non-NA combinations are checked.
#' Rows where pcon_code is "x" (the GSS not-available code) are excluded
#' from non-PCON checks.
#'
#' If either pcon column is absent from the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_pcon_combos(example_data)
#' check_geog_pcon_combos(example_data, verbose = TRUE)
#' @export
check_geog_pcon_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "pcon_code",
    name_col = "pcon_name",
    acceptable_data = eesyscreener::acceptable_pcons,
    guidance_url = render_url("data/pcons.csv", domain = "screener_app_repo"),
    restricted_level = "Parliamentary constituency",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check local enterprise partnership code and name combinations
#'
#' Checks that all local_enterprise_partnership_code and
#' local_enterprise_partnership_name combinations in the data file are valid.
#' For Local enterprise partnership rows, all combinations must be valid.
#' For non-LEP rows, only non-empty, non-NA combinations are checked.
#' Rows where local_enterprise_partnership_code is "x" (the GSS not-available
#' code) are excluded from non-LEP checks.
#'
#' If either LEP column is absent from the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_lep_combos(example_data)
#' check_geog_lep_combos(example_data, verbose = TRUE)
#' @export
check_geog_lep_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "local_enterprise_partnership_code",
    name_col = "local_enterprise_partnership_name",
    acceptable_data = eesyscreener::acceptable_leps,
    guidance_url = render_url("data/leps.csv", domain = "screener_app_repo"),
    restricted_level = "Local enterprise partnership",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check ward code and name combinations
#'
#' Checks that all ward_code and ward_name combinations in the data file are
#' valid. For Ward rows, all combinations must be valid. For non-Ward rows,
#' only non-empty, non-NA combinations are checked. Rows where ward_code is
#' "x" (the GSS not-available code) are excluded from non-Ward checks.
#'
#' If either ward column is absent from the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_ward_combos(example_data)
#' check_geog_ward_combos(example_data, verbose = TRUE)
#' @export
check_geog_ward_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "ward_code",
    name_col = "ward_name",
    acceptable_data = eesyscreener::acceptable_wards,
    guidance_url = render_url(
      "data/ward_lad_la_pcon_hierarchy.csv",
      domain = "screener_app_repo"
    ),
    restricted_level = "Ward",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check local skills improvement plan area code and name combinations
#'
#' Checks that all lsip_code and lsip_name combinations in the data file are
#' valid. For Local skills improvement plan area rows, all combinations must be
#' valid. For non-LSIP rows, only non-empty, non-NA combinations are checked.
#' Rows where lsip_code is "x" (the GSS not-available code) are excluded from
#' non-LSIP checks.
#'
#' If either lsip column is absent from the data, the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_lsip_combos(example_data)
#' check_geog_lsip_combos(example_data, verbose = TRUE)
#' @export
check_geog_lsip_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "lsip_code",
    name_col = "lsip_name",
    acceptable_data = eesyscreener::acceptable_lsips,
    guidance_url = render_url("data/lsips.csv", domain = "screener_app_repo"),
    restricted_level = "Local skills improvement plan area",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check English devolved area code and name combinations
#'
#' Checks that all english_devolved_area_code and english_devolved_area_name
#' combinations in the data file are valid. For English devolved area rows,
#' all combinations must be valid. For non-EDA rows, only non-empty, non-NA
#' combinations are checked. Rows where english_devolved_area_code is "x"
#' (the GSS not-available code) are excluded from non-EDA checks.
#'
#' If either english devolved area column is absent from the data, the check
#' passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_eda_combos(example_data)
#' check_geog_eda_combos(example_data, verbose = TRUE)
#' @export
check_geog_eda_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  .check_geog_combos(
    data,
    code_col = "english_devolved_area_code",
    name_col = "english_devolved_area_name",
    acceptable_data = eesyscreener::acceptable_edas,
    guidance_url = render_url(
      "data/english_devolved_areas.csv",
      domain = "screener_app_repo"
    ),
    restricted_level = "English devolved area",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

#' Check local authority code and name combinations
#'
#' Checks that all old_la_code, new_la_code, and la_name combinations in the
#' data file are valid against the standard geographies lookup.
#'
#' No geographic_level distinction is made (unlike most other geography checks).
#' All rows are filtered the same way before checking: rows where old_la_code
#' is NA are excluded, and rows where new_la_code is "x" (the GSS
#' not-available code) are excluded. All remaining combinations — including
#' those with blank or NA new_la_code — are checked and will fail if not found
#' in the lookup.
#'
#' Rows where old_la_code is "z" combined with a valid
#' `acceptable_extra_geog_options` entry are also accepted, to accommodate
#' geographies that have no old LA code.
#'
#' The `restricted_level` parameter is not used here because the
#' old_la_code NA filter only applies when restricted_level is NULL. If
#' "Local authority" were set as the restricted level, LA-level rows with a
#' NA old_la_code would be checked without that filter and incorrectly fail,
#' since not all LAs have an old code.
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
  # restricted_level is intentionally not set. The old_la_code NA filter
  # (extra_code_col) only runs in the else branch (restricted_level = NULL).
  # If restricted_level = "Local authority" were used, LA-level rows would
  # bypass that filter and rows with NA old_la_code would fail the anti_join
  # against valid_combos, producing incorrect FAILs for LAs that have no old
  # code.
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
