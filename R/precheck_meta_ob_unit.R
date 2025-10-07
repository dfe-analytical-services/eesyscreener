#' Check there are no observational units with rows in the metadata
#'
#' Make sure that no observational unit columns are referenced in the col_name
#' and filter_grouping_column columns.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_meta
#'
#' @examples
#' precheck_meta_ob_unit(example_meta)
#' precheck_meta_ob_unit(example_meta, verbose = TRUE)
#' @export
precheck_meta_ob_unit <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  cols_in_meta <- get_cols_meta(meta, grouping_cols = TRUE)

  acceptable_ob_exc_sch_prov <- setdiff(
    get_acceptable_ob_units(),
    c("school_name", "provider_name")
  )

  ob_units_in_meta <- intersect(
    acceptable_ob_exc_sch_prov,
    cols_in_meta
  )

  if (length(ob_units_in_meta) == 0) {
    test_output(
      "meta_ob_unit",
      "PASS",
      paste(
        "No observational units have been included in the metadata",
        "file."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else if (length(ob_units_in_meta) == 1) {
    test_output(
      "meta_ob_unit",
      "FAIL",
      paste0(
        "The following observational unit needs removing from the metadata",
        " file: '",
        paste(ob_units_in_meta, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      "meta_ob_unit",
      "FAIL",
      paste0(
        "The following observational units need removing from the metadata",
        " file: '",
        paste(ob_units_in_meta, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
