#' Check country code and name combinations
#'
#' Checks that all country_code and country_name combinations in the data file
#' are valid. Rows where country_code is "x" (the GSS not-available code) are
#' excluded from the check.
#'
#' @inheritParams check_col_names_spaces
#'
#' @inherit check_filename_spaces return
#'
#' @family check_geog
#'
#' @examples
#' check_geog_country_combos(example_data)
#' check_geog_country_combos(example_data, verbose = TRUE)
#' @export
check_geog_country_combos <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  test_name <- get_check_name()

  valid_combos <- rbind(
    eesyscreener::acceptable_countries,
    eesyscreener::acceptable_extra_geog_options |>
      dplyr::rename(country_code = "code", country_name = "name")
  )

  invalid <- data |>
    dplyr::filter(.data$country_code != "x") |>
    dplyr::distinct(.data$country_code, .data$country_name) |>
    dplyr::anti_join(valid_combos, by = c("country_code", "country_name")) |>
    dplyr::collect()

  invalid_combos <- paste(invalid$country_code, invalid$country_name)

  if (length(invalid_combos) == 0) {
    test_output(
      test_name,
      "PASS",
      "All country_code and country_name combinations are valid.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      test_name,
      "FAIL",
      cli::pluralize(
        "The following country_code / country_name ",
        "{cli::qty(length(invalid_combos))}combination{?s}",
        " {?is/are} invalid: '",
        paste0(invalid_combos, collapse = "', '"),
        "'. We do not expect any combinations outside of the standard ",
        "geographies lookup (case sensitive), please check your name and ",
        "code combinations against this lookup."
      ),
      guidance_url = render_url(
        "data/country.csv",
        domain = "screener_app_repo"
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
