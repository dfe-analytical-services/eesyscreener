#' Check for geography columns mislabelled as filters
#'
#' Catch if any geography columns are being included as filters in the metadata
#' file. This checks both filter `col_name` values and `filter_grouping_column`
#' values against a regex pattern that matches common geography-related column
#' names (e.g., names containing "la", "region", "urn", "ukprn", etc.).
#'
#' If the only filter is `school_name` or `provider_name`, those are excluded
#' from the check as they are acceptable as filters in that context.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_geog_catch(example_meta)
#' check_meta_geog_catch(example_meta, verbose = TRUE)
#' @export
check_meta_geog_catch <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  # Regex matching common geography-related column names
  potential_ob_units_regex <- paste0(
    "(^(sch|prov|inst|estab|reg|la|local|rsc|pfa|pcon|lep|mca|oa|ward|mat)",
    ".*(name|code|urn|ukprn|number|upin|id)$)",
    "|(^(laestab|estab|sch|school|schools|prov|provider|providers|inst|",
    "institution|institutions|name|code|urn|ukprn|number|upin|id|region|",
    "la|lad|rsc|pcon|lep|mca|oa|ward|mat)$)"
  )

  filters <- meta |>
    dplyr::filter(.data$col_type == "Filter") |>
    dplyr::pull("col_name")

  filter_groups <- meta |>
    dplyr::filter(
      !is.na(.data$filter_grouping_column),
      .data$filter_grouping_column != ""
    ) |>
    dplyr::pull("filter_grouping_column")

  # If the only filter is school_name or provider_name, exclude those from
  # the check as they are acceptable as filters in that context
  if (
    length(filters) == 1 &&
      any(
        filters[1] %in% c("school_name", "provider_name"),
        filter_groups[1] %in% c("school_name", "provider_name")
      )
  ) {
    filters_and_groups <- c(filters, filter_groups)[
      !c(filters, filter_groups) %in% c("school_name", "provider_name")
    ]
  } else {
    filters_and_groups <- c(filters, filter_groups)
  }

  caught_filters <- filters_and_groups[grepl(
    potential_ob_units_regex,
    filters_and_groups,
    ignore.case = TRUE
  )]

  if (length(caught_filters) == 0) {
    test_output(
      "meta_geog_catch",
      "PASS",
      "No filters appear to be mislabelled geography columns.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(caught_filters) == 1) {
      test_output(
        "meta_geog_catch",
        "FAIL",
        paste0(
          "The following filter appears to be a geographic column and ",
          "shouldn't be included in the metadata file: '",
          paste0(caught_filters, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "meta_geog_catch",
        "FAIL",
        paste0(
          "The following filters appear to be geographic columns and ",
          "shouldn't be included in the metadata file: '",
          paste0(caught_filters, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
