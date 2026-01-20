#' Check filter groups have an equal or lower number of levels
#'
#' Ensure ll filter groups have an equal or lower number of levels than their corresponding filter.

#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_filter_group_level(example_data, example_meta)
#' check_meta_filter_group_level(example_data, example_meta, verbose = TRUE)
#' @export

# filter_group_level -------------------------------------
# Checking that filter groups have fewer levels than their filters

# Add in roxygen2 
## use test_output function - check Ethan's filter_group_match


filter_group_level <- function(data, meta) {
  meta_filters_and_groups <- meta %>%
    filter(
      col_type == "Filter",
      !is.na(filter_grouping_column) & filter_grouping_column != ""
    ) %>%
    select(col_name, filter_grouping_column)

  if (nrow(meta_filters_and_groups) == 0) {
    output <- list(
      "message" = "There are no filter groups present.",
      "result" = "IGNORE"
    )
  } else {
    get_levels <- function(i) {
      as_tibble(data) %>%
        pull(i) %>%
        unique() %>%
        length()
    }

    filter_levels <- stack(sapply(
      meta_filters_and_groups %>% pull(col_name),
      get_levels
    )) %>%
      rename("col_name" = "ind", "filter_levels" = "values")

    filter_group_levels <- stack(sapply(
      meta_filters_and_groups %>% pull(filter_grouping_column) %>% unique(),
      get_levels
    )) %>%
      rename("filter_grouping_column" = "ind", "group_levels" = "values")

    extended_meta <- suppressWarnings(suppressMessages(
      meta_filters_and_groups %>%
        inner_join(filter_levels) %>%
        inner_join(filter_group_levels) %>%
        mutate(
          "pre_result" = case_when(
            filter_levels >= group_levels ~ "PASS",
            TRUE ~ "FAIL"
          )
        )
    ))

    failed_pairs <- extended_meta %>%
      filter(pre_result == "FAIL")

    number_of_failed_pairs <- failed_pairs %>%
      nrow()

    if (number_of_failed_pairs == 0) {
      output <- list(
        "message" = "All filter groups have an equal or lower number of levels than their corresponding filter.",
        "result" = "PASS"
      )
    } else {
      if (number_of_failed_pairs == 1) {
        output <- list(
          "message" = paste0(
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
          "result" = "FAIL"
        )
      } else {
        output <- list(
          "message" = paste0(
            "The following filter groups each have more levels than their corresponding filters, check that they are entered the correct way around in the metadata: <br> - '",
            paste0(failed_pairs$filter_grouping_column, collapse = "', '"),
            "'."
          ),
          "result" = "FAIL"
        )
      }
    }
  }

  return(output)
}