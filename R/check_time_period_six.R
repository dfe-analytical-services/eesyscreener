#' Check that 6 digit time periods give consecutive years
#'
#' Every 6 digit time indentifier should be in the format YYYYZZ where YYYY is
#' a 4 digit year and ZZ is the final two digits of the following year.
#'
#' For example, 202122 is valid but 202120 is not.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family check_time
#' @examples
#' check_time_period_six(example_data)
#' @export

check_time_period_six <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (anyNA(data$time_period)) {
    message <- "NA values found in time_period; all values must be valid six digit numbers referring to consecutive years."
    result <- "FAIL"
    return(
      test_output(
        "time_period_six",
        result,
        message,
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    )
  }

  time_length <- data
  time_length$digits <- stringr::str_count(time_length$time_period)
  six_digit_years <- dplyr::filter(time_length, digits == 6)

  time_period_six_check <- function(i) {
    currentyearend <- as.numeric(substr(i, 3, 4))
    nextyearend <- as.numeric(substr(i, 5, 6))

    if (currentyearend == 99 && nextyearend == 0) {
      return("PASS")
    } else {
      if ((currentyearend + 1) == nextyearend) {
        return("PASS")
      } else {
        return("FAIL")
      }
    }
  }

  pre_result <- sapply(
    unique(six_digit_years$time_period),
    time_period_six_check
  )

  if (nrow(dplyr::filter(time_length, digits == 6)) == 0) {
    message <- "There are no six digit time_period values in the file."
    result <- "IGNORE"
  } else {
    if ("FAIL" %in% pre_result) {
      message <- "When the time period is six digits, the years must be consecutive such as 201920."
      result <- "FAIL"
    } else {
      message <- "The six digit time_period values refer to consecutive years."
      result <- "PASS"
    }
  }

  test_output(
    "time_period_six",
    result,
    message,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
}
