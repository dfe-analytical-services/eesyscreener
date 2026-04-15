# Data sources and their distinct roles ====
#
# This file uses two separate reference datasets. Understanding the distinction
# is important because their values partially overlap but serve different
# standards and must not be conflated:
#
# - harmonised_col_names: DfE harmonised variable naming standards. Maps search
#   patterns to the accepted column names for variables covered by DfE's
#   harmonised data standards (e.g. "ethnic" -> ethnicity_major, ethnicity_minor,
#   ethnicity_detailed, minority_ethnic). Used to enforce correct column naming
#   in check_harmonised_variables(), and to derive the expected
#   characteristic_group display labels in eth_standard_characteristic_groups().
#
# - acceptable_ethnicity_values: GSS-standard ethnicity value pairs. Contains
#   the accepted (major, minor) combinations as defined by the Government
#   Statistical Service. Deliberately includes both slash formats
#   (e.g. "Asian/Asian British" and "Asian / Asian British") to accommodate
#   old and new conventions. Used in check_harmonised_eth_vals() and
#   check_harmonised_eth_char_vals().
#
# The EES API data dictionary (eesyscreener::data_dictionary), used in
# check_data_dictionary.R, is a separate list maintained for API compatibility.
# It overlaps with the above for ethnicity column names and some values, but
# differs in content (e.g. it includes additional aggregate values like
# "All pupils" and uses only the space-slash format). See check_data_dictionary.R
# for a full explanation of the distinction.

# Internal helpers ====

#' Derive standard ethnicity characteristic_group labels from harmonised data
#'
#' Converts the accepted harmonised ethnicity column names from
#' \code{harmonised_col_names} into the corresponding display labels expected
#' in the \code{characteristic_group} column (snake_case to Title Case, e.g.
#' \code{ethnicity_major} -> \code{"Ethnicity Major"}).
#'
#' Deriving these from the dataset (rather than hardcoding a parallel list)
#' ensures \code{check_harmonised_eth_char_grp} stays in sync with the
#' harmonised column name standards automatically.
#'
#' @return Character vector of standard \code{characteristic_group} display
#'   labels for ethnicity data (e.g. \code{"Ethnicity Major"},
#'   \code{"Minority Ethnic"}).
#' @seealso \code{\link[eesyscreener]{harmonised_col_names}}
#' @keywords internal
#' @noRd
eth_standard_characteristic_groups <- function() {
  col_names <- unique(
    eesyscreener::harmonised_col_names$col_name_harmonised[
      grepl("ethnic", eesyscreener::harmonised_col_names$col_name_search_string)
    ]
  )
  tools::toTitleCase(gsub("_", " ", col_names))
}

#' Build the standard ethnicity non-conformance warning output
#'
#' Shared output builder for \code{check_harmonised_eth_vals} and
#' \code{check_harmonised_eth_char_vals}. Both checks validate ethnicity values
#' against GSS standards and produce identical WARNING structure when
#' non-conforming values are found.
#'
#' Only the WARNING path is extracted here. The two parent functions have
#' distinct column guards, distinct inputs, and distinct PASS messages, so only
#' this shared failure output is consolidated:
#' \itemize{
#'   \item \code{check_harmonised_eth_vals} checks dedicated
#'         \code{ethnicity_major} / \code{ethnicity_minor} columns directly,
#'         and may report major/minor combinations.
#'   \item \code{check_harmonised_eth_char_vals} checks the
#'         \code{characteristic} column, but only for rows where
#'         \code{characteristic_group} relates to ethnicity.
#' }
#'
#' @param test_name String. The check name from \code{get_check_name()}.
#' @param nonstandard Character vector of non-conforming values or combinations.
#' @param value_type String. Either \code{"value"} (default, used when checking
#'   a single column) or \code{"combination"} (used when checking major/minor
#'   pairs together). Controls the pluralised warning message.
#' @param verbose Passed through to \code{test_output()}.
#' @param stop_on_error Passed through to \code{test_output()}.
#' @keywords internal
#' @noRd
eth_nonconformance_warning <- function(
  test_name,
  nonstandard,
  value_type = "value",
  verbose,
  stop_on_error
) {
  test_output(
    test_name,
    "WARNING",
    cli::pluralize(
      "The following {cli::qty(length(nonstandard))}ethnicity filter",
      " {value_type}{?s} '",
      paste(nonstandard, collapse = "', '"),
      "' do{?es/} not conform to the GSS standards.",
      " Please cross check against the published standards."
    ),
    guidance_url = render_url("statistics-production/ud.html#ethnicity"),
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}

# check_harmonised_variables ====

#' Check col names against harmonised data standards
#'
#' Validates that the column names and filter grouping column names in the
#' metadata are not using non-standard names for variables covered by the DfE
#' harmonised data standards. Any column name that matches a harmonised variable
#' search pattern but is not one of the accepted standard names will fail.
#'
#' @inheritParams precheck_meta_col_type
#' @inherit check_filename_spaces return
#' @family check_harmonised
#' @examples
#' check_harmonised_variables(example_meta)
#' check_harmonised_variables(example_meta, verbose = TRUE)
#' @export
check_harmonised_variables <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  search_string <- paste(
    unique(eesyscreener::harmonised_col_names$col_name_search_string),
    collapse = "|"
  )
  standard_col_names <- unique(
    eesyscreener::harmonised_col_names$col_name_harmonised
  )

  all_col_names <- get_cols_meta(meta, grouping_cols = TRUE)

  bad_col_names <- all_col_names[
    grepl(search_string, tolower(all_col_names)) &
      !(all_col_names %in% standard_col_names)
  ]

  if (length(bad_col_names) == 0) {
    test_output(
      test_name,
      "PASS",
      "No standardised column name issues found.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(bad_col_names))}column{?s} '",
        paste(bad_col_names, collapse = "', '"),
        "' appear{?s/} to relate to contexts that fall under the harmonised",
        " data standards. Please verify your column headers against the",
        " data standards."
      ),
      guidance_url = render_url(
        "statistics-production/ud.html#common-harmonised-variables"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

# check_harmonised_eth_vals ====

#' Check ethnicity column values against GSS standards
#'
#' Validates that the values in `ethnicity_major` and/or `ethnicity_minor`
#' columns in the data file conform to the GSS ethnicity standards. When both
#' columns are present, major and minor value pairs are checked together.
#' When only one column is present, its values are checked independently.
#'
#' If neither column is present the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#' @inherit check_filename_spaces return
#' @family check_harmonised
#' @examples
#' check_harmonised_eth_vals(example_data)
#' check_harmonised_eth_vals(example_data, verbose = TRUE)
#' @export
check_harmonised_eth_vals <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  data_cols <- dplyr::tbl_vars(data)
  has_major <- "ethnicity_major" %in% data_cols
  has_minor <- "ethnicity_minor" %in% data_cols

  if (!has_major && !has_minor) {
    return(test_output(
      test_name,
      "PASS",
      "No ethnicity columns found.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  if (has_major && has_minor) {
    nonstandard <- data |>
      dplyr::distinct(.data$ethnicity_major, .data$ethnicity_minor) |>
      dplyr::anti_join(
        eesyscreener::acceptable_ethnicity_values,
        by = c("ethnicity_major", "ethnicity_minor")
      ) |>
      dplyr::collect() |>
      dplyr::mutate(
        combined = paste(
          .data$ethnicity_major,
          .data$ethnicity_minor,
          sep = ", "
        )
      ) |>
      dplyr::pull("combined")
    value_type <- "combination"
  } else if (has_major) {
    acceptable_major <- dplyr::distinct(
      eesyscreener::acceptable_ethnicity_values,
      .data$ethnicity_major
    )
    nonstandard <- data |>
      dplyr::distinct(.data$ethnicity_major) |>
      dplyr::anti_join(acceptable_major, by = "ethnicity_major") |>
      dplyr::collect() |>
      dplyr::pull("ethnicity_major")
    value_type <- "value"
  } else {
    acceptable_minor <- dplyr::distinct(
      eesyscreener::acceptable_ethnicity_values,
      .data$ethnicity_minor
    )
    nonstandard <- data |>
      dplyr::distinct(.data$ethnicity_minor) |>
      dplyr::anti_join(acceptable_minor, by = "ethnicity_minor") |>
      dplyr::collect() |>
      dplyr::pull("ethnicity_minor")
    value_type <- "value"
  }

  if (length(nonstandard) == 0) {
    test_output(
      test_name,
      "PASS",
      "All ethnicity values are consistent with the GSS standards.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    eth_nonconformance_warning(
      test_name,
      nonstandard,
      value_type = value_type,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

# check_harmonised_eth_char_grp ====

#' Check ethnicity characteristic_group values against standards
#'
#' Validates that any values in the `characteristic_group` column that relate
#' to ethnicity data conform to the expected standard conventions. Values
#' matching the ethnicity pattern ("ethnic", case-insensitive) that do not
#' contain one of the accepted standard phrases are flagged.
#'
#' Standard phrases are: "Ethnicity Major", "Ethnicity Minor",
#' "Ethnicity Detailed", and "Minority Ethnic". Combined values are also
#' accepted if they contain one of these (e.g. "Gender and Minority Ethnic").
#'
#' If the `characteristic_group` column is absent the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#' @inherit check_filename_spaces return
#' @family check_harmonised
#' @examples
#' check_harmonised_eth_char_grp(example_data)
#' check_harmonised_eth_char_grp(example_data, verbose = TRUE)
#' @export
check_harmonised_eth_char_grp <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  # Derived from harmonised_col_names rather than hardcoded, so this list
  # stays in sync with the accepted harmonised column name standards
  # automatically. The snake_case column names (e.g. ethnicity_major) are
  # converted to the Title Case display labels expected in characteristic_group
  # (e.g. "Ethnicity Major"). See eth_standard_characteristic_groups().
  standard_characteristics <- eth_standard_characteristic_groups()

  if (!"characteristic_group" %in% dplyr::tbl_vars(data)) {
    return(test_output(
      test_name,
      "PASS",
      "No characteristic_group column found.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  bad_groups <- data |>
    dplyr::distinct(.data$characteristic_group) |>
    dplyr::filter(
      grepl("ethnic", .data$characteristic_group, ignore.case = TRUE)
    ) |>
    dplyr::collect() |>
    dplyr::filter(
      !grepl(
        paste(standard_characteristics, collapse = "|"),
        .data$characteristic_group
      )
    ) |>
    dplyr::pull("characteristic_group")

  if (length(bad_groups) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0(
        "All ethnicity characteristic_group values are consistent",
        " with the expected standards."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(bad_groups))}characteristic_group",
        " value{?s} '",
        paste(bad_groups, collapse = "', '"),
        "' appear{?s/} to relate to ethnicity data, but do{?es/} not conform",
        " to the standard conventions.",
        " Expected values: ",
        paste(standard_characteristics, collapse = ", "),
        " (or these combined with other filters with 'and' -",
        " e.g. 'Gender and Minority Ethnic')."
      ),
      guidance_url = render_url(
        "statistics-production/ud.html#ethnicity"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}

# check_harmonised_eth_char_vals ====

#' Check ethnicity characteristic values against GSS standards
#'
#' Validates that `characteristic` values for rows where `characteristic_group`
#' relates to ethnicity conform to the GSS ethnicity standards. Values are
#' checked against the union of all accepted ethnicity major and minor values.
#'
#' If either the `characteristic_group` or `characteristic` column is absent
#' the check passes immediately.
#'
#' @inheritParams check_col_names_spaces
#' @inherit check_filename_spaces return
#' @family check_harmonised
#' @examples
#' check_harmonised_eth_char_vals(example_data)
#' check_harmonised_eth_char_vals(example_data, verbose = TRUE)
#' @export
check_harmonised_eth_char_vals <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  data_cols <- dplyr::tbl_vars(data)
  if (
    !"characteristic_group" %in% data_cols ||
      !"characteristic" %in% data_cols
  ) {
    return(test_output(
      test_name,
      "PASS",
      "No characteristic_group and characteristic columns found.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  acceptable_vals <- unique(c(
    eesyscreener::acceptable_ethnicity_values$ethnicity_major,
    eesyscreener::acceptable_ethnicity_values$ethnicity_minor
  ))

  nonstandard <- data |>
    dplyr::filter(
      grepl("ethnic", .data$characteristic_group, ignore.case = TRUE)
    ) |>
    dplyr::distinct(.data$characteristic) |>
    dplyr::filter(!.data$characteristic %in% acceptable_vals) |>
    dplyr::collect() |>
    dplyr::pull("characteristic")

  if (length(nonstandard) == 0) {
    test_output(
      test_name,
      "PASS",
      paste0(
        "All ethnicity characteristic values are consistent with",
        " the GSS standards."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    eth_nonconformance_warning(
      test_name,
      nonstandard,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
