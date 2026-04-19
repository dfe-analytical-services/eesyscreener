#' Check filter groups have an equal or lower number of levels
#'
#' Ensure all filter groups have an equal or lower number of levels than
#' their corresponding filter.

#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_filter
#'
#' @examples
#' check_filter_group_level(example_data, example_meta)
#' @export

# filter_group_level -------------------------------------
# Checking that filter groups have fewer levels than their filters
check_filter_group_level <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  filters_and_groups <- meta |>
    dplyr::filter(
      .data$col_type == "Filter",
      !is.na(.data$filter_grouping_column) &
        .data$filter_grouping_column != ""
    ) |>
    dplyr::select("col_name", "filter_grouping_column") |>
    as.data.frame()
  test_name <- get_check_name()

  # If no filter groups present, return a message to say so
  if (nrow(filters_and_groups) == 0) {
    return(test_output(
      test_name,
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  # Count levels for each filter and group and pass if groups have fewer
  # levels than filters
  count_distinct <- function(x) {
    data |>
      dplyr::select(dplyr::all_of(x)) |>
      dplyr::distinct() |>
      dplyr::count() |>
      dplyr::pull("n")
  }
  # unname() is required: vapply() names its output after the input elements,
  # producing named integer vectors that duckplyr cannot translate when
  # methods_overwrite() is active. Base R column assignment avoids dplyr mutate
  # which would also fail with named or multi-element vector constants.
  filter_levels <- unname(vapply(
    filters_and_groups$col_name,
    count_distinct,
    integer(1)
  ))
  group_levels <- unname(vapply(
    filters_and_groups$filter_grouping_column,
    count_distinct,
    integer(1)
  ))
  filters_and_groups[["filter_levels"]] <- filter_levels
  filters_and_groups[["group_levels"]] <- group_levels
  filters_and_groups[["pre_result"]] <- ifelse(
    filter_levels >= group_levels,
    "PASS",
    "FAIL"
  )
  # Create failed pairs data frame
  failed_pairs <- filters_and_groups[
    filters_and_groups[["pre_result"]] == "FAIL",
  ]

  number_of_failed_pairs <- nrow(failed_pairs)
  # Output results based on whether there is one failed pair or multiple
  # failed pairs
  if (number_of_failed_pairs == 0) {
    test_output(
      test_name,
      "PASS",
      message = paste0(
        "All filter groups have an equal or lower number of",
        " levels than their corresponding filter."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (number_of_failed_pairs == 1) {
      test_output(
        test_name,
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
          "). This suggests that the hierarchy is the wrong",
          " way around in the metadata."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        test_name,
        "FAIL",
        message = paste0(
          "The following filter groups each have more levels",
          " than their corresponding filters, check that they",
          " are entered the correct way around in the metadata: '",
          paste0(failed_pairs$filter_grouping_column, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
