# Some example starter benchmarking code here
# Generate test data ==========================================================
small_data <- example_data
small_meta <- example_meta

bigger_files <- generate_test_dfs(
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

data.table::fwrite(bigger_data, "beefy_data.csv")
data.table::fwrite(bigger_meta, "beefy_data.meta.csv")
data.table::fwrite(small_data, "small_data.csv")
data.table::fwrite(small_meta, "small_data.meta.csv")


# Benchmarking ================================================================
# Create benchmarking test
benchmark <- function(df, reps = 10) {
  microbenchmark::microbenchmark(
    x <- data.table::fread("beefy_data.csv"),
    x <- vroom::vroom("beefy_data.csv"),
    times = reps
  )
}

# Check small file ------------------------------------------------------------
benchmark(small_data, 500)

# Check big file --------------------------------------------------------------
benchmark(bigger_data, 2)


filename <- "small_data.csv" # "beefy_data.csv"

microbenchmark::microbenchmark(
  x <- data.table::fread(filename),
  x <- data.table::fread(
    filename,
    sep = ",",
    header = TRUE,
    encoding = "UTF-8",
    strip.white = FALSE,
    showProgress = FALSE
  ),
  x <- duckplyr::read_csv_duckdb(filename),
  times = 50
)
