test_that("passes when all labels are unique", {
  meta <- data.frame(label = c("A", "B", "C"))
  expect_equal(precheck_meta_duplicate_label(meta)$result, "PASS")
  expect_no_error(precheck_meta_duplicate_label(meta, stop_on_error = TRUE))
  expect_no_error(precheck_meta_duplicate_label(example_meta, stop_on_error = TRUE))
})

test_that("fails with one duplicate label", {
  meta <- data.frame(label = c("A", "B", "A"))
  expect_equal(precheck_meta_duplicate_label(meta)$result, "FAIL")
  expect_error(precheck_meta_duplicate_label(meta, stop_on_error = TRUE))
})

test_that("fails with multiple duplicate labels", {
  meta <- data.frame(label = c("A", "B", "A", "B"))
  expect_equal(precheck_meta_duplicate_label(meta)$result, "FAIL")
  expect_error(precheck_meta_duplicate_label(meta, stop_on_error = TRUE))
})

test_that("handles numeric values in label", {
  meta <- data.frame(label = c(1:3))
  expect_equal(precheck_meta_duplicate_label(meta)$result, "PASS")
  expect_no_error(precheck_meta_duplicate_label(meta, stop_on_error = TRUE))

  meta2 <- data.frame(label = c(1, 2, 1))
  expect_equal(precheck_meta_duplicate_label(meta2)$result, "FAIL")
  expect_error(precheck_meta_duplicate_label(meta2, stop_on_error = TRUE))
})

