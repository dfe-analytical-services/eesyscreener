test_that("Check find duplicate rows works as expected", {
  # Check it returns zero rows when there are no duplicates
  expect_equal(
    find_duplicate_rows(
      dplyr::bind_rows(example_data),
      example_meta
    ) |>
      nrow(),
    0
  )

  # Check it returns correct number of rows when there are duplicates
  expect_equal(
    find_duplicate_rows(
      dplyr::bind_rows(example_data, example_data),
      example_meta
    ) |>
      nrow(),
    example_data |> nrow()
  )

  # Check it doesn't count differing indicator values as unqiue rows
  expect_equal(
    find_duplicate_rows(
      dplyr::bind_rows(
        example_data,
        example_data |> dplyr::mutate(enrolment_count = 5)
      ),
      example_meta
    ) |>
      nrow(),
    example_data |> nrow()
  )
})
