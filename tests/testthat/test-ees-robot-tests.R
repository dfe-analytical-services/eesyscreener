# Checking that the screener runs to completion on all robot tests
test_that("Check EES robot test files", {
  test_dir <- tempdir()
  for (robot in ees_robot_test_data) {
    test_dir = tempdir()
    paths <- write_ees_files(robot$data, robot$meta, test_dir, robot$name)

    expect_no_error(screen_csv(paths$data, paths$meta))
  }
})
