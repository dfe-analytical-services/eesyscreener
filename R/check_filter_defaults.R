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
#' @family filename
#'
#' @examples
#' check_filter_defaults(example_data, example_meta)
#' @export
check_filter_defaults <- function(data, meta, verbose = FALSE, stop_on_error = FALSE) {
  if (!"filter_default" %in% names(meta)) {
    meta <- meta |>
      dplyr::mutate(filter_default = "Total")
  }
  filters <- meta %>%
    dplyr::filter(col_type == "Filter") %>%
    dplyr::select(col_name, filter_default)

  filter_groups <- meta %>%
    dplyr::filter(
      !is.na(filter_grouping_column),
      filter_grouping_column != "",
      !filter_grouping_column %in% col_name
    ) %>%
    dplyr::mutate(filter_default = "Total") |>
    dplyr::select(col_name = filter_grouping_column, filter_default)

  filters_and_groups <- dplyr::bind_rows(filters, filter_groups)

  if (length(filters_and_groups) == 0) {
    output <- list(
      "message" = "There are no filters in the data file.",
      "result" = "IGNORE"
    )
  } else {
    dfilters <- data |>
      dplyr::select(all_of(filters_and_groups$col_name))

    filter_defaults <- setNames(
      filters_and_groups$filter_default,
      filters_and_groups$col_name
    )

    # Apply the condition across all columns using sapply
    pre_result <- sapply(
      names(dfilters),
      function(column) {
        any(dfilters[[column]] == filter_defaults[[column]])
      }
    )

    if (all(pre_result)) {
      output <- list(
        "message" = "All filters and groups have a default filter item present.",
        "result" = "PASS"
      )
    } else {
      missing_total <- names(result[!result])

      output <- list(
        "message" = paste0(
          "A 'Total' entry or default filter item should be added to the following filters and",
          " / or filter_groups where applicable: '",
          paste(missing_total, collapse = "', '"),
          "'."
        ),
        "result" = "ADVISORY"
      )
    }
  }

  return(output)
}
