test_that("passes when indicators have acceptable indicator unit values", {
  meta <- data.frame(
    col_type = c("Indicator"),
    indicator_unit = c("%", "pp", "£", "£m", "numberstring")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "PASS")
  expect_no_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when indicator unit values are blank or NA", {
  meta <- data.frame(
    col_type = c("Indicator"),
    indicator_unit = c("", NA, "")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "PASS")
  expect_no_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
  expect_no_error(check_meta_indicator_unit_validation(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when only units in indicator columns are acceptable values", {
  meta <- data.frame(
    col_type = c("Filter", "Indicator"),
    indicator_unit = c(" ", "£")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "PASS")
  expect_no_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when one indicator unit is not an acceptable unit value", {
  meta <- data.frame(
    col_type = c("Indicator"),
    indicator_unit = c("", "£", "$")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "FAIL")
  expect_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when multiple indicator units are not an acceptable unit values", {
  meta <- data.frame(
    col_type = c("Indicator"),
    indicator_unit = c("E", "#", "$")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "FAIL")
  expect_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
})

test_that("passes when only units in filter columns are acceptable values", {
  meta <- data.frame(
    col_type = c("Filter", "Indicator"),
    indicator_unit = c("", "$")
  )
  expect_equal(check_meta_indicator_unit_validation(meta)$result, "FAIL")
  expect_error(check_meta_indicator_unit_validation(
    meta,
    stop_on_error = TRUE
  ))
})
