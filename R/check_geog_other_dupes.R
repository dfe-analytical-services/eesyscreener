#' Shared implementation for other geography duplicate checks
#'
#' Checks lower-level geography data (Opportunity area, MAT, Sponsor) for
#' one-to-many relationships between geography names and codes. Depending on
#' `check`, either validates that each name maps to exactly one code
#' (`"by_name"`) or that each code maps to exactly one name (`"by_code"`).
#'
#' Returns PASS immediately when none of the lower-level geography levels are
#' present in the data. Iterates over applicable geographies from
#' `geography_df`, skipping any whose code/name columns are absent from the
#' data. Rows with NA or blank codes are excluded from both directions of
#' check.
#'
#' Derives the check name from the calling public function via
#' `get_check_name()`, so the result is correctly labelled regardless of which
#' wrapper invoked it.
#'
#' @param data data.frame of the data file being screened
#' @param check character, one of `c("by_name", "by_code")`. `"by_name"`
#'   checks whether any geography name has multiple codes;
#'   `"by_code"` checks whether any geography code has multiple names.
#' @param verbose logical, passed through to `test_output()`
#' @param stop_on_error logical, passed through to `test_output()`
#'
#' @keywords internal
#' @noRd
#'
#' @returns a single row data frame as produced by `test_output()`
.check_geog_other_dupes <- function(
  data,
  check = c("by_name", "by_code"),
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()
  check <- match.arg(check)

  lower_level_geogs <- eesyscreener::geography_df |>
    dplyr::filter(
      .data$geographic_level %in% c("Opportunity area", "MAT", "Sponsor")
    ) |>
    dplyr::select(-c("row_number", "code_field_secondary"))

  levels_present <- data |>
    dplyr::distinct(.data$geographic_level) |>
    dplyr::pull("geographic_level")

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

  multi_items <- character(0)

  for (g in relevant_geogs) {
    code_col <- g[["code_field"]]
    name_col <- g[["name_field"]]
    geog_level <- g[["geographic_level"]]

    if (!all(c(code_col, name_col) %in% dplyr::tbl_vars(data))) {
      next
    }

    name_sym <- rlang::sym("name")
    code_sym <- rlang::sym("code")

    data_tmp <- data |>
      dplyr::filter(
        .data$geographic_level == geog_level,
        !is.na(!!rlang::sym(code_col)),
        !!rlang::sym(code_col) != ""
      ) |>
      dplyr::rename(code = !!code_col, name = !!name_col)

    if (check == "by_name") {
      dupe_rows <- data_tmp |>
        dplyr::distinct(!!name_sym, !!code_sym) |>
        dplyr::count(!!name_sym) |>
        dplyr::filter(.data$n > 1) |>
        dplyr::collect()
      if (nrow(dupe_rows) > 0) {
        multi_items <- c(
          multi_items,
          paste0(dupe_rows$name, " - ", dupe_rows$n, " different codes")
        )
      }
    } else {
      dupe_rows <- data_tmp |>
        dplyr::distinct(!!code_sym, !!name_sym) |>
        dplyr::count(!!code_sym) |>
        dplyr::filter(.data$n > 1) |>
        dplyr::collect()
      if (nrow(dupe_rows) > 0) {
        multi_items <- c(
          multi_items,
          paste0(dupe_rows$code, " - ", dupe_rows$n, " different names")
        )
      }
    }
  }

  if (length(multi_items) == 0) {
    pass_msg <- if (check == "by_name") {
      "Every geography has one code."
    } else {
      "Every geography code has one assigned geography."
    }
    test_output(
      test_name,
      "PASS",
      pass_msg,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (check == "by_name") {
      fail_msg <- cli::pluralize(
        "The following ",
        "{cli::qty(length(multi_items))}{?geography/geographies}",
        " {?has/have} multiple codes: '",
        paste0(multi_items, collapse = "', '"),
        "'. Each geography should have only one code."
      )
    } else {
      fail_msg <- cli::pluralize(
        "The following geography ",
        "{cli::qty(length(multi_items))}code{?s} ",
        "{?has/have} multiple assigned geographies: '",
        paste0(multi_items, collapse = "', '"),
        "'. Each geography code should have only one assigned geography."
      )
    }
    test_output(
      test_name,
      "FAIL",
      fail_msg,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

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
  .check_geog_other_dupes(
    data,
    check = "by_name",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

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
  .check_geog_other_dupes(
    data,
    check = "by_code",
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
