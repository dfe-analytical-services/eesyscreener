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
  education_phase = c(
    "All phases", "Primary", "Secondary", "All phases", "All phases",
    "Primary", "Primary", "Secondary", "Secondary"
  ),
  enrolment_count = c(1000, 300, 700, 450, 460, 200, 205, 250, 255)
)

example_meta <- data.frame(
  col_name = c("sex", "education_phase", "enrolment_count"),
  col_type = c("Filter", "Filter", "Indicator"),
  label = c("Sex of pupil", "Education phase", "Number of enrolments"),
  indicator_grouping = c("", "", ""),
  indicator_unit = c("", "", ""),
  indicator_dp = c("", "", 0),
  filter_hint = c("", "", ""),
  filter_grouping_column = c("", "", "")
)

usethis::use_data(example_data, overwrite = TRUE)
usethis::use_data(example_meta, overwrite = TRUE)
