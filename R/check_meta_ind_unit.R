#' Check indicator_dp is set for all indicator rows
#'
#' Throw FAIL if there indicator_unit values when col_type is Filter
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_ind_unit(example_meta)
#' check_meta_ind_unit(example_meta, verbose = TRUE)
#' @export

check_meta_ind_unit <- function(meta,
  verbose = FALSE,
  stop_on_error = FALSE){

  filtered_positions <- which(
    meta$col_type == "Filter" &
    !is.na(meta$indicator_unit) &
    meta$indicator_unit != ""
  )

  filtered_meta <- meta |> slice(filtered_positions)

  indicator_units <- filtered_meta |>
    dplyr::pull(indicator_unit)

  if (length(indicator_units) > 0) {
    test_output(
      "meta_ind_unit",
      "FAIL",
      paste0("Filters should not have an indicator_unit value in the metadata file. This occurs for columns: ",paste0(sort(unique(filtered_meta |> dplyr::pull(label))), collapse = ", "), " at positions: ",paste0(filtered_positions,collapse = ", "),"."),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "meta_ind_unit",
      "PASS",
      "No filters have an indicator_unit value.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
