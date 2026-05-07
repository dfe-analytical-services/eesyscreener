# Builds ZIP fixtures programmatically at test-runtime from the existing
# pass/ and fail/ CSV pairs. No binary ZIPs are committed to the repo.

# Helper: build a ZIP fixture and return its path.
# The caller is responsible for cleanup (use withr::defer or on.exit).
make_zip <- function(files, names_in_zip = NULL) {
  if (is.null(names_in_zip)) {
    names_in_zip <- basename(files)
  }

  staging <- tempfile()
  dir.create(staging)
  for (i in seq_along(files)) {
    file.copy(files[[i]], file.path(staging, names_in_zip[[i]]))
  }

  zippath <- tempfile(fileext = ".zip")
  zip::zip(zippath, files = names_in_zip, root = staging)
  list(zippath = zippath, staging = staging)
}

# Helper: build a valid dataset_names.csv names file as a character vector.
names_file_lines <- function(stems, names = stems) {
  c("file_name,dataset_name", paste0(stems, ",", names))
}

# Helper: resolves a path inside tests/testthat/pass/ or fail/
pass_file <- function(stem, ext = ".csv") {
  test_path("pass", paste0(stem, ext))
}

fail_file <- function(stem, ext = ".csv") {
  test_path("fail", paste0(stem, ext))
}

# Helper: create an empty ZIP at a temp path and return the path.
# Caller is responsible for cleanup via on.exit(unlink(tmp)).
with_empty_zip <- function(ext = ".zip") {
  tmp <- tempfile(fileext = ext)
  zip::zip(tmp, character(0))
  tmp
}

# Helper: assert screen_zip() result matches expectations.
zip_fixture <- function(
  zippath,
  expected_passed,
  expected_api_suitable = NULL
) {
  result <- expect_no_error(screen_zip(zippath))

  pair_names <- setdiff(names(result), "zip_structure")

  if (length(pair_names) > 0) {
    all_passed <- all(vapply(
      result[pair_names],
      function(r) r$passed,
      logical(1)
    ))
  } else {
    all_passed <- FALSE
  }

  expect_equal(
    all_passed,
    expected_passed,
    label = paste("passed ==", expected_passed)
  )

  if (!is.null(expected_api_suitable)) {
    if (length(pair_names) > 0) {
      all_api <- all(vapply(
        result[pair_names],
        function(r) r$api_suitable,
        logical(1)
      ))
    } else {
      all_api <- FALSE
    }
    expect_equal(
      all_api,
      expected_api_suitable,
      label = paste("api_suitable ==", expected_api_suitable)
    )
  }

  result
}
