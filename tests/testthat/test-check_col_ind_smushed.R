test_that("passes when no indicators contain filter entry substrings", {
  expect_equal(check_col_ind_smushed(example_meta)$result, "PASS")
  expect_no_error(check_col_ind_smushed(example_meta, stop_on_error = TRUE))
})

test_that("fails with one smushed indicator (singular message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = "enrolment_male",
      col_type = "Indicator",
      label = "Number of male enrolments",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = "0",
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- check_col_ind_smushed(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("enrolment_male", result$message))
  expect_true(grepl("indicator appears", result$message))
  expect_error(check_col_ind_smushed(bad_meta, stop_on_error = TRUE))
})

test_that("fails with multiple smushed indicators (plural message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = c("enrolment_male", "enrolment_female"),
      col_type = "Indicator",
      label = c("Number of male enrolments", "Number of female enrolments"),
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = "0",
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- check_col_ind_smushed(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("enrolment_male", result$message))
  expect_true(grepl("enrolment_female", result$message))
  expect_true(grepl("indicators appear", result$message))
  expect_error(check_col_ind_smushed(bad_meta, stop_on_error = TRUE))
})

test_that("passes when filter columns contain filter substrings", {
  filter_meta <- example_meta
  filter_meta$col_name[1] <- "male_female"
  expect_equal(check_col_ind_smushed(filter_meta)$result, "PASS")
})

test_that("check is case-insensitive for substrings", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = "enrolment_MALE",
      col_type = "Indicator",
      label = "Number of MALE enrolments",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = "0",
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- check_col_ind_smushed(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("enrolment_MALE", result$message))
})
