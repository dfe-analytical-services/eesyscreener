#' Check for any non-numeric time_period values
#'
#' Check that all time_period values are numeric.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_time
#' @examples
#' precheck_time_period_num(example_data)
#' @export
precheck_time_period_num <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  raw_time_periods <- data |>
    dplyr::distinct(.data$time_period) |>
    dplyr::pull("time_period")

  # Identify values that are NOT 4 or 6 digits
  non_numeric_values <- raw_time_periods[
    !grepl("^\\d{4}(\\d{2})?$", raw_time_periods)
  ]

  if (length(non_numeric_values) == 0) {
    message <- "The time_period column only contains numeric values."
    result <- "PASS"
    guidance_url <- NA
  } else {
    guidance_url <- render_url(
      "statistics-production/ud.html#list-of-allowable-time-values"
    )

    value_label <- if (length(non_numeric_values) == 1) "value" else "values"
    message <- sprintf(
      "The following invalid time_period %s were found in the data file: '%s', time_period must always be either a 4 or 6 digit number.",
      value_label,
      paste0(non_numeric_values, collapse = "', '")
    )
    result <- "FAIL"
  }

  test_output(
    "time_period_num",
    result,
    message,
    guidance_url,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
