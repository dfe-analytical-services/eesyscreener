test_that("passes when all filter groups in meta are present in data", {
  data <- data.frame(
    sex = c("M", "F"),
    education_phase = c("Primary", "Secondary")
  )
  meta <- data.frame(filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_match(data, meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_match(
    data,
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_filter_group_match(
    example_filter_group,
    example_filter_group_meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when no filter groups are defined in meta", {
  data <- data.frame(sex = c("M", "F"))
  meta <- data.frame(filter_grouping_column = c("", NA))
  expect_equal(check_meta_filter_group_match(data, meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_match(
    data,
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_filter_group_match(
    example_data,
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("ignores empty or NA filter_grouping_column values", {
  data <- data.frame(sex = c("M", "F"))
  meta <- data.frame(filter_grouping_column = c("sex", "", NA))
  expect_equal(check_meta_filter_group_match(data, meta)$result, "PASS")
})

test_that("fails when one filter group is missing from data", {
  data <- data.frame(sex = c("M", "F"))
  meta <- data.frame(filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_match(data, meta)$result, "FAIL")
  expect_error(check_meta_filter_group_match(data, meta, stop_on_error = TRUE))
})

test_that("fails when multiple filter groups are missing from data", {
  data <- data.frame(sex = c("M", "F"))
  meta <- data.frame(
    filter_grouping_column = c("sex", "education_phase", "ethnicity")
  )
  expect_equal(check_meta_filter_group_match(data, meta)$result, "FAIL")
  expect_error(check_meta_filter_group_match(data, meta, stop_on_error = TRUE))
})
