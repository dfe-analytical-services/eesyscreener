test_that("passes when all valid", {
  expect_no_error(precheck_meta_ob_unit(example_meta, output = "error-only"))

  meta <- data.frame(col_name = c("Not", "A", "Observational", "Unit"))
  expect_equal(precheck_meta_ob_unit(meta, output = "table")$result, "PASS")
})

test_that("fails with one invalid value", {
  meta <- data.frame(col_name = c("Good", "geographic_level", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta, output = "table")$result, "FAIL")
  expect_error(precheck_meta_ob_unit(meta))
})

test_that("fails with multiple invalid values", {
  meta <- data.frame(col_name = c("Good", "geographic_level", "pcon_code"))
  expect_equal(precheck_meta_ob_unit(meta, output = "table")$result, "FAIL")
})

test_that("passed with provider_name", {
  meta <- data.frame(col_name = c("provider_name", "Bad", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta, output = "table")$result, "PASS")
})

test_that("passes with school_name", {
  meta <- data.frame(col_name = c("Good", "school_name", "Ugly"))
  expect_equal(precheck_meta_ob_unit(meta, output = "table")$result, "PASS")
})
