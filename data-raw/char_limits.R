api_char_limits <- data.frame(
  name = c(
    "location codes",
    "filter / indicator names",
    "filter / indicator labels",
    "filter items / location names"
  ),
  id = c(
    "location-code",
    "column-name",
    "column-label",
    "column-item"
  ),
  char_limit = c(
    30,
    50,
    80,
    120
  )
)

usethis::use_data(api_char_limits, overwrite = TRUE)
