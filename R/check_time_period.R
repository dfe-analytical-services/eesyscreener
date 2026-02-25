#' Check that time periods match the time identifier
#'
#' Every time indentifier is only compatible with either 4 or 6 digit time
#' periods.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family check_time
#' @examples
#' check_time_period(example_data)
#' @export
check_time_period <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  base_identifier <- data |>
    dplyr::slice(1) |>
    dplyr::pull("time_identifier")

  time_length <- data
  time_length[["digits"]] <- stringr::str_count(time_length[["time_period"]])

  if (base_identifier %in% four_digit_identifiers) {
    if (nrow(dplyr::filter(time_length, digits == 4)) != nrow(time_length)) {
      guidance_url <- render_url(
        "statistics-production/ud.html#list-of-allowable-time-values"
      )
      message <- paste0(
        "The time_period length for '",
        paste(base_identifier),
        "' must always be a four digit number."
      )
      result <- "FAIL"
    } else {
      message <- "The time_period length matches the time_identifier values in the data file."
      result <- "PASS"
      guidance_url <- NA
    }
  }

  if (base_identifier %in% six_digit_identifiers) {
    if (nrow(dplyr::filter(time_length, digits == 6)) != nrow(time_length)) {
      guidance_url <- render_url(
        "statistics-production/ud.html#list-of-allowable-time-values"
      )
      message <- paste0(
        "The time_period length for '",
        paste(base_identifier),
        "' must always be a six digit number."
      )
      result <- "FAIL"
    } else {
      message <- "The time_period length matches the time_identifier values in the data file."
      result <- "PASS"
      guidance_url <- NA
    }
  }

  test_output(
    "time_period",
    result,
    message,
    guidance_url,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
