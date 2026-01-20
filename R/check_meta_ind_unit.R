#' Check indicator_dp is set for all indicator rows
#'
#' Throw warning if there are any blank cells for indicator_dp in rows, to
#' encourage users to explicitly specify the behaviour they want.
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
  filtered_meta <- meta |>
    dplyr::filter(
      col_type == "Filter",
      !is.na(indicator_unit),
      indicator_unit != ""
    )
  
  indicator_units <- filtered_meta |>
    dplyr::pull(indicator_unit)

  if (length(indicator_units) > 0) {
    test_output(
      "meta_ind_unit",
      "FAIL",
      paste0("Filters should not have an indicator_unit value in the metadata file. This occurs for columns: ",paste0(filtered_meta |> dplyr::pull(labels)), "at positions: ",paste0(),"."),
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

  return(output)
}