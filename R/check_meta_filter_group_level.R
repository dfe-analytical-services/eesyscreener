#' Check filter groups have an equal or lower number of levels
#'
#' Ensure all filter groups have an equal or lower number of levels than their corresponding filter.

#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_filter_group_level(example_meta, example_data)
#' @export

# filter_group_level -------------------------------------
# Checking that filter groups have fewer levels than their filters
check_meta_filter_group_level <- function( meta, data, verbose = TRUE, stop_on_error = FALSE) {
  meta_filters_and_groups <- meta |>
    dplyr::filter(
      col_type == "Filter",
      !is.na(filter_grouping_column) & filter_grouping_column != ""
    ) |>
    dplyr::select(col_name, filter_grouping_column)
  # If no filter groups present, return a message to say so
  if (nrow(meta_filters_and_groups) == 0) {
    return(test_output(
      "filter_groups_match",
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Count levels for each filter and group and pass if groups have fewer levels than filters
  # For each value in col_name 
  extended_meta <- meta_filters_and_groups %>%
    dplyr::mutate(
      filter_levels = purrr::map_int(col_name, ~ dplyr::n_distinct(data[[.x]])),
      group_levels = purrr::map_int(
        filter_grouping_column,
        ~ dplyr::n_distinct(data[[.x]])
      ),
      pre_result = dplyr::case_when(
        filter_levels >= group_levels ~ "PASS",
        TRUE ~ "FAIL"
      )
    )
  # Create failed pairs data frame
  failed_pairs <- extended_meta %>%
    dplyr::filter(pre_result == "FAIL")

  number_of_failed_pairs <- nrow(failed_pairs)
  # Output results based on whether there is one failed pair or multiple failed pairs
  if (number_of_failed_pairs == 0) {
    test_output(
      "filter_grouping_level",
      "PASS",
      message = "All filter groups have an equal or lower number of levels than their corresponding filter.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (number_of_failed_pairs == 1) {
      test_output(
        "filter_grouping_level",
        "FAIL",
        message = paste0(
          "The filter group '",
          paste(failed_pairs$filter_grouping_column),
          "' has more levels (",
          paste(failed_pairs$group_levels),
          ") than its corresponding filter '",
          paste(failed_pairs$col_name),
          "' (",
          paste(failed_pairs$filter_levels),
          "). <br> - This suggests that the hierarchy is the wrong way around in the metadata."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "filter_grouping_level",
        "FAIL",
        message = paste0(
          "The following filter groups each have more levels than their corresponding filters, check that they are entered the correct way around in the metadata: <br> - '",
          paste0(failed_pairs$filter_grouping_column, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}