data_dictionary <- readr::read_csv(
  render_url("data/data-dictionary.csv", domain = "screener_app_repo")
)

usethis::use_data(data_dictionary, overwrite = TRUE)
