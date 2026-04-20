# Generate test data ==========================================================
small_data <- example_data
small_meta <- example_meta

small_data <- small_data |> tibble::remove_rownames()
small_meta <- small_meta |> tibble::remove_rownames()
duckplyr::compute_csv(small_data, "small_data.csv")
duckplyr::compute_csv(small_meta, "small_data.meta.csv")

# 45 years / pcons / 3 filters / 45 indicators ~ 6.2 million rows
bigger_files <- generate_test_dfs(
  years = c(1980:2025),
  pcon_codes = dfeR::fetch_pcons(countries = "England")$pcon_code,
  pcon_names = dfeR::fetch_pcons(countries = "England")$pcon_name,
  num_filters = 3,
  num_indicators = 45,
  verbose = TRUE
)

# Drop these rows 'E14001487 South Holland and the Deepings', 'E14001127 Bridlington and the Wolds'
# They have 'the' instead of 'The'
bigger_data <- bigger_files$data[
  !bigger_files$data$pcon_code %in% c("E14001487", "E14001127"),
]
bigger_meta <- bigger_files$meta

bigger_data <- bigger_data |> tibble::remove_rownames()
bigger_meta <- bigger_meta |> tibble::remove_rownames()
duckplyr::compute_csv(bigger_data, "beefy_data.csv")
duckplyr::compute_csv(bigger_meta, "beefy_data.meta.csv")

bigger_files <- NULL # Clean up env space

###############################################################################
# Profile! ####################################################################
###############################################################################

start <- Sys.time()
screen_csv("small_data.csv", "small_data.meta.csv")
end <- Sys.time()
dfeR::pretty_time_taken(start, end)

start <- Sys.time()
screen_csv("beefy_data.csv", "beefy_data.meta.csv")
end <- Sys.time()
dfeR::pretty_time_taken(start, end)

profvis::profvis({
  screen_csv("small_data.csv", "small_data.meta.csv")
})

profvis::profvis({
  screen_csv("beefy_data.csv", "beefy_data.meta.csv")
})
