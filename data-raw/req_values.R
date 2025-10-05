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
