#' Check for geographic columns completed for unexpected rows
#'
#' Checks that geographic columns (code, name, secondary code) are only
#' populated for rows where the geographic_level is compatible with that
#' column. For example, `region_code` should not contain values for
#' `"National"` rows.
#'
#' National columns (country_code, country_name) are never checked as they
#' are expected at all levels. For School and Provider levels, if the name
#' column is the only filter in the metadata, the name column is skipped as
#' it is expected to be populated for all rows.
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

  # Define which geographic levels may legitimately have each level's columns

  # populated. National columns are always allowed so National is excluded
  # from checking entirely.
  compatible_levels <- list(
    "Regional" = setdiff(
      eesyscreener::geography_df$geographic_level,
      "National"
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

  # For School/Provider: if the name is the only filter, skip checking it
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

    incompatible <- setdiff(levels_in_data, compatible_levels[[level]])

    if (length(incompatible) == 0) {
      next
    }

    incompatible_rows <- data |>
      dplyr::filter(.data$geographic_level %in% incompatible)

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
