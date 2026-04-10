test_that("passes when there are no values in the filter_grouping_column", {
  meta <- data.frame(
    filter_grouping_column = c(NA, NA)
  )
  expect_equal(check_meta_fil_grp_dupe(meta)$result, "PASS")
  expect_no_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_fil_grp_dupe(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when values in filter_grouping_column are unique", {
  meta <- data.frame(
    filter_grouping_column = c("sex", "ethnicity")
  )
  expect_equal(check_meta_fil_grp_dupe(meta)$result, "PASS")
  expect_no_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when filter_grouping_column has empty strings", {
  meta <- data.frame(
    filter_grouping_column = c("", "", "")
  )
  expect_equal(check_meta_fil_grp_dupe(meta)$result, "PASS")
  expect_no_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when there are duplicate values in filter_grouping_column", {
  meta <- data.frame(
    filter_grouping_column = c("sex", "sex")
  )
  result <- check_meta_fil_grp_dupe(meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex")
  expect_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails with multiple duplicate values in filter_grouping_column", {
  meta <- data.frame(
    filter_grouping_column = c("sex", "sex", "ethnicity", "ethnicity")
  )
  result <- check_meta_fil_grp_dupe(meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex")
  expect_match(result$message, "ethnicity")
  expect_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("ignores NAs and empty strings when checking for duplicates", {
  meta <- data.frame(
    filter_grouping_column = c("sex", NA, "", "ethnicity", NA, "")
  )
  expect_equal(check_meta_fil_grp_dupe(meta)$result, "PASS")
  expect_no_error(check_meta_fil_grp_dupe(
    meta,
    stop_on_error = TRUE
  ))
})
