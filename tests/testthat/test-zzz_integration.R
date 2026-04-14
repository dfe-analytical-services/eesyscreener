# These are effectively integration tests, throwing CSVs as the whole
# package to ensure that the screening process works as expected.
#
# Before running these tests, populate the test data directories by sourcing:
#   source("tests/utils/download_integration_data.R")
#
# Then run the tests with:
#   withr::with_envvar(
#     c(RUN_INTEGRATION_TESTS = "true"),
#     devtools::test(filter = "zzz_integration")
#   )

# Helper: screens all data/meta CSV pairs in a local folder.
# expected_result = TRUE  -> assert passed == TRUE  (file should pass screening)
# expected_result = FALSE -> assert passed == FALSE (file should fail screening)
screen_local_folder <- function(folder, expected_result) {
  folder_path <- test_path(folder)

  all_files <- list.files(folder_path)
  data_files <- all_files[
    grepl("\\.csv$", all_files) & !grepl("\\.meta\\.", all_files)
  ]

  for (filename in data_files) {
    stem <- sub("\\.csv$", "", filename)
    meta_matches <- all_files[grepl(paste0("^", stem, "\\.meta\\."), all_files)]
    meta_filename <- if (length(meta_matches) > 0) {
      meta_matches[1]
    } else {
      paste0(stem, ".meta.csv")
    }

    data_path <- file.path(folder_path, filename)
    meta_path <- file.path(folder_path, meta_filename)

    screener_output <- expect_no_error(screen_csv(data_path, meta_path))

    expect_equal(
      screener_output$passed,
      expected_result,
      label = paste("passed ==", expected_result, "for", filename)
    )
  }
}

integration_skip_conditions <- function() {
  skip_on_cran()
  skip_on_ci()
  skip_if(
    Sys.getenv("RUN_INTEGRATION_TESTS") != "true",
    message = "Set RUN_INTEGRATION_TESTS=true to run integration tests"
  )
  skip_if_offline()
}

test_that("All fail-data files return passed = FALSE", {
  integration_skip_conditions()
  skip_if(!dir.exists(test_path("fail-data")))
  #screen_local_folder("fail-data", expected_result = FALSE) # TODO sift through issues here
  screen_local_folder("sifted-fail-data", expected_result = FALSE)
})

test_that("All pass-data files return passed = TRUE", {
  integration_skip_conditions()
  skip_if(!dir.exists(test_path("pass-data")))
  screen_local_folder("pass-data", expected_result = TRUE)
  screen_local_folder("sifted-pass-data", expected_result = TRUE)
})
