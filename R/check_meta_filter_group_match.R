#' Check filter groups match in data and meta
#'
#' Ensure all filter groups from the meta data are found in the data file.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_col_name(example_meta)
#' check_meta_col_name(example_meta, verbose = TRUE)
#' @export
check_meta_filter_group_match <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  meta_filter_groups <- meta %>%
    filter(!is.na(filter_grouping_column) & filter_grouping_column != "")

  if (nrow(meta_filter_groups) == 0) {
    output <- list(
      "message" = "There are no filter groups present.",
      "result" = "IGNORE"
    )
  } else {
    filter_groups_not_in_data <- setdiff(
      meta_filter_groups$filter_grouping_column,
      names(data)
    )
    number_filter_groups_not_in_data <- length(filter_groups_not_in_data)

    if (number_filter_groups_not_in_data == 0) {
      output <- list(
        "message" = "All filter groups from the metadata were found in the data file.",
        "result" = "PASS"
      )
    } else {
      if (number_filter_groups_not_in_data == 1) {
        output <- list(
          "message" = paste0(
            "The following filter group from the metadata was not found as a variable in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          "result" = "FAIL"
        )
      } else {
        output <- list(
          "message" = paste0(
            "The following filter groups from the metadata were not found as variables in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          "result" = "FAIL"
        )
      }
    }
  }

  return(output)
}
