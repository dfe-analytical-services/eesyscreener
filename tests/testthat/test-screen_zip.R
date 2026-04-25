test_that("passes for valid single-pair ZIP", {
  skip_integration_tests()

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv")
    ),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  zip_fixture(d$zippath, expected_passed = TRUE, expected_api_suitable = TRUE)
})

test_that("passes for valid multi-pair ZIP with names file", {
  skip_integration_tests()

  names_file <- tempfile()
  on.exit(unlink(names_file))
  writeLines(
    names_file_lines(c("passes_everything", "noFilters")),
    names_file
  )

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv"),
      pass_file("noFilters"),
      pass_file("noFilters", ".meta.csv"),
      names_file
    ),
    names_in_zip = c(
      "passes_everything.csv",
      "passes_everything.meta.csv",
      "noFilters.csv",
      "noFilters.meta.csv",
      "dataset_names.csv"
    )
  )
  on.exit(
    {
      unlink(d$zippath)
      unlink(d$staging, recursive = TRUE)
    },
    add = TRUE
  )

  result <- zip_fixture(d$zippath, expected_passed = TRUE)
  pair_names <- setdiff(names(result), "zip_structure")
  expect_equal(length(pair_names), 2)
  expect_true("passes_everything" %in% names(result))
  expect_true("noFilters" %in% names(result))
})

test_that("fails early when ZIP is unreadable", {
  skip_integration_tests()
  corrupt <- tempfile(fileext = ".zip")
  on.exit(unlink(corrupt))
  writeBin(as.raw(c(0x50, 0x4B, 0x00, 0x00)), corrupt)

  result <- screen_zip(corrupt)

  expect_true(any(result$zip_structure$result == "FAIL"))
  expect_equal(length(setdiff(names(result), "zip_structure")), 0)
})

test_that("fails early when ZIP has nested structure", {
  skip_integration_tests()

  staging <- tempfile()
  dir.create(staging)
  subdir <- file.path(staging, "subdir")
  dir.create(subdir)
  file.copy(
    pass_file("passes_everything"),
    file.path(subdir, "passes_everything.csv")
  )
  file.copy(
    pass_file("passes_everything", ".meta.csv"),
    file.path(subdir, "passes_everything.meta.csv")
  )

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

  result <- screen_zip(zippath)

  flat_row <- result$zip_structure[
    result$zip_structure$check == "zip_flat_structure",
  ]
  expect_equal(flat_row$result, "FAIL")
  expect_equal(length(setdiff(names(result), "zip_structure")), 0)
})

test_that("fails when multi-pair ZIP has no names file", {
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

  result <- screen_zip(d$zippath)

  presence_row <- result$zip_structure[
    result$zip_structure$check == "zip_names_file_presence",
  ]
  expect_equal(presence_row$result, "FAIL")
})

test_that("screens all pairs even when some fail", {
  skip_integration_tests()

  names_file <- tempfile()
  on.exit(unlink(names_file))
  writeLines(
    names_file_lines(c("passes_everything", "noFilters")),
    names_file
  )

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv"),
      pass_file("noFilters"),
      pass_file("noFilters", ".meta.csv"),
      names_file
    ),
    names_in_zip = c(
      "passes_everything.csv",
      "passes_everything.meta.csv",
      "noFilters.csv",
      "noFilters.meta.csv",
      "dataset_names.csv"
    )
  )
  on.exit(
    {
      unlink(d$zippath)
      unlink(d$staging, recursive = TRUE)
    },
    add = TRUE
  )

  result <- screen_zip(d$zippath)

  expect_equal(length(setdiff(names(result), "zip_structure")), 2)
})

test_that("returns correct structure fields", {
  skip_integration_tests()

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv")
    ),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip(d$zippath)

  expect_true("zip_structure" %in% names(result))
  expect_true(is.data.frame(result$zip_structure))
  expect_true(
    all(
      c("check", "result", "message", "guidance_url", "stage") %in%
        names(result$zip_structure)
    )
  )

  pair_names <- setdiff(names(result), "zip_structure")
  expect_true(length(pair_names) > 0)
  expect_true(all(vapply(result[pair_names], is.list, logical(1))))
})

test_that("failing pair has passed == FALSE", {
  skip_integration_tests()

  fail_files <- list.files(
    test_path("fail"),
    pattern = "\\.csv$",
    full.names = FALSE
  )
  fail_files <- fail_files[!grepl("\\.meta\\.", fail_files)]

  if (length(fail_files) == 0) {
    skip("No fail fixtures found")
  }

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

  expect_false(result[[stem]]$passed)
  expect_true(all(result$zip_structure$result == "PASS"))
})

test_that("all pairs have passed == TRUE when all pairs pass", {
  skip_integration_tests()

  d <- make_zip(
    files = c(
      pass_file("passes_everything"),
      pass_file("passes_everything", ".meta.csv")
    ),
    names_in_zip = c("passes_everything.csv", "passes_everything.meta.csv")
  )
  on.exit({
    unlink(d$zippath)
    unlink(d$staging, recursive = TRUE)
  })

  result <- screen_zip(d$zippath)

  pair_names <- setdiff(names(result), "zip_structure")
  expect_true(all(vapply(result[pair_names], function(r) r$passed, logical(1))))
})

test_that("path-traversal entry is rejected by flat structure check", {
  skip_integration_tests()

  # Build a ZIP whose entry name contains '..' by rooting zip() in a subdir
  staging <- tempfile()
  subdir <- file.path(staging, "sub")
  dir.create(subdir, recursive = TRUE)
  writeLines("x", file.path(staging, "escape.csv"))

  zippath <- tempfile(fileext = ".zip")
  suppressWarnings(zip::zip(zippath, files = "../escape.csv", root = subdir))
  on.exit({
    unlink(zippath)
    unlink(staging, recursive = TRUE)
  })

  result <- screen_zip(zippath)

  flat_row <- result$zip_structure[
    result$zip_structure$check == "zip_flat_structure",
  ]
  expect_equal(flat_row$result, "FAIL")
  expect_equal(length(setdiff(names(result), "zip_structure")), 0)
})

test_that("ZIP with only dataset_names.csv and no pairs fails pairs check", {
  skip_integration_tests()

  names_file <- tempfile()
  on.exit(unlink(names_file))
  writeLines(names_file_lines("mydata"), names_file)

  d <- make_zip(
    files = names_file,
    names_in_zip = "dataset_names.csv"
  )
  on.exit(
    {
      unlink(d$zippath)
      unlink(d$staging, recursive = TRUE)
    },
    add = TRUE
  )

  result <- screen_zip(d$zippath)

  pairs_row <- result$zip_structure[
    result$zip_structure$check == "zip_pairs",
  ]
  expect_equal(pairs_row$result, "FAIL")
  expect_true(grepl("mydata.csv", pairs_row$message, fixed = TRUE))
  expect_true(grepl("mydata.meta.csv", pairs_row$message, fixed = TRUE))
  expect_equal(length(setdiff(names(result), "zip_structure")), 0)
})
