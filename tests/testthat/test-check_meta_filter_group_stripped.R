test_that("passes when all filter groups are unique when stripped of non-alpanumeric characters", {
  data <- data.frame(
    sex = c("M", "F"),
    education_phase = c("Primary", "Secondary")
  )
  meta <- data.frame(filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_stripped(
    data,
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_filter_group_stripped(
    example_filter_group,
    example_filter_group_meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when no filter groups are defined in meta", {
  data <- data.frame(
    sex = c("M", "F"),
    education_phase = c("Primary", "Secondary")
  )
  meta <- data.frame(
    col_name = c("sex", "education_phase"),
    filter_grouping_column = ""
  )
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_stripped(
    data,
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_filter_group_stripped(
    example_data,
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("ignores empty or NA filter_grouping_column values", {
  data <- data.frame(sex = c("M", "F"))
  meta <- data.frame(filter_grouping_column = c("sex", "", NA))
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "PASS")
})

test_that("fails when one filter group does not have unique stripped items", {
  data <- data.frame(sex = c("M", "M*", "F"))
  meta <- data.frame(filter_grouping_column = "sex")
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "FAIL")
  expect_error(check_meta_filter_group_stripped(
    data,
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when multiple filter groups do not have unique stripped items", {
  data <- data.frame(
    sex = c("M", "M*", "F"),
    education_phase = c("Pri-mary", "Primary", "Secondary")
  )
  meta <- data.frame(filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "FAIL")
  expect_error(check_meta_filter_group_stripped(
    data,
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when filter groups have a variety of non-alphanumeric characters", {
  data <- data.frame(sex = c("_M", "$%M-+*", "...//F", "#F", "X", "X"))
  meta <- data.frame(filter_grouping_column = "sex")
  expect_equal(check_meta_filter_group_stripped(data, meta)$result, "FAIL")
  expect_error(check_meta_filter_group_stripped(
    data,
    meta,
    stop_on_error = TRUE
  ))
})
