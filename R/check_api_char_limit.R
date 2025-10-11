#' Check if values exceed a character limit
#'
#' Can be used to check individual strings, or vectors of strings.
#'
#' Uses the exported `api_char_limits` data.frame as a reference for the
#' limits.
#'
#' @param values A character vector of strings to check
#' @param type A character string specifying the type of values being checked,
#' one of "location-code", "column-name", "column-label" or "column-item".
#' @param verbose Logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error Logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit check_filename_spaces return
#'
#' @family check_api
#' @examples
#' check_api_char_limit(names(example_data), "column-name")
#' check_api_char_limit(names(example_data), "column-name", verbose = TRUE)
#' @export

# TODO: Add additional code to handle multiple columns

check_api_char_limit <- function(
  values,
  type,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (!is.character(values)) {
    cli::cli_abort("`values` must be a character vector.")
  }
  if (!type %in% eesyscreener::api_char_limits$id) {
    cli::cli_abort(
      paste(
        "`type` must be one of: {paste(eesyscreener::api_char_limits$id,",
        "collapse = ', ')}"
      )
    )
  }

  test_name <- paste0("check_api_char_limit_", type)
  max_length <- eesyscreener::api_char_limits$char_limit[
    eesyscreener::api_char_limits$id == type
  ]
  results <- char_limits(values, max_length)
  pretty_type <- eesyscreener::api_char_limits$name[
    eesyscreener::api_char_limits$id == type
  ]

  if (any(results$exceeds_max)) {
    fail_values <- results$value[results$exceeds_max]
    return(
      test_output(
        test_name,
        "WARNING",
        paste0(
          "The following ",
          pretty_type,
          " exceed the character limit of ",
          max_length,
          " for type '",
          type,
          "': ",
          paste(shQuote(fail_values), collapse = ", "),
          "."
        ),
        paste0(
          "https://dfe-analytical-services.github.io/analysts-guide/",
          "statistics-production/api-data-standards.html",
          "#character-limits-for-col_names-and-filter-items"
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    )
  } else {
    test_output(
      test_name,
      "PASS",
      paste0(
        "All ",
        pretty_type,
        " are less than or equal to the character limit of ",
        max_length,
        "."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
