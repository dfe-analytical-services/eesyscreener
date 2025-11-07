# total -------------------------------------
# Check for Total in all filters

check_filter_defaults <- function(data, meta) {
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
      names(df),
      function(column) {
        any(df[[column]] == filter_defaults[[column]])
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
