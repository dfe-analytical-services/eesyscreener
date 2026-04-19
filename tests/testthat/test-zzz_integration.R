# These are effectively integration tests, throwing CSVs at the whole
# package to ensure that the screening process works as expected on
# known and tested test data, this should be used to capture any edge
# cases or odd behaviour and ensure the logic runs smoothly on real data.

skip_integration_tests()

test_that("All fail files return passed = FALSE", {
  screen_local_folder("fail", expected_passed = FALSE)
})

test_that("All pass files return passed = TRUE", {
  screen_local_folder("pass", expected_passed = TRUE)
})

test_that("All files in pass-warn-api return passed = TRUE / api = FALSE", {
  screen_local_folder(
    "pass-warn-api",
    expected_passed = TRUE,
    expected_api_suitable = FALSE
  )
})
