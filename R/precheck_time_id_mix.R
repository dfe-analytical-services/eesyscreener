#' Check the mix of time identifiers in the data file
#'
#' Check that only compatible time identifiers are together in the same file.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_time
#' @examples
#' precheck_time_id_mix(example_data)
#' @export
precheck_time_id_mix <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  # Grab the first time identifier to use as a base for checking rest of file
  base_identifier <- data |>
    dplyr::distinct(.data$time_identifier) |>
    dplyr::pull("time_identifier") |>
    head(1)

  match_base_identifier <- function(possible_level) {
    if (base_identifier %in% possible_level) {
      return(possible_level)
    }
  }

  base_level <- unlist(
    lapply(eesyscreener::acceptable_time_ids, match_base_identifier),
    use.names = FALSE
  )

  unique_time_ids <- data |>
    dplyr::distinct(.data$time_identifier) |>
    dplyr::pull("time_identifier")

  test_name <- "time_id_mix"
  guidance_url <- NA

  # Check if all unique_time_ids are in base_level
  if (!all(unique_time_ids %in% base_level)) {
    result <- "FAIL"
    message <- paste(
      "The datafile is mixing incompatible time identifiers. Allowable values with '",
      paste(base_identifier),
      "' present, are: '",
      paste(base_level, collapse = "', '"),
      "'."
    )
    guidance_url <- render_url(
      "statistics-production/ud.html#list-of-allowable-time-values"
    )
  } else if (length(unique_time_ids) == 1) {
    result <- "PASS"
    message <- "There is only one time_identifier value in the data."
  } else {
    result <- "PASS"
    message <- "The time_identifier values are mixed appropriately."
  }

  test_output(test_name, result, message, guidance_url, verbose, stop_on_error)
}
