#' Check all time_identifier values are valid
#'
#' Checks against the `acceptable_time_identifiers` object.
#'
#' @inheritParams precheck_col_req_data
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_time
#' @examples
#' precheck_time_id_valid(example_data)
#' @export
precheck_time_id_valid <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()
  invalid_identifiers <- data |>
    dplyr::distinct(.data$time_identifier) |>
    dplyr::anti_join(
      data.frame(
        "time_identifier" = unlist(
          eesyscreener::acceptable_time_ids,
          use.names = FALSE
        )
      ),
      by = "time_identifier"
    ) |>
    dplyr::pull("time_identifier")

  if (length(invalid_identifiers) == 0) {
    test_output(
      test_name,
      "PASS",
      "The time_identifier values are all valid.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(invalid_identifiers) == 1) {
      if (is.na(invalid_identifiers) || invalid_identifiers == "") {
        test_output(
          test_name,
          "FAIL",
          "At least one of the time_identifier values is blank or missing.",
          paste0(
            "https://dfe-analytical-services.github.io/analysts-guide/",
            "statistics-production/ud.html#list-of-allowable-time-values"
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      } else {
        test_output(
          test_name,
          "FAIL",
          sprintf(
            "The following invalid time_identifier was found: '%s'.",
            invalid_identifiers
          ),
          paste0(
            "https://dfe-analytical-services.github.io/analysts-guide/",
            "statistics-production/ud.html#list-of-allowable-time-values"
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      }
    } else {
      test_output(
        test_name,
        "FAIL",
        sprintf(
          "The following invalid time_identifiers were found: '%s'.",
          paste(invalid_identifiers |> sort(), collapse = "', '")
        ),
        paste0(
          "https://dfe-analytical-services.github.io/analysts-guide/",
          "statistics-production/ud.html#list-of-allowable-time-values"
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
