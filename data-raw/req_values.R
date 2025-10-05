req_meta_cols <- c(
  "col_name",
  "col_type",
  "label",
  "indicator_grouping",
  "indicator_unit",
  "indicator_dp",
  "filter_hint",
  "filter_grouping_column"
)

usethis::use_data(req_meta_cols, overwrite = TRUE)

optional_meta_cols <- c(
  "filter_default"
)

usethis::use_data(optional_meta_cols, overwrite = TRUE)

req_data_cols <- c(
  "geographic_level",
  "time_period",
  "time_identifier",
  "country_code",
  "country_name"
)

usethis::use_data(req_data_cols, overwrite = TRUE)
