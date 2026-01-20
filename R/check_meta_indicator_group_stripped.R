#' Check that no issues arise when stripping alpha-numeric characters and spaces from indicator groups.
#' filter groups should have the same number of unique filter groups when stripped of non-alphanumeric characters
#'
#' Throw warning if there are any indicator rows that have filter_group as
#' non-blank, to encourage users to correct the metadata.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_indicator_group_stripped(example_meta)
#' check_meta_indicator_group_stripped(example_meta, verbose = TRUE)
#' @export

filter_group_stripped <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (meta %>% filter(filter_grouping_column != "") %>% nrow() == 0) {
    output <- list(
      "message" = "There are no filter groups present.",
      "result" = "IGNORE"
    )
  } else {
    filter_group_columns <- meta %>%
      filter(col_type == "Filter", filter_grouping_column != "") %>%
      pull(filter_grouping_column)

    get_values <- function(column) {
      return(unique(data[[column]]))
    }

    raw_filter_groups <- lapply(filter_group_columns, get_values)

    stripped_filter_groups <- lapply(
      raw_filter_groups,
      gsub,
      pattern = "[^[:alnum:]]",
      replacement = ""
    ) %>%
      lapply(unique)

    comparison <- unlist(lapply(raw_filter_groups, length)) ==
      unlist(lapply(stripped_filter_groups, length))

    failed_cols <- which(comparison %in% FALSE)

    if (length(failed_cols) > 0) {
      output <- list(
        "message" = paste0(
          "The number of unique filter groups should not change when non-alphanumeric characters are stripped. <br> - please check this list for erroneous filter group values: '",
          paste0(unlist(raw_filter_groups[failed_cols]), collapse = "', '"),
          "'."
        ),
        "result" = "FAIL"
      )
    } else {
      output <- list(
        "message" = "There are no issues when stripping alpha-numeric characters from filter groups.",
        "result" = "PASS"
      )
    }
  }

  return(output)
}
