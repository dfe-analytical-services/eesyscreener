#' Check if col_names are present in the data dictionary
#'
#' Uses the exported `data_dictionary` data.frame as a reference for the
#' acceptable col_names.
#'
#' @param meta dataframe containing a data set's meta data
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @family check_api
#' @examples
#' check_api_dict_col_names(example_meta)
#' @export
check_api_dict_col_names <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- paste0("check_api_dict_col_names")
  dd_col_names <- data_dictionary |>
    dplyr::select(col_name, col_name_parent, col_type) |>
    tidyr::pivot_longer(
      c(col_name, col_name_parent),
      values_to = "col_name"
    ) |>
    dplyr::select(-name) |>
    dplyr::distinct() |>
    dplyr::arrange(col_type, col_name) |>
    dplyr::mutate(standard_col = TRUE)

  non_standard_col_names <- meta |>
    dplyr::select("col_type", "col_name", "filter_grouping_column") |>
    tidyr::pivot_longer(
      c("col_name", "filter_grouping_column"),
      values_to = "col_name"
    ) |>
    dplyr::select(-"name") |>
    dplyr::filter(.data$col_name != "") |>
    dplyr::left_join(
      dd_col_names,
      by = dplyr::join_by("col_type", "col_name")
    ) |>
    dplyr::filter(is.na(.data$standard_col)) |>
    dplyr::distinct()

  if (non_standard_col_names |> dplyr::count() |> dplyr::pull("n") == 0) {
    test_output(
      test_name,
      "PASS",
      "All col_names are consistent with the data dictionary.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    non_standard_indicators <- non_standard_col_names |>
      dplyr::filter(col_type == "Indicator") |>
      dplyr::pull("col_name") |>
      paste(collapse = ", ")
    non_standard_filters <- non_standard_col_names |>
      dplyr::filter(col_type == "Filter") |>
      dplyr::pull("col_name") |>
      paste(collapse = ", ")
    test_output(
      test_name,
      "WARNING",
      paste(
        "The following column(s) are not present in the",
        "<a href=\"https://github.com/dfe-analytical-services/dfe-published-data-qa/blob/main/data/data-dictionary.csv\">",
        "data dictionary</a>",
        "and should not be used as part of an API data set until resolved.<br>",
        ifelse(
          non_standard_indicators != "",
          paste("Indicators:", non_standard_indicators, "<br>"),
          ""
        ),
        ifelse(
          non_standard_filters != "",
          paste("Filters:", non_standard_filters),
          ""
        )
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
