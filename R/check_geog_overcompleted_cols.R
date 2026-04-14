#' Check for geographic columns completed for unexpected rows
#'
#' Checks that geographic columns (code, name, secondary code) are only
#' populated for rows where the geographic_level is compatible with that
#' column.
#'
#' Geographic data files often contain rows at multiple levels (e.g. National,
#' Regional, and Local authority). A lower-level row is expected to carry its
#' parent geography's codes — a Local authority row should have `region_code`
#' filled in because every LA sits within a region. The reverse is not true: a
#' Regional row should not have `new_la_code` filled in, because a region is
#' not a single LA.
#'
#' The `compatible_levels` table inside this function encodes which
#' `geographic_level` values are allowed to have each geography's columns
#' populated. For most geographies this means: the level itself, plus any
#' lower-level geographies that are geographically nested within it (e.g.
#' School, Ward). RSC regions, MATs, and Sponsors are treated differently —
#' they do not map onto the standard regional hierarchy, so Regional columns
#' are not expected to be populated for those rows.
#'
#' Two exceptions apply:
#' \itemize{
#'   \item **National columns** (`country_code`, `country_name`) are expected
#'     at every level and are never checked.
#'   \item **School and Provider name columns** — if the school or provider
#'     name is the only filter in the metadata it is treated as a label column
#'     that will be populated for all rows, so it is skipped.
#' }
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_overcompleted_cols(example_data, example_meta)
#' check_geog_overcompleted_cols(example_data, example_meta, verbose = TRUE)
#' @export
check_geog_overcompleted_cols <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  low_levels <- c("School", "Provider", "Institution")

  # For each geography, list every geographic_level that may legitimately have
  # its columns populated. A level is compatible with its own rows and with
  # any lower-level geographies that sit within it (e.g. a School row is
  # expected to carry region_code because the school belongs to a region).
  # National is omitted entirely — country_code/country_name are expected at
  # all levels and are never flagged.
  # Note: RSC regions, MATs, and Sponsors are excluded from Regional's list
  # because they do not map onto the standard regional hierarchy.
  #
  # COUPLING: this list must stay in sync with geography_df. Whenever a new
  # row is added to geography_df (data-raw/geography_df.R), add the new level
  # as a key here with its compatible levels, otherwise the check silently
  # skips it. The test "compatible_levels covers all non-National geography_df
  # levels" in test-check_geog_overcompleted_cols.R will fail to alert you.
  compatible_levels <- list(
    "Regional" = c(
      "Regional",
      "Local skills improvement plan area",
      "Local authority",
      "Local enterprise partnership",
      "Opportunity area",
      "Local authority district",
      "Parliamentary constituency",
      "English devolved area",
      "Ward",
      low_levels,
      "Planning area",
      "Police force area"
    ),
    "Local authority" = c(
      "Local authority",
      "Parliamentary constituency",
      "Local authority district",
      "Ward",
      low_levels,
      "Planning area",
      "Police force area"
    ),
    "Local authority district" = c(
      "Local authority district",
      "Ward",
      low_levels,
      "Police force area"
    ),
    "Local skills improvement plan area" = c(
      "Local skills improvement plan area",
      "Local authority district",
      low_levels,
      "Planning area"
    ),
    "RSC region" = c("RSC region", low_levels),
    "Parliamentary constituency" = c("Parliamentary constituency", low_levels),
    "Local enterprise partnership" = c(
      "Local enterprise partnership",
      low_levels
    ),
    "English devolved area" = c("English devolved area", low_levels),
    "Opportunity area" = c("Opportunity area", low_levels),
    "Ward" = c("Ward", low_levels),
    "MAT" = c("MAT", low_levels),
    "Sponsor" = c("Sponsor", low_levels),
    "Planning area" = c("Planning area", low_levels),
    "Police force area" = c("Police force area", low_levels),
    "School" = "School",
    "Provider" = "Provider",
    "Institution" = "Institution"
  )

  data_cols <- dplyr::tbl_vars(data)

  levels_in_data <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  # Used later to determine whether the School/Provider name special case
  # applies: if the name column is the sole filter it will be populated for
  # every row and should not be flagged as overcompleted.
  filters <- meta$col_name[meta$col_type == "Filter"]
  filter_groups <- remove_nas_blanks(meta$filter_grouping_column)

  overcomplete <- character(0)

  for (i in seq_len(nrow(eesyscreener::geography_df))) {
    level <- eesyscreener::geography_df$geographic_level[i]

    if (level == "National" || !level %in% names(compatible_levels)) {
      next
    }

    cols <- c(
      eesyscreener::geography_df$code_field[i],
      eesyscreener::geography_df$name_field[i],
      eesyscreener::geography_df$code_field_secondary[i]
    )
    cols <- cols[!is.na(cols)]
    cols <- cols[cols %in% data_cols]

    if (length(cols) == 0) {
      next
    }

    # School/Provider special case: if name is the only filter, skip it
    if (level %in% c("School", "Provider") && length(filters) == 1) {
      name_col <- eesyscreener::geography_df$name_field[i]
      if (any(filters == name_col) || any(filter_groups == name_col)) {
        cols <- cols[cols != name_col]
        if (length(cols) == 0) next
      }
    }

    # Levels present in the data that should NOT have these columns populated.
    incompatible <- setdiff(levels_in_data, compatible_levels[[level]])

    if (length(incompatible) == 0) {
      next
    }

    incompatible_rows <- data |>
      dplyr::filter(.data$geographic_level %in% incompatible)

    # Flag any column that has at least one non-empty value in those rows.
    for (col in cols) {
      col_sym <- rlang::sym(col)

      non_empty <- incompatible_rows |>
        dplyr::filter(!is.na(!!col_sym) & !!col_sym != "") |>
        utils::head(1) |>
        dplyr::collect()

      if (nrow(non_empty) > 0) {
        overcomplete <- c(overcomplete, col)
      }
    }
  }

  overcomplete <- unique(overcomplete)

  if (length(overcomplete) == 0) {
    test_output(
      test_name,
      "PASS",
      "All geographic columns are empty where expected.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following geographic ",
        "{cli::qty(length(overcomplete))}column{?s} {?is/are} completed for ",
        "unexpected geographic_level rows: ",
        paste0("'", paste0(overcomplete, collapse = "', '"), "'"),
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
