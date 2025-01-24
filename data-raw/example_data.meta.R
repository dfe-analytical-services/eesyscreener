example_data.meta <- data.frame(
  col_name = c("sex", "establishment_type", "enrolment_count"),
  col_type = c("Filter", "Filter", "Indicator"),
  label = c("Sex of pupil", "Type of establishment", "Number of enrolments"),
  indicator_grouping = c("", "", ""),
  indicator_unit = c("", "", ""),
  indicator_dp = c("", "", 0),
  filter_hint = c("", "", ""),
  filter_grouping_column = c("", "", "")
)

usethis::use_data(example_data.meta, overwrite = TRUE)
