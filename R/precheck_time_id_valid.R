#' Check all time_identifier values are valid
#'
#' Checks against the `acceptable_time_identifiers` object.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family precheck_time
#' @examples
#' precheck_time_id_valid(example_data, example_meta)
#' precheck_time_id_valid(example_data, example_meta, output = "table")
#' @export
precheck_time_id_valid <- function(data, meta, output = "console") {
  invalid_identifiers <- data |>
    dplyr::distinct(.data$time_identifier) |>
    dplyr::anti_join(
      data.frame("time_identifier" = eesyscreener::acceptable_time_ids),
      by = "time_identifier"
    ) |>
    dplyr::pull("time_identifier")

  if (length(invalid_identifiers) == 0) {
    test_output(
      "time_id_valid",
      "PASS",
      "The time_identifier values are all valid.",
      output = output
    )
  } else {
    if (length(invalid_identifiers) == 1) {
      if (is.na(invalid_identifiers) || invalid_identifiers == "") {
        test_output(
          "time_id_valid",
          "FAIL",
          "At least one of the time_identifier values is blank or missing.",
          paste0(
            "https://dfe-analytical-services.github.io/analysts-guide/",
            "statistics-production/ud.html#list-of-allowable-time-values"
          ),
          output = output
        )
      } else {
        test_output(
          "time_id_valid",
          "FAIL",
          sprintf(
            "The following invalid time_identifier was found: '%s'.",
            invalid_identifiers
          ),
          paste0(
            "https://dfe-analytical-services.github.io/analysts-guide/",
            "statistics-production/ud.html#list-of-allowable-time-values"
          ),
          output = output
        )
      }
    } else {
      test_output(
        "time_id_valid",
        "FAIL",
        sprintf(
          "The following invalid time_identifiers were found: '%s'.",
          paste(invalid_identifiers, collapse = "', '")
        ),
        paste0(
          "https://dfe-analytical-services.github.io/analysts-guide/",
          "statistics-production/ud.html#list-of-allowable-time-values"
        ),
        output = output
      )
    }
  }
}
