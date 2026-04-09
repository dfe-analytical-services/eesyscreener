#' Check that time periods match the time identifier
#'
#' Every time identifier is only compatible with either 4 or 6 digit time
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
    dplyr::distinct(.data$time_identifier) |>
    dplyr::pull("time_identifier") |>
    utils::head(1)

  unique_periods <- data |>
    dplyr::distinct(.data$time_period) |>
    dplyr::pull("time_period")

  if (base_identifier %in% eesyscreener::four_digit_identifiers) {
    # isTRUE() handles NA periods: nchar(NA) returns NA, causing all() to
    # return NA
    if (!isTRUE(all(nchar(unique_periods) == 4))) {
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
      message <- paste0(
        "The time_period length matches the time_identifier",
        " values in the data file."
      )
      result <- "PASS"
      guidance_url <- NA
    }
  }

  if (base_identifier %in% eesyscreener::six_digit_identifiers) {
    # isTRUE() handles NA periods: nchar(NA) returns NA, causing all() to
    # return NA
    if (!isTRUE(all(nchar(unique_periods) == 6))) {
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
      message <- paste0(
        "The time_period length matches the time_identifier",
        " values in the data file."
      )
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
