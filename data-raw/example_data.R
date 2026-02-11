example_data <- data.frame(
  time_period = c(
    "201718",
    "201718",
    "201718",
    "201718",
    "201718",
    "201718",
    "201718",
    "201718",
    "201718"
  ),
  time_identifier = "Academic year",
  geographic_level = "National",
  country_code = "E92000001",
  country_name = "England",
  sex = c(
    "All pupils",
    "All pupils",
    "All pupils",
    "Male",
    "Female",
    "Male",
    "Female",
    "Male",
    "Female"
  ),
  education_phase = c(
    "All phases",
    "Primary",
    "Secondary",
    "All phases",
    "All phases",
    "Primary",
    "Primary",
    "Secondary",
    "Secondary"
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
  filter_grouping_column = c("", "", ""),
  filter_default = c("All pupils", "All phases", "")
)

usethis::use_data(example_data, overwrite = TRUE)
usethis::use_data(example_meta, overwrite = TRUE)

example_api_long <- example_data |>
  data.frame(
    mahoooooooooooooooooooooooooooooooooooooooooooooooooooosive = c(
      "Testing",
      "Testing",
      "One two"
    )
  )

example_api_long_meta <- example_meta |>
  rbind(
    data.frame(
      col_name = "mahoooooooooooooooooooooooooooooooooooooooooooooooooooosive",
      col_type = "Filter",
      label = "A very long column name",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = "",
      filter_hint = "",
      filter_grouping_column = ""
    )
  )

usethis::use_data(example_api_long, overwrite = TRUE)
usethis::use_data(example_api_long_meta, overwrite = TRUE)

# Note that for example_comma_data, the data set needs to be > 20,480 rows to
# be appropriate for the testing the read in functions.
example_comma_draft <- example_data |>
  dplyr::select(-c("time_period", "geographic_level")) |>
  dplyr::left_join(
    data.frame(
      time_period = paste0("20", seq(10, 24), seq(11, 25)),
      country_code = rep("E92000001", 15)
    )
  ) |>
  dplyr::left_join(
    dfeR::fetch_las(countries = "England") |>
      dplyr::mutate(
        country_code = "E92000001",
        geographic_level = "Local authority"
      )
  )

if (!"old_la_code" %in% names(example_comma_draft)) {
  warning(
    "old_la_code not found in dfeR fetch_las(). Are you using the most up to date version of dfeR?"
  )
}

example_comma_data <- dplyr::bind_rows(
  example_comma_draft |> dplyr::filter(!grepl(",", la_name)),
  example_comma_draft |> dplyr::filter(grepl(",", la_name))
) |>
  dplyr::select(
    "time_period",
    "time_identifier",
    "geographic_level",
    "country_code",
    "country_name",
    "new_la_code",
    "la_name",
    "old_la_code",
    "sex",
    "education_phase",
    "enrolment_count"
  )

example_comma_meta <- example_meta

usethis::use_data(example_comma_data, overwrite = TRUE)
usethis::use_data(example_comma_meta, overwrite = TRUE)
