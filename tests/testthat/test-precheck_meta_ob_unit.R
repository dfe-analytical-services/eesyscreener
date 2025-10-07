test_that("passes when all valid", {
  expect_no_error(precheck_meta_ob_unit(example_meta, stop_on_error = TRUE))

  meta <- data.frame(col_name = c("Not", "A", "Observational", "Unit"))
  expect_equal(precheck_meta_ob_unit(meta)$result, "PASS")
})

test_that("fails with one invalid value", {
  meta <- data.frame(col_name = c("Good", "geographic_level", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta)$result, "FAIL")
  expect_error(precheck_meta_ob_unit(meta, stop_on_error = TRUE))
})

test_that("fails with multiple invalid values", {
  meta <- data.frame(col_name = c("Good", "geographic_level", "pcon_code"))
  expect_equal(precheck_meta_ob_unit(meta)$result, "FAIL")
})

test_that("passed with provider_name", {
  meta <- data.frame(col_name = c("provider_name", "Bad", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta)$result, "PASS")
})

test_that("passes with school_name", {
  meta <- data.frame(col_name = c("Good", "school_name", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta)$result, "PASS")
})
