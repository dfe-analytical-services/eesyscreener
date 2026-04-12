#' Check other geography code duplicates
#'
#' Checks that each geography code in lower-level geographic data
#' (Opportunity area, MAT, and Sponsor) has only one assigned geography name.
#' A code appearing with two or more distinct names is flagged as a failure.
#'
#' If no lower-level geography data is present in the data file, the check
#' passes immediately.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_other_code_dupes(example_data)
#' check_geog_other_code_dupes(example_data, verbose = TRUE)
#' @export
check_geog_other_code_dupes <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  lower_level_geog_levels <- c("Opportunity area", "MAT", "Sponsor")

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

  if (!any(lower_level_geog_levels %in% levels_present)) {
    return(test_output(
      test_name,
      "PASS",
      "No lower-level geography data is present in this data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  applicable_geog <- eesyscreener::geography_df[
    eesyscreener::geography_df$geographic_level %in%
      lower_level_geog_levels &
      !is.na(eesyscreener::geography_df$code_field) &
      !is.na(eesyscreener::geography_df$name_field),
  ]

  data_cols <- dplyr::tbl_vars(data)

  multi_codes <- lapply(seq_len(nrow(applicable_geog)), function(i) {
    code_col <- applicable_geog$code_field[i]
    name_col <- applicable_geog$name_field[i]

    if (!all(c(code_col, name_col) %in% data_cols)) {
      return(NULL)
    }

    code_sym <- rlang::sym(code_col)
    name_sym <- rlang::sym(name_col)

    data |>
      dplyr::filter(!is.na(!!code_sym) & !!code_sym != "") |>
      dplyr::distinct(!!code_sym, !!name_sym) |>
      dplyr::count(!!code_sym, name = "name_n") |>
      dplyr::filter(.data$name_n > 1) |>
      dplyr::collect() |>
      dplyr::mutate(
        combo = paste0(!!code_sym, " - ", .data$name_n, " different names")
      ) |>
      dplyr::pull("combo")
  }) |>
    Filter(Negate(is.null), x = _) |>
    unlist()

  if (length(multi_codes) == 0) {
    test_output(
      test_name,
      "PASS",
      "Every geography code has one assigned geography.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following geography ",
        "{cli::qty(length(multi_codes))}code{?s} ",
        "{?has/have} multiple assigned geographies: '",
        paste0(multi_codes, collapse = "', '"),
        "'. Each geography code should have only one assigned geography."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
