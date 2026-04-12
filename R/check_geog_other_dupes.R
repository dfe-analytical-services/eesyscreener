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

  lower_level_geogs <- eesyscreener::geography_df |>
    dplyr::filter(
      geographic_level %in% c("Opportunity area", "MAT", "Sponsor")
    ) |>
    dplyr::select(-c("row_number", "code_field_secondary"))

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  # Convert lower_level_geogs to a list of row-lists
  lower_level_geogs_list <- split(
    lower_level_geogs,
    seq_len(nrow(lower_level_geogs))
  )
  relevant_geogs <- Filter(
    function(g) g[["geographic_level"]] %in% levels_present,
    lower_level_geogs_list
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
    code_col <- g[["code_field"]]
    name_col <- g[["name_field"]]
    geog_level <- g[["geographic_level"]]
    col_names <- c(code_col, name_col)

    if (!all(col_names %in% dplyr::tbl_vars(data))) {
      next
    }

    # Rename columns to standard names for this iteration
    data_tmp <- data |>
      dplyr::filter(.data$geographic_level == geog_level) |>
      dplyr::rename(code = !!code_col, name = !!name_col)

    dupe_rows <- data_tmp |>
      dplyr::distinct(name, code) |>
      dplyr::count(name, name = "n_codes") |>
      dplyr::filter(n_codes > 1) |>
      dplyr::collect()

    if (nrow(dupe_rows) > 0) {
      multi_code_names <- c(
        multi_code_names,
        paste0(
          dupe_rows$name,
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
