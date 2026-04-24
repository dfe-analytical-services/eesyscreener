test_that("passes for valid single-pair ZIP", {
  skip_integration_tests()

  d <- make_zip(
    files = c(pass_file("passes_everything"), pass_file("passes_everything", ".meta.csv")),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  screen_zip_fixture(d$zippath, expected_passed = TRUE, expected_api_suitable = TRUE)
})

test_that("passes for valid multi-pair ZIP with manifest", {
  skip_integration_tests()

  manifest <- tempfile()
  on.exit(unlink(manifest))
  writeLines(
    manifest_lines(c("passes_everything", "noFilters")),
    manifest
  )

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv"),
      pass_file("noFilters"),
      pass_file("noFilters", ".meta.csv"),
      manifest
    ),
    names_in_zip = c(
      "passes_everything.csv",
      "passes_everything.meta.csv",
      "noFilters.csv",
      "noFilters.meta.csv",
      "dataset_names.csv"
    )
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  }, add = TRUE)

  result <- screen_zip_fixture(d$zippath, expected_passed = TRUE)
  expect_equal(length(result$pair_results), 2)
  expect_true("passes_everything" %in% names(result$pair_results))
  expect_true("noFilters" %in% names(result$pair_results))
})

test_that("fails early when ZIP structure is invalid", {
  corrupt <- tempfile(fileext = ".zip")
  on.exit(unlink(corrupt))
  writeBin(as.raw(c(0x50, 0x4B, 0x00, 0x00)), corrupt)

  result <- screen_zip(corrupt)

  expect_false(result$passed)
  expect_equal(result$overall_stage, "ZIP structure")
  expect_equal(length(result$pair_results), 0)
})

test_that("screens all pairs even when some fail", {
  skip_integration_tests()

  manifest <- tempfile()
  on.exit(unlink(manifest))
  writeLines(
    manifest_lines(c("passes_everything", "noFilters")),
    manifest
  )

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv"),
      pass_file("noFilters"),
      pass_file("noFilters", ".meta.csv"),
      manifest
    ),
    names_in_zip = c(
      "passes_everything.csv",
      "passes_everything.meta.csv",
      "noFilters.csv",
      "noFilters.meta.csv",
      "dataset_names.csv"
    )
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  }, add = TRUE)

  result <- screen_zip(d$zippath)

  # All pairs were screened regardless of outcome
  expect_equal(length(result$pair_results), 2)
})

test_that("returns correct structure fields", {
  skip_integration_tests()

  d <- make_zip(
    files = c(pass_file("passes_everything"), pass_file("passes_everything", ".meta.csv")),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip(d$zippath)

  expect_true(all(c(
    "structure_results", "pair_results", "overall_stage", "passed", "api_suitable"
  ) %in% names(result)))

  expect_true(is.data.frame(result$structure_results))
  expect_true(is.list(result$pair_results))
  expect_true(is.character(result$overall_stage))
  expect_true(is.logical(result$passed))
  expect_true(is.logical(result$api_suitable))
})

test_that("failing pair sets overall_stage from that pair's stage", {
  skip_integration_tests()

  # Use a file from the fail/ directory
  fail_files <- list.files(test_path("fail"), pattern = "\\.csv$", full.names = FALSE)
  fail_files <- fail_files[!grepl("\\.meta\\.", fail_files)]

  if (length(fail_files) == 0) skip("No fail fixtures found")

  stem <- sub("\\.csv$", "", fail_files[[1]])

  d <- make_zip(
    files = c(fail_file(stem), fail_file(stem, ".meta.csv")),
    names_in_zip = c(paste0(stem, ".csv"), paste0(stem, ".meta.csv"))
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip(d$zippath)

  expect_false(result$passed)
  expect_false(result$overall_stage == "ZIP structure")
})

test_that("overall_stage is Passed when all pairs pass", {
  skip_integration_tests()

  d <- make_zip(
    files = c(pass_file("passes_everything"), pass_file("passes_everything", ".meta.csv")),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip(d$zippath)

  expect_equal(result$overall_stage, "Passed")
})
