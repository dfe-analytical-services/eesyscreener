# Valid goeg code and name combinations
# Sources from dfe-published-data-qa repo for now
# TODO: Move to create from dfeR (or us as a dependency direct)

acceptable_countries <- readr::read_csv(
  render_url("data/country.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_countries, overwrite = TRUE)

acceptable_extra_geog_options <- readr::read_csv(
  render_url("data/universal_geog_options.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_extra_geog_options, overwrite = TRUE)

acceptable_regions <- readr::read_csv(
  render_url("data/regions.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_regions, overwrite = TRUE)
