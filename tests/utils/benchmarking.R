# Some example starter benchmarking code here
# Generate test data ==========================================================
small_data <- eesyscreener::example_data
small_meta <- eesyscreener::example_meta

bigger_files <- eesyscreener::generate_test_dfs(
  years = c(1980:2025),
  pcon_codes = dfeR::fetch_pcons(countries = "England")$pcon_code,
  pcon_names = dfeR::fetch_pcons(countries = "England")$pcon_name,
  num_filters = 15,
  num_indicators = 45
)

bigger_data <- bigger_files$data
bigger_meta <- bigger_files$meta

bigger_files <- NULL # Clean up env space

# Benchmarking ================================================================
# Create benchmarking test
benchmark <- function(df, reps = 10) {
  microbenchmark::microbenchmark(
    # Option 1,
    # Option 2,
    times = reps
  )
}

# Check small file ------------------------------------------------------------
benchmark(small_data, 500)

# Check big file --------------------------------------------------------------
benchmark(bigger_data, 2)
