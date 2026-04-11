# Valid country code and name combinations
# Sources from dfe-published-data-qa repo:
# country.csv and universal_geog_options.csv

countries <- readr::read_csv(
  render_url("data/country.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(countries, overwrite = TRUE)

universal_geog_options <- readr::read_csv(
  render_url("data/universal_geog_options.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(universal_geog_options, overwrite = TRUE)
