test_that("passes when all time_identifier values are compatible", {
  data <- data.frame(
    time_identifier = rep(eesyscreener::acceptable_time_ids[[1]], 3)
  )
  expect_equal(precheck_time_id_mix(data)$result, "PASS")
  expect_no_error(precheck_time_id_mix(data, stop_on_error = TRUE))
})

test_that("passes when multiple compatible time_identifier values are present", {
  group <- eesyscreener::acceptable_time_ids[[1]]
  data <- data.frame(time_identifier = group)
  expect_equal(precheck_time_id_mix(data)$result, "PASS")
  expect_no_error(precheck_time_id_mix(data, stop_on_error = TRUE))
})

test_that("fails when incompatible time_identifier values are mixed", {
  # Mix values from two different groups
  group1 <- eesyscreener::acceptable_time_ids[[1]][1]
  group2 <- eesyscreener::acceptable_time_ids[[2]][1]
  data <- data.frame(time_identifier = c(group1, group2))
  expect_equal(precheck_time_id_mix(data)$result, "FAIL")
  expect_error(
    precheck_time_id_mix(data, stop_on_error = TRUE),
    "mixing incompatible time identifiers"
  )
})

test_that("passes with a single time_identifier value", {
  data <- data.frame(
    time_identifier = eesyscreener::acceptable_time_ids[[1]][1]
  )
  expect_equal(precheck_time_id_mix(data)$result, "PASS")
})

test_that("fails when time_identifier is not in any group", {
  data <- data.frame(
    time_identifier = c(
      "NotARealTimeID",
      eesyscreener::acceptable_time_ids[[1]][1]
    )
  )
  expect_equal(precheck_time_id_mix(data)$result, "FAIL")
  expect_error(
    precheck_time_id_mix(data, stop_on_error = TRUE),
    "mixing incompatible time identifiers"
  )
})

test_that("handles NA time_identifier values", {
  data <- data.frame(
    time_identifier = c(NA, eesyscreener::acceptable_time_ids[[1]][1])
  )
  expect_equal(precheck_time_id_mix(data)$result, "FAIL")
  expect_error(
    precheck_time_id_mix(data, stop_on_error = TRUE),
    "mixing incompatible time identifiers"
  )
})
