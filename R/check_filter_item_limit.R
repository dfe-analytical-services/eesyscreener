#' Check number of filter items are below limit
#' Ensures that no filter contains more than 25,000 unique options, this
#' is to protect the EES service against accidental data issues that can
#' cause performance issues within the admin system.
#'
#' @param data A character string of the data filename to check
#' @param meta A character string of the metadata filename to check
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#' @param filter_item_limit The maximum number of unique items allowed in a
#' single filter. Default as used by the screener: 25000
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_item_limit(example_data, example_meta)
#' @export
check_filter_item_limit <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE,
  filter_item_limit = 25000
) {
  test_name <- get_check_name()

  filters_and_groups <- meta |>
    get_cols_meta(grouping_cols = TRUE, excl_indicators = TRUE)

  if (length(filters_and_groups) == 0) {
    test_output(
      test_name,
      "PASS",
      "There are no filters in the data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    # Single query: COUNT(DISTINCT col) for every filter column at once.
    counts_row <- data |>
      dplyr::summarise(dplyr::across(
        dplyr::all_of(filters_and_groups),
        ~ dplyr::n_distinct(.)
      )) |>
      dplyr::collect()

    counts <- data.frame(
      filters = filters_and_groups,
      nentries = unlist(counts_row, use.names = FALSE)
    )

    if (all(counts$nentries <= filter_item_limit)) {
      test_output(
        test_name,
        "PASS",
        paste(
          "All filters and groups have less than",
          filter_item_limit,
          "unique entries."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      large_filter_sets <- counts |>
        dplyr::filter(.data$nentries > filter_item_limit) |>
        dplyr::pull("filters")
      test_output(
        test_name,
        "FAIL",
        paste0(
          "The following filters or filter groups contain",
          " more than the advised maximum number of unique entries: '",
          paste(large_filter_sets, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
