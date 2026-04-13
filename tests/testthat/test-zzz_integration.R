# Intentionally running these last as they will take the longest to run.
# These are effectively integration tests, throwing CSVs as the whole
# package to ensure that the screening process works as expected.
#
# These tests are skipped by default. To run them locally, use:
#   withr::with_envvar(
#     c(RUN_INTEGRATION_TESTS = "true"),
#     devtools::test(filter = "zzz_integration")
#   )
test_that("Check file_validation files all fail screening", {
  skip_on_cran()
  skip_on_ci()
  skip_if(
    Sys.getenv("RUN_INTEGRATION_TESTS") != "true",
    message = "Set RUN_INTEGRATION_TESTS=true to run integration tests"
  )
  skip_if_offline()

  api_url <- paste0(
    "https://api.github.com/repos/dfe-analytical-services/",
    "dfe-published-data-qa/contents/tests/testthat/fileValidation"
  )
  base_url <- paste0(
    "https://raw.githubusercontent.com/dfe-analytical-services/",
    "dfe-published-data-qa/refs/heads/main/tests/testthat/fileValidation/"
  )

  all_files <- jsonlite::fromJSON(api_url)$name
  data_files <- all_files[
    grepl("\\.csv$", all_files) & !grepl("\\.meta\\.", all_files)
  ]

  test_dir <- tempdir()

  for (filename in data_files) {
    stem <- sub("\\.csv$", "", filename)
    meta_matches <- all_files[grepl(paste0("^", stem, "\\.meta\\."), all_files)]
    meta_filename <- if (length(meta_matches) > 0) meta_matches[1] else paste0(stem, ".meta.csv")

    data_path <- file.path(test_dir, filename)
    meta_path <- file.path(test_dir, meta_filename)

    download.file(paste0(base_url, utils::URLencode(filename, reserved = TRUE)), data_path, quiet = TRUE, mode = "wb")
    if (length(meta_matches) > 0) {
      download.file(paste0(base_url, utils::URLencode(meta_filename, reserved = TRUE)), meta_path, quiet = TRUE, mode = "wb")
    }

    screener_output <- expect_no_error(screen_csv(data_path, meta_path))
    expect_false(screener_output$passed, label = paste("passed is FALSE for", filename))

    file.remove(data_path)
    if (file.exists(meta_path)) file.remove(meta_path)
  }
})
