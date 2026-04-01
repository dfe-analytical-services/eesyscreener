test_that("Test produces PASS response when data is of a National level", {
  expect_equal(precheck_geog_level_present(example_data)$result, "PASS")
  expect_no_error(precheck_geog_level_present(
    example_data,
    stop_on_error = TRUE
  ))
})

test_that("Test produces PASS response when data contains all the required columns for a geographic_level", {
  input_data <- data.frame(
    time_period = c(
      "201718"
    ),
    time_identifier = "Academic year",
    geographic_level = "Local authority",
    country_code = "E92000001",
    country_name = "England",
    sex = c(
      "All pupils"
    ),
    education_phase = c(
      "All phases"
    ),
    enrolment_count = c(1000),
    la_name = "Bracknell Forest",
    new_la_code = "E06000036",
    old_la_code = 867
  )

  expect_equal(precheck_geog_level_present(input_data)$result, "PASS")
  expect_true(
    precheck_geog_level_present(input_data)$message ==
      "The geography columns are present as expected for the geographic_level values in the file."
  )
  expect_no_error(precheck_geog_level_present(
    input_data,
    stop_on_error = TRUE
  ))
})

test_that("Test produces PASS response when data contains mixed geographic levels with all required columns", {
  input_data <- data.frame(
    time_period = c("201718", "201718"),
    time_identifier = "Academic year",
    geographic_level = c("National", "Local authority"),
    country_code = c("E92000001", "E92000001"),
    country_name = c("England", "England"),
    la_name = c(NA, "Bracknell Forest"),
    new_la_code = c(NA, "E06000036"),
    old_la_code = c(NA, 867),
    enrolment_count = c(1000, 500)
  )

  expect_equal(precheck_geog_level_present(input_data)$result, "PASS")
})

test_that("Test produces FAIL response when data doesn't contain all the required columns for a geographic_level", {
  input_data <- data.frame(
    time_period = c(
      "201718"
    ),
    time_identifier = "Academic year",
    geographic_level = "Local authority",
    country_code = "E92000001",
    country_name = "England",
    sex = c(
      "All pupils"
    ),
    education_phase = c(
      "All phases"
    ),
    enrolment_count = c(1000),
    la_name = "Bracknell Forest",
    new_la_code = "E06000036"
  )

  expect_equal(precheck_geog_level_present(input_data)$result, "FAIL")
  expect_true(
    precheck_geog_level_present(input_data)$message ==
      "Given that the following geographic_level values are present: 'Local authority'; the following column is missing from the file: 'old_la_code'."
  )
  expect_error(precheck_geog_level_present(
    input_data,
    stop_on_error = TRUE
  ))
})

test_that("Test produces FAIL plural response when data doesn't contain multiple required columns for a geographic_level", {
  input_data <- data.frame(
    time_period = c(
      "201718"
    ),
    time_identifier = "Academic year",
    geographic_level = "Local authority",
    country_code = "E92000001",
    country_name = "England",
    sex = c(
      "All pupils"
    ),
    education_phase = c(
      "All phases"
    ),
    enrolment_count = c(1000),
    la_name = "Bracknell Forest"
  )
  expect_equal(precheck_geog_level_present(input_data)$result, "FAIL")
  expect_true(
    precheck_geog_level_present(input_data)$message ==
      "Given that the following geographic_level values are present: 'Local authority'; the following columns are missing from the file: 'new_la_code' and 'old_la_code'."
  )
  expect_error(precheck_geog_level_present(
    input_data,
    stop_on_error = TRUE
  ))
})
