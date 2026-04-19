skip_integration_tests <- function() {
  skip_on_cran()
  skip_if(
    identical(Sys.getenv("SKIP_INTEGRATION_TESTS"), "true"),
    "Set SKIP_INTEGRATION_TESTS=false or unset to run integration tests"
  )
}

# Helper: screens all data/meta CSV pairs in a local folder.
# expected_passed       = TRUE/FALSE -> asserts screener_output$passed
# expected_api_suitable = TRUE/FALSE -> asserts screener_output$api_suitable
# (optional)
screen_local_folder <- function(
  folder,
  expected_passed,
  expected_api_suitable = NULL
) {
  folder_path <- test_path(folder)

  all_files <- list.files(folder_path)
  data_files <- all_files[
    grepl("\\.csv$", all_files) & !grepl("\\.meta\\.", all_files)
  ]

  if (length(data_files) == 0) {
    skip(paste("No CSV files found in", folder))
  }

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
      expected_passed,
      label = paste("passed ==", expected_passed, "for", filename)
    )

    if (!is.null(expected_api_suitable)) {
      expect_equal(
        screener_output$api_suitable,
        expected_api_suitable,
        label = paste("api_suitable ==", expected_api_suitable, "for", filename)
      )
    }
  }
}
