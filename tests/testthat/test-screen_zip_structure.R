test_that("returns PASS for all checks on a valid single-pair ZIP", {
  skip_integration_tests()
  d <- make_zip(
    files = c(pass_file("passes_everything"), pass_file("passes_everything", ".meta.csv")),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip_structure(d$zippath)

  expect_true(is.data.frame(result))
  expect_true("stage" %in% names(result))
  expect_true(all(result$stage == "ZIP structure"))
  expect_true(all(result$result == "PASS"))
})

test_that("returns PASS for all checks on a valid multi-pair ZIP with manifest", {
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

  result <- screen_zip_structure(d$zippath)

  expect_true(all(result$result == "PASS"))
  expect_true(all(result$stage == "ZIP structure"))
})

test_that("returns early with single FAIL row when ZIP is unreadable", {
  corrupt <- tempfile(fileext = ".zip")
  on.exit(unlink(corrupt))
  writeBin(as.raw(c(0x50, 0x4B, 0x00, 0x00)), corrupt)

  result <- screen_zip_structure(corrupt)

  expect_equal(nrow(result), 1)
  expect_equal(result$result, "FAIL")
  expect_equal(result$check, "zip_readable")
})

test_that("fails flat_structure check for nested ZIP", {
  skip_integration_tests()
  staging <- tempfile()
  dir.create(staging)
  subdir <- file.path(staging, "subdir")
  dir.create(subdir)
  file.copy(pass_file("passes_everything"), file.path(subdir, "passes_everything.csv"))
  file.copy(pass_file("passes_everything", ".meta.csv"), file.path(subdir, "passes_everything.meta.csv"))

  zippath <- tempfile(fileext = ".zip")
  zip::zip(
    zippath,
    files = c(
      "subdir/passes_everything.csv",
      "subdir/passes_everything.meta.csv"
    ),
    root = staging
  )
  on.exit({
    unlink(zippath)
    unlink(staging, recursive = TRUE)
  })

  result <- screen_zip_structure(zippath)

  flat_row <- result[result$check == "zip_flat_structure", ]
  expect_equal(flat_row$result, "FAIL")
})

test_that("fails manifest_presence check for multi-pair ZIP without manifest", {
  skip_integration_tests()
  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv"),
      pass_file("noFilters"),
      pass_file("noFilters", ".meta.csv")
    ),
    names_in_zip = c(
      "passes_everything.csv",
      "passes_everything.meta.csv",
      "noFilters.csv",
      "noFilters.meta.csv"
    )
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip_structure(d$zippath)

  presence_row <- result[result$check == "zip_manifest_presence", ]
  expect_equal(presence_row$result, "FAIL")
})

test_that("result data frame has required columns", {
  skip_integration_tests()
  d <- make_zip(
    files = c(pass_file("passes_everything"), pass_file("passes_everything", ".meta.csv")),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip_structure(d$zippath)

  expect_true(all(c("check", "result", "message", "guidance_url", "stage") %in% names(result)))
})
