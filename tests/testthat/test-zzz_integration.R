# These are effectively integration tests, throwing CSVs at the whole
# package to ensure that the screening process works as expected on
# known and tested test data, this should be used to capture any edge
# cases or odd behaviour and ensure the logic runs smoothly on real data.

skip_integration_tests()

test_that("All fail-data files return passed = FALSE", {
  screen_local_folder("fail-data", expected_passed = FALSE)
})

test_that("All pass-data files return passed = TRUE", {
  screen_local_folder("pass-data", expected_passed = TRUE)
})

test_that("All files in not-api-data return passed = TRUE / api = FALSE", {
  screen_local_folder(
    "not-api-data",
    expected_passed = TRUE,
    expected_api_suitable = FALSE
  )
})
