example_output <- rbind(
  screen_filenames("myfile.csv", "myfile.meta.csv"),
  screen_dfs(example_data, example_meta)
)
usethis::use_data(example_output, overwrite = TRUE)
