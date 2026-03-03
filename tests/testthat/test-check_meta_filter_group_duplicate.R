test_that("passes when there are no values in the filter_grouping_column", {
  meta <- data.frame(
    filter_grouping_column = c(NA, NA)
  )
  expect_equal(check_meta_filter_group_duplicate(meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_duplicate(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when there are duplicate values in filter_grouping_column", {
  meta <- data.frame(
    filter_grouping_column = c("sex", "sex")
  )
  expect_equal(check_meta_filter_group_duplicate(meta)$result, "FAIL")
  expect_error(check_meta_filter_group_duplicate(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when values in filter_grouping_column are unique", {
  meta <- data.frame(
    filter_grouping_column = c("sex", "ethnicity")
  )
  expect_equal(check_meta_filter_group_duplicate(meta)$result, "PASS")
  expect_no_error(check_meta_filter_group_duplicate(
    meta,
    stop_on_error = TRUE
  ))
})
