test_that("list_checks() returns a data.frame with correct columns", {
  result <- list_checks(output = "data.frame")

  expect_s3_class(result, "data.frame")
  expect_named(result, c("function_name", "title", "stage"))
})

test_that("list_checks() covers all exported check/precheck functions", {
  result <- list_checks(output = "data.frame")

  namespace_lines <- readLines(system.file(
    "NAMESPACE",
    package = "eesyscreener"
  ))
  exported <- gsub(
    "^export\\((.+)\\)$",
    "\\1",
    grep("^export\\(", namespace_lines, value = TRUE)
  )
  check_fns <- exported[grepl("^(check|precheck)_", exported)]

  missing <- setdiff(check_fns, result$function_name)

  expect_equal(
    missing,
    character(0),
    info = paste(
      "Exported check/precheck functions not found in list_checks() output:",
      paste(missing, collapse = ", ")
    )
  )
})

test_that("list_checks() has no NA titles", {
  result <- list_checks(output = "data.frame")

  na_fns <- result$function_name[is.na(result$title)]

  expect_equal(
    na_fns,
    character(0),
    info = paste(
      "Functions with no Rd title found:",
      paste(na_fns, collapse = ", ")
    )
  )
})

test_that("list_checks() returns invisibly when output = 'print'", {
  expect_invisible(list_checks(output = "print"))
})
