# These are effectively integration tests, throwing CSVs at the whole
# package to ensure that the screening process works as expected on
# known and tested test data, this should be used to capture any edge
# cases or odd behaviour and ensure the logic runs smoothly on real data.
#

# Integration tests: these run by default.
# To skip, set SKIP_INTEGRATION_TESTS=true in your environment.
skip_if(
  identical(Sys.getenv("SKIP_INTEGRATION_TESTS"), "true"),
  "Set SKIP_INTEGRATION_TESTS=false or unset to run integration tests"
)

# Helper: screens all data/meta CSV pairs in a local folder.
# expected_result = TRUE  -> assert passed == TRUE  (file should pass screening)
# expected_result = FALSE -> assert passed == FALSE (file should fail screening)
screen_local_folder <- function(folder, expected_result = NULL) {
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

    if (is.null(expected_result)) {
      expect_true(
        is.logical(screener_output$passed),
        label = paste("passed is a single logical value for", filename)
      )
    } else {
      expect_equal(
        screener_output$passed,
        expected_result,
        label = paste("passed ==", expected_result, "for", filename)
      )
    }
  }
}


test_that("All fail-data files return passed = FALSE", {
  skip_if(!dir.exists(test_path("fail-data")))
  screen_local_folder("fail-data", expected_result = FALSE)
})

test_that("All pass-data files return passed = TRUE", {
  skip_if(!dir.exists(test_path("pass-data")))
  screen_local_folder("pass-data", expected_result = TRUE)
})
