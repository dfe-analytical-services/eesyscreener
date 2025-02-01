example_data <- data.frame(
  time_period = c(
    "201718", "201718", "201718", "201718", "201718",
    "201718", "201718", "201718", "201718"
  ),
  time_identifier = "Academic year",
  geographic_level = "National",
  country_code = "E92000001",
  country_name = "England",
  sex = c(
    "All pupils", "All pupils", "All pupils",
    "Male", "Female", "Male", "Female", "Male", "Female"
  ),
  establishment_type = c(
    "All establishments", "State-funded primary", "State-funded secondary",
    "All establishments", "All establishments", "State-funded primary",
    "State-funded primary", "State-funded secondary", "State-funded secondary"
  ),
  enrolment_count = c(1000, 300, 700, 450, 460, 200, 205, 250, 255)
)

usethis::use_data(example_data, overwrite = TRUE)
