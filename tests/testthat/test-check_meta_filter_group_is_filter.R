test_that("passes when all filter groups in meta are present in col_name", {
  meta <- data.frame(
    col_name = c("sex", "education_phase"),
    filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_is_filter(meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_is_filter(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when no filter groups are defined in meta", {
  meta <- data.frame(
    col_name = c("sex", "education_phase"),
    filter_grouping_column = "")
  expect_equal(check_meta_filter_group_is_filter(meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_is_filter(meta, stop_on_error = TRUE))
  expect_no_error(check_meta_filter_group_is_filter(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("ignores empty or NA filter_grouping_column values", {
  meta <- data.frame(
    col_name = c("sex", "education_phase", "ethnicity"),
    filter_grouping_column = c("sex", "", NA))
  expect_equal(check_meta_filter_group_is_filter(meta)$result, "PASS")
})

test_that("warns when one filter group is missing from data", {
  meta <- data.frame(
    col_name = "sex",
    filter_grouping_column = c("sex", "education_phase"))
  expect_equal(check_meta_filter_group_is_filter(meta)$result, "WARNING")
  expect_warning(check_meta_filter_group_is_filter(meta, stop_on_error = TRUE))
  expect_warning(check_meta_filter_group_is_filter(
    example_filter_group_meta,
    stop_on_error = TRUE
  ))
})

test_that("warns when multiple filter groups are missing from data", {
  meta <- data.frame(
    col_name = c("education_phase", "age_group", "sen_provision"),
    filter_grouping_column = c("sex", "education_phase", "ethnicity"))
  expect_equal(check_meta_filter_group_is_filter(meta)$result, "WARNING")
  expect_warning(check_meta_filter_group_is_filter(meta, stop_on_error = TRUE))
})
