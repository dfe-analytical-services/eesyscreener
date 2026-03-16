#' Check number of filter items are below limit
#' Ensures that no filter contains more than 25,000 unique options, this 
#' is to protect the EES service against accidental data issues that can
#' cause performance issues within the admin system.
#'
#' @param data A character string of the data filename to check
#' @param meta A character string of the metadata filename to check
#' @param filter_item_limit The maximum number of unqiue items allowed in a single filter. Default
#' as used by the screener: 25000
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
#' check_filter_item_limit(example_data, example_meta)
#' @export
check_filter_item_limit <- function(
  data,
  meta,
  filter_item_limit = 25000,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- "check_filter_item_limit"

  filters_and_groups <- meta |>
    get_cols_meta(grouping_cols = TRUE)

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
    counts <- data.frame(
      filters = filters_and_groups,
      nentries = sapply(
        filters_and_groups,
        function(col) dplyr::n_distinct(data[[col]])
      )
    )
    if (all(counts$nentries <= filter_item_limit)) {
      return(
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
      )
    } else {
      large_filter_sets <- counts |>
        dplyr::filter(nentries > filter_item_limit) |>
        dplyr::pull(filters)
      return(
        test_output(
          test_name,
          "ERROR",
          paste0(
            "The following filters or filter groups contain more than the advised maximum number of unique entries: '",
            paste(large_filter_sets, collapse = "', '"),
            "'."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      )
    }
  }
}
