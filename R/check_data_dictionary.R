# Data source and distinction from check_harmonised.R ====
#
# This file uses eesyscreener::data_dictionary, the EES API data dictionary.
# It defines the column names and filter item values that are acceptable in
# EES API data sets.
#
# This is intentionally separate from the checks in check_harmonised.R:
#
# - check_harmonised_* functions enforce DfE harmonised variable naming
#   conventions (via harmonised_col_names) and GSS value standards (via
#   acceptable_ethnicity_values). They apply to any EES publication.
#
# - check_data_dict_* functions enforce EES API compatibility (via
#   data_dictionary). They flag issues only relevant to data sets intended
#   for the EES API, and the reference data is maintained independently of
#   the GSS standards.
#
# The datasets overlap in domain (e.g. ethnicity_major appears in both
# data_dictionary and harmonised_col_names), but answer different questions:
#   - data_dictionary asks whether a column/value is valid for the EES API
#   - harmonised_col_names asks whether a column uses the DfE standard name
#   - acceptable_ethnicity_values asks whether a value meets GSS ethnicity
#     standards
#
# Concretely: data_dictionary contains additional EES-specific aggregate values
# (e.g. "All pupils", "All Asian / Asian British") not in GSS standards, and
# uses only the space-slash format ("Asian / Asian British") rather than both
# slash formats. A column could pass all harmonised checks but fail data
# dictionary checks, or vice versa.

# Internal helpers ====

#' Get valid column names from the data dictionary
#'
#' @keywords internal
#' @noRd
dd_col_names_from_dd <- function() {
  eesyscreener::data_dictionary |>
    dplyr::select("col_name", "col_name_parent", "col_type") |>
    tidyr::pivot_longer(
      c("col_name", "col_name_parent"),
      values_to = "col_name"
    ) |>
    dplyr::select(-"name") |>
    dplyr::filter(!is.na(.data$col_name)) |>
    dplyr::distinct() |>
    dplyr::mutate(standard_col = TRUE)
}

#' Get valid filter items from the data dictionary
#'
#' Returns a data frame of valid col_name / filter_item combinations, including
#' both child and parent hierarchy entries.
#'
#' @keywords internal
#' @noRd
dd_filter_items_from_dd <- function() {
  eesyscreener::data_dictionary |>
    dplyr::select(
      "col_type",
      colname_child = "col_name",
      filteritem_child = "filter_item",
      colname_parent = "col_name_parent",
      filteritem_parent = "filter_item_parent"
    ) |>
    tidyr::pivot_longer(
      -"col_type",
      names_to = c(".value", "hierarchy"),
      names_pattern = "(.*)_(.*)"
    ) |>
    dplyr::select(
      "col_type",
      col_name = "colname",
      filter_item = "filteritem"
    ) |>
    dplyr::filter(
      !is.na(.data$col_name),
      !is.na(.data$filter_item)
    ) |>
    dplyr::distinct() |>
    dplyr::mutate(standard_col = TRUE)
}

#' Match metadata columns against the data dictionary
#'
#' Returns all col_name and filter_grouping_column entries from metadata joined
#' against the data dictionary. The `standard_col` column is TRUE where the
#' column name is found in the dictionary, and NA where it is not.
#'
#' @param meta data.frame of the metadata
#' @keywords internal
#' @noRd
dd_match_meta_cols <- function(meta) {
  valid_cols <- dd_col_names_from_dd()
  meta |>
    dplyr::select("col_type", "col_name", "filter_grouping_column") |>
    tidyr::pivot_longer(
      c("col_name", "filter_grouping_column"),
      values_to = "col_name"
    ) |>
    dplyr::select(-"name") |>
    dplyr::filter(!is.na(.data$col_name), .data$col_name != "") |>
    dplyr::left_join(
      valid_cols,
      by = dplyr::join_by("col_type", "col_name")
    ) |>
    dplyr::distinct()
}

# check_data_dict_col_name ====

#' Check col_names against the data dictionary
#'
#' Validates that the filter and indicator column names in the metadata are
#' present in the data dictionary. Columns not in the data dictionary should
#' not be used in API data sets.
#'
#' @inheritParams precheck_meta_col_type
#' @inherit check_filename_spaces return
#' @family check_data_dict
#' @examples
#' check_data_dict_col_name(example_meta)
#' check_data_dict_col_name(example_meta, verbose = TRUE)
#' @export
check_data_dict_col_name <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  non_standard <- dd_match_meta_cols(meta) |>
    dplyr::filter(is.na(.data$standard_col))

  if (nrow(non_standard) == 0) {
    test_output(
      test_name,
      "PASS",
      "All col_names are consistent with the data dictionary.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    non_standard_indicators <- non_standard |>
      dplyr::filter(.data$col_type == "Indicator") |>
      dplyr::pull("col_name")
    non_standard_filters <- non_standard |>
      dplyr::filter(.data$col_type == "Filter") |>
      dplyr::pull("col_name")

    msg_parts <- character(0)
    if (length(non_standard_indicators) > 0) {
      msg_parts <- c(
        msg_parts,
        paste0(
          "Indicators: '",
          paste(non_standard_indicators, collapse = "', '"),
          "'."
        )
      )
    }
    if (length(non_standard_filters) > 0) {
      msg_parts <- c(
        msg_parts,
        paste0(
          "Filters: '",
          paste(non_standard_filters, collapse = "', '"),
          "'."
        )
      )
    }

    test_output(
      test_name,
      "WARNING",
      cli::pluralize(
        "The following {cli::qty(nrow(non_standard))}column{?s} {?is/are} not",
        " present in the data dictionary and should not be used as part of an",
        " API data set until resolved. ",
        paste(msg_parts, collapse = " ")
      ),
      guidance_url = render_url(
        "statistics-production/api-data-standards.html"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

# check_data_dict_fil_item ====

#' Check filter items against the data dictionary
#'
#' Validates that the filter item values in the data are present in the data
#' dictionary for columns that are listed in the data dictionary. Filter items
#' not in the data dictionary should not be used in API data sets.
#'
#' Only filter columns from the metadata that are also present in the data
#' dictionary are checked.
#'
#' @inheritParams precheck_col_to_rows
#' @inherit check_filename_spaces return
#' @family check_data_dict
#' @examples
#' check_data_dict_fil_item(example_data, example_meta)
#' check_data_dict_fil_item(example_data, example_meta, verbose = TRUE)
#' @export
check_data_dict_fil_item <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  dd_filter_cols <- dd_match_meta_cols(meta) |>
    dplyr::filter(!is.na(.data$standard_col), .data$col_type == "Filter") |>
    dplyr::pull("col_name")

  if (length(dd_filter_cols) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "No data dictionary filter columns found in the metadata.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  valid_items <- dd_filter_items_from_dd()

  non_standard_list <- lapply(dd_filter_cols, function(col) {
    valid_for_col <- valid_items |>
      dplyr::filter(.data$col_name == col) |>
      dplyr::pull("filter_item")

    col_vals <- data |>
      dplyr::select(dplyr::all_of(col)) |>
      dplyr::distinct() |>
      dplyr::pull(1)

    bad_vals <- setdiff(as.character(col_vals), valid_for_col)

    if (length(bad_vals) > 0) {
      data.frame(
        col_name = col,
        filter_item = bad_vals,
        stringsAsFactors = FALSE
      )
    } else {
      NULL
    }
  })

  non_standard_items <- dplyr::bind_rows(non_standard_list)

  if (nrow(non_standard_items) == 0) {
    test_output(
      test_name,
      "PASS",
      "All filter items are consistent with the data dictionary.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "WARNING",
      cli::pluralize(
        "The following col_name / filter_item",
        " {cli::qty(nrow(non_standard_items))}combination{?s} {?is/are} not",
        " present in the data dictionary and should not be used as part of an",
        " API data set until resolved: ",
        paste(
          sort(paste0(
            "'",
            non_standard_items$col_name,
            " / ",
            non_standard_items$filter_item,
            "'"
          )),
          collapse = ", "
        ),
        "."
      ),
      guidance_url = render_url(
        "statistics-production/api-data-standards.html"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
