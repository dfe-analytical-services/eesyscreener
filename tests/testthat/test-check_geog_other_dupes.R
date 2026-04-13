test_that("passes with package example data (no lower-level geographies)", {
  result <- check_geog_other_dupes(example_data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "not present")
})

# PASS cases ==================================================================

test_that("passes when no lower-level geography levels are present", {
  data <- data.frame(geographic_level = c("National", "Regional"))
  expect_equal(check_geog_other_dupes(data)$result, "PASS")
})

test_that("passes when opportunity area names have clean 1:1 code mapping", {
  data <- data.frame(
    geographic_level = c("Opportunity area", "Opportunity area"),
    opportunity_area_code = c("OA001", "OA002"),
    opportunity_area_name = c("Area One", "Area Two")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "Every geography has one code")
})

test_that("passes when MAT names have clean 1:1 mapping to codes", {
  data <- data.frame(
    geographic_level = c("MAT", "MAT"),
    trust_id = c("T001", "T002"),
    trust_name = c("Trust Alpha", "Trust Beta")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "Every geography has one code")
})

test_that("passes when Sponsor names have clean 1:1 mapping to codes", {
  data <- data.frame(
    geographic_level = c("Sponsor", "Sponsor"),
    sponsor_id = c("SP001", "SP002"),
    sponsor_name = c("Sponsor Alpha", "Sponsor Beta")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "Every geography has one code")
})

test_that("passes when same name-code pair appears in multiple rows", {
  data <- data.frame(
    geographic_level = c("MAT", "MAT"),
    trust_id = c("T001", "T001"),
    trust_name = c("Trust Alpha", "Trust Alpha")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "Every geography has one code")
})

# FAIL cases ==================================================================

test_that("fails when one opportunity area name has multiple codes", {
  data <- data.frame(
    geographic_level = c("Opportunity area", "Opportunity area"),
    opportunity_area_code = c("OA001", "OA002"),
    opportunity_area_name = c("Area One", "Area One")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "^The following geography has multiple codes")
  expect_match(result$message, "Area One")
})

test_that("fails when multiple geographies have multiple codes (plural)", {
  data <- data.frame(
    geographic_level = c("MAT", "MAT", "MAT", "MAT"),
    trust_id = c("T001", "T002", "T003", "T004"),
    trust_name = c("Trust Alpha", "Trust Alpha", "Trust Beta", "Trust Beta")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "geographies have multiple codes")
  expect_match(result$message, "Trust Alpha")
  expect_match(result$message, "Trust Beta")
})

test_that("fails with stop_on_error = TRUE", {
  data <- data.frame(
    geographic_level = c("Sponsor", "Sponsor"),
    sponsor_id = c("SP001", "SP002"),
    sponsor_name = c("Sponsor Alpha", "Sponsor Alpha")
  )
  expect_error(check_geog_other_dupes(data, stop_on_error = TRUE))
})

test_that("message includes count of codes when one name maps to 3 codes", {
  data <- data.frame(
    geographic_level = c(
      "Opportunity area",
      "Opportunity area",
      "Opportunity area"
    ),
    opportunity_area_code = c("OA001", "OA002", "OA003"),
    opportunity_area_name = c("Area One", "Area One", "Area One")
  )
  result <- check_geog_other_dupes(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "3 different codes")
})
