# Harmonised column name lookup ====
# Maps search strings to acceptable harmonised column names.
# Source: dfe-published-data-qa screener app repo, data/harmonised_col_names.csv

harmonised_col_names <- readr::read_csv(
  render_url("data/harmonised_col_names.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(harmonised_col_names, overwrite = TRUE)

# Acceptable ethnicity values ====
# Standard GSS major and minor ethnicity value pairs.
# Source: dfe-published-data-qa screener app repo, data/ethnicity.csv

acceptable_ethnicity_values <- readr::read_csv(
  render_url("data/ethnicity.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_ethnicity_values, overwrite = TRUE)
