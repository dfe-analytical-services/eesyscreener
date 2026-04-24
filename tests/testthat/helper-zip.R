# Builds ZIP fixtures programmatically at test-runtime from the existing
# pass/ and fail/ CSV pairs. No binary ZIPs are committed to the repo.

# Helper: build a ZIP fixture and return its path.
# The caller is responsible for cleanup (use withr::defer or on.exit).
make_zip <- function(files, names_in_zip = NULL, extra_files = list()) {
  if (is.null(names_in_zip)) {
    names_in_zip <- basename(files)
  }

  staging <- tempfile()
  dir.create(staging)
  for (i in seq_along(files)) {
    file.copy(files[[i]], file.path(staging, names_in_zip[[i]]))
  }

  if (length(extra_files) > 0) {
    for (nm in names(extra_files)) {
      writeLines(extra_files[[nm]], file.path(staging, nm))
    }
  }

  zippath <- tempfile(fileext = ".zip")
  zip::zip(zippath, files = names_in_zip, root = staging)
  list(zippath = zippath, staging = staging)
}

# Helper: build a valid dataset_names.csv manifest as a character vector.
manifest_lines <- function(stems, names = stems) {
  c("file_name,dataset_name", paste0(stems, ",", names))
}

# Helper: resolves a path inside tests/testthat/pass/ or fail/
pass_file <- function(stem, ext = ".csv") {
  test_path("pass", paste0(stem, ext))
}

fail_file <- function(stem, ext = ".csv") {
  test_path("fail", paste0(stem, ext))
}

# Helper: assert screen_zip() result matches expectations, mirrors
# screen_local_folder() from helper-integration.R.
screen_zip_fixture <- function(
  zippath,
  expected_passed,
  expected_api_suitable = NULL
) {
  result <- expect_no_error(screen_zip(zippath))

  expect_equal(
    result$passed,
    expected_passed,
    label = paste("passed ==", expected_passed)
  )

  if (!is.null(expected_api_suitable)) {
    expect_equal(
      result$api_suitable,
      expected_api_suitable,
      label = paste("api_suitable ==", expected_api_suitable)
    )
  }

  result
}
