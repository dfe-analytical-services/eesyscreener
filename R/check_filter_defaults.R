#' Check filenames line up between data and metadata files
#'
#' Making sure the data and metadata file follow the pattern of:
#' - datafile.csv (data file)
#' - datafile.meta.csv (metadata file)
#'
#' @param data A character string of the data filename to check
#' @param meta A character string of the metadata filename to check
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_defaults(example_data, example_meta)
#' @export
check_filter_defaults <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- "check_filter_defaults"
  guidance_url <- render_url(
    "statistics-production/ud.html#aggregates-and-default-filters"
  )
  if (!"filter_default" %in% names(meta)) {
    meta <- meta |>
      dplyr::mutate(filter_default = "Total")
  } else {
    meta <- meta |>
      dplyr::mutate(
        filter_default = dplyr::case_when(
          .data$filter_default == "" & col_type == "Filter" ~ "Total",
          .default = .data$filter_default
        )
      )
  }
  filters <- meta |>
    dplyr::filter(.data$col_type == "Filter") |>
    dplyr::select("col_name", "filter_default")

  filter_groups <- meta |>
    dplyr::filter(
      !is.na(.data$filter_grouping_column),
      .data$filter_grouping_column != "",
      !.data$filter_grouping_column %in% .data$col_name
    ) |>
    dplyr::mutate(filter_default = "Total") |>
    dplyr::select(col_name = "filter_grouping_column", "filter_default")

  filters_and_groups <- dplyr::bind_rows(filters, filter_groups)

  if (length(filters_and_groups) == 0) {
    return(
      test_output(
        test_name,
        "PASS",
        "There are no filters in the data file.",
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    )
  } else {
    # Trim the data to just the filters and reduce to single row per combination
    dfilters <- data |>
      dplyr::select(dplyr::all_of(filters_and_groups$col_name)) |>
      dplyr::distinct()

    filter_defaults <- stats::setNames(
      filters_and_groups$filter_default,
      filters_and_groups$col_name
    )

    # Check each filter column for the presence of the filter default (whether
    # Total or a custom one).
    pre_result <- sapply(
      names(dfilters),
      function(column) {
        any(dfilters[[column]] == filter_defaults[[column]])
      }
    )
    if (all(pre_result)) {
      return(
        test_output(
          test_name,
          "PASS",
          "All filters and groups have a default filter item present.",
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      )
    } else {
      missing_total <- names(pre_result[!pre_result])
      return(
        test_output(
          test_name,
          "WARNING",
          paste0(
            "A 'Total' entry or default filter item should be specified for the following filters and",
            " / or filter_groups where applicable: '",
            paste(missing_total, collapse = "', '"),
            "'."
          ),
          guidance_url = guidance_url,
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      )
    }
  }
}
