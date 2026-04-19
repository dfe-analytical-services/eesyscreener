# These are effectively integration tests, throwing CSVs at the whole
# package to ensure that the screening process works as expected on
# known and tested test data, this should be used to capture any edge
# cases or odd behaviour and ensure the logic runs smoothly on real data.
#

## Run the tests --------------------------------------------------------------
test_that("All fail-data files return passed = FALSE", {
  skip_if(
    identical(Sys.getenv("SKIP_INTEGRATION_TESTS"), "true"),
    "Set SKIP_INTEGRATION_TESTS=false or unset to run integration tests"
  )
  skip_if(!dir.exists(test_path("fail-data")))
  screen_local_folder("fail-data", expected_passed = FALSE)
})

test_that("All pass-data files return passed = TRUE", {
  skip_if(
    identical(Sys.getenv("SKIP_INTEGRATION_TESTS"), "true"),
    "Set SKIP_INTEGRATION_TESTS=false or unset to run integration tests"
  )
  skip_if(!dir.exists(test_path("pass-data")))
  screen_local_folder("pass-data", expected_passed = TRUE)
})

test_that("All files in not-api-data return passed = TRUE and api_suitable = FALSE", {
  skip_if(
    identical(Sys.getenv("SKIP_INTEGRATION_TESTS"), "true"),
    "Set SKIP_INTEGRATION_TESTS=false or unset to run integration tests"
  )
  skip_if(!dir.exists(test_path("not-api-data")))
  screen_local_folder(
    "not-api-data",
    expected_passed = TRUE,
    expected_api_suitable = FALSE
  )
})
