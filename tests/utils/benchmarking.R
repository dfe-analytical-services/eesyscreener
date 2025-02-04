# Some example starter benchmarking code here
# Generate test data ==========================================================
small_data <- eesyscreener::example_data
small_meta <- eesyscreener::example_meta

source("tests/utils/generate_utils.R")

bigger_files <- generate_test_files(
  years = c(1980:2025),
  pcon_codes = dfeR::fetch_pcons(countries = "England")$pcon_code,
  pcon_names = dfeR::fetch_pcons(countries = "England")$pcon_name,
  num_filters = 15,
  num_indicators = 45
)

df <- bigger_files$data
bigger_meta <- bigger_files$meta

bigger_files <- NULL # Clean up env space

data.table::fwrite(bigger_data, "big_data.csv") # just to see the raw size

# Benchmarking ================================================================
# Create benchmarking test

microbenchmark::microbenchmark(
  for (col in names(df)) {
    y <- is.na(df[[col]][1])
    z <- df[[col]][1] == ""

    c(y, z)
  },
  lapply(names(df), function(col) {
    y <- is.na(df[[col]][1])
    z <- df[[col]][1] == ""

    c(y, z)
  }),
  vapply(names(df), function(col) {
    y <- is.na(df[[col]][1])
    z <- df[[col]][1] == ""

    c(y, z)
  }, logical(2)),
  times = 100000
)


benchmark <- function(df, reps = 10) {
  microbenchmark::microbenchmark(
    setdiff(
      names(df),
      names(janitor::remove_empty(df, which = "cols", quiet = TRUE))
    ),
    times = reps
  )
}

# Check small file ------------------------------------------------------------
benchmark(small_data, 500)

# Check big file --------------------------------------------------------------
benchmark(bigger_data, 2)
