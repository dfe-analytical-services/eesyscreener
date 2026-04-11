#' Check for Total or All values in observational unit columns
#'
#' Checks that no observational unit columns (time period, geographic, or
#' other known structural columns) contain "Total", "total", "All", or "all"
#' as values. These aggregate placeholders should only appear in filter columns,
#' not in observation unit columns. Rows containing them in ob unit columns
#' indicate incorrectly structured data.
#'
#' School-level and provider-level data where `school_name` or `provider_name`
#' is the only filter are exempt, as these are acceptable as filters in that
#' context.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_ob_total(example_data, example_meta)
#' check_filter_ob_total(example_data, example_meta, verbose = TRUE)
#' @export
check_filter_ob_total <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  # school_name and provider_name are acceptable as filters in school / provider
  # level data, so we handle them as a special case
  sch_prov_names <- c("school_name", "provider_name")

  # Get acceptable ob unit columns, excluding school / provider name columns
  ob_units <- get_acceptable_ob_units()
  ob_units_no_sch_prov <- ob_units[!ob_units %in% sch_prov_names]

  # Regex matching common geography-related column names
  potential_ob_units_regex <- paste0(
    "(^(country|sch|prov|inst|estab|reg|la|local|",
    "rsc|pfa|pcon|lep|mca|oa|ward|mat)",
    ".*(name|code|urn|ukprn|number|upin|id)$)",
    "|(^(laestab|estab|sch|school|schools|prov|provider|providers|inst|",
    "institution|institutions|name|code|urn|ukprn|number|upin|id|region|",
    "la|lad|rsc|pcon|lep|mca|oa|ward|mat)$)"
  )

  data_cols <- dplyr::tbl_vars(data)

  # Columns to check: acceptable ob units present in data plus regex matches
  ob_cols <- unique(c(
    intersect(ob_units_no_sch_prov, data_cols),
    data_cols[grepl(potential_ob_units_regex, data_cols, ignore.case = TRUE)]
  ))

  # If the only filter is school_name or provider_name, exclude those columns
  # from the check as they are acceptable as filters in that context
  filters <- get_filters(meta)
  filter_groups <- get_filter_groups(meta)

  if (
    length(filters) == 1 &&
      any(
        filters[1] %in% sch_prov_names,
        filter_groups[1] %in% sch_prov_names
      )
  ) {
    ob_cols <- ob_cols[!ob_cols %in% sch_prov_names]
  }

  if (length(ob_cols) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "There are no Total or All values in the observational unit columns.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  total_values <- c("Total", "total", "All", "all")

  cols_with_total <- ob_cols[vapply(
    ob_cols,
    function(col) {
      vals <- data |>
        dplyr::select(dplyr::all_of(col)) |>
        dplyr::distinct() |>
        dplyr::pull(1)
      any(total_values %in% vals)
    },
    logical(1)
  )]

  if (length(cols_with_total) == 0) {
    test_output(
      test_name,
      "PASS",
      "There are no Total or All values in the observational unit columns.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "There are Total or All rows in the following observational unit ",
        "{cli::qty(length(cols_with_total))}column{?s}: '",
        paste0(cols_with_total, collapse = "', '"),
        "'. These cells should be blank."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
