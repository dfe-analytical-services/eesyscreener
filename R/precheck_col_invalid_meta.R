#' Check there are no invalid columns in the metadata
#'
#' Make sure that all column names are expected metadata columns.
#'
#' @param meta A data frame of the metadata file
#' @param output "table", "error-only", or "console". Default is "console"
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_col
#'
#' @examples
#' precheck_meta_col_type(example_meta)
#' precheck_meta_col_type(example_meta, output = "table")
#' @export
