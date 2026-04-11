test_that("passes with clean example data", {
  expect_equal(
    check_filter_blanks(example_data, example_meta)$result,
    "PASS"
  )
  expect_no_error(
    check_filter_blanks(example_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("passes when there are no filter columns", {
  no_filter_meta <- data.frame(
    col_name = "enrolment_count",
    col_type = "Indicator",
    filter_grouping_column = "",
    stringsAsFactors = FALSE
  )
  no_filter_data <- data.frame(enrolment_count = 100)

  result <- check_filter_blanks(no_filter_data, no_filter_meta)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "no filter columns to check")
})

test_that("uses singular message for one failing column", {
  bad_data <- example_data |>
    dplyr::mutate(sex = dplyr::if_else(dplyr::row_number() == 1, "", .data$sex))

  result <- check_filter_blanks(bad_data, example_meta)

  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex")
  expect_match(result$message, "column:")
})

test_that("uses plural message for multiple failing columns", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(dplyr::row_number() == 1, "", .data$sex),
      education_phase = dplyr::if_else(
        dplyr::row_number() == 1,
        "",
        .data$education_phase
      )
    )

  result <- check_filter_blanks(bad_data, example_meta)
  expect_match(result$message, "columns:")
  expect_equal(result$result, "FAIL")
})

test_that("fails singularly when multiple blank values in 1 col", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(dplyr::row_number() %in% c(1, 3, 5), "", .data$sex),
    )

  result <- check_filter_blanks(bad_data, example_meta)
  expect_match(result$message, "column:")
  expect_equal(result$result, "FAIL")
})

test_that("uses plural when multiple blank values in cols", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(dplyr::row_number() %in% c(1, 3, 5), "", .data$sex),
      education_phase = dplyr::if_else(
        dplyr::row_number() == 1,
        "",
        .data$education_phase
      )
    )

  result <- check_filter_blanks(bad_data, example_meta)
  expect_match(result$message, "columns:")
  expect_match(result$message, "All filter cells must")
  expect_equal(result$result, "FAIL")
})

test_that("fails when a filter group column contains a blank value", {
  grp_meta <- data.frame(
    col_name = c("sex", "enrolment_count"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("sex_group", ""),
    stringsAsFactors = FALSE
  )
  grp_data <- data.frame(
    sex = c("Male", "Female"),
    sex_group = c("", "All"),
    enrolment_count = c(100, 200)
  )

  result <- check_filter_blanks(grp_data, grp_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex_group")
})
