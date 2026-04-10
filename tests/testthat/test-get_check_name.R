test_that("get_check_name strips check_ prefix", {
  check_example <- function() get_check_name()
  expect_equal(check_example(), "example")
})

test_that("get_check_name strips precheck_ prefix", {
  precheck_example <- function() get_check_name()
  expect_equal(precheck_example(), "example")
})

test_that("get_check_name handles multi-part names", {
  check_meta_fil_grp <- function() get_check_name()
  expect_equal(check_meta_fil_grp(), "meta_fil_grp")
})
