# Generate test data ==========================================================
small_data <- eesyscreener::example_data
small_meta <- eesyscreener::example_meta

# 45 years / pcons / 3 filters / 45 indicators ~ 6.2 million rows
bigger_files <- eesyscreener::generate_test_dfs(
  years = c(1980:2025),
  pcon_codes = dfeR::fetch_pcons(countries = "England")$pcon_code,
  pcon_names = dfeR::fetch_pcons(countries = "England")$pcon_name,
  num_filters = 3,
  num_indicators = 45,
  verbose = TRUE
)

bigger_data <- bigger_files$data
bigger_meta <- bigger_files$meta

bigger_files <- NULL # Clean up env space

# Benchmarking ================================================================
# currently too fast to get meaningful results
# (get a warning about positive execution times)
microbenchmark::microbenchmark(
  screen_files("data.csv", "data.meta.csv", small_data, small_meta),
  reps = 100
)

microbenchmark::microbenchmark(
  screen_files("data.csv", "data.meta.csv", bigger_data, bigger_meta),
  reps = 5
)
