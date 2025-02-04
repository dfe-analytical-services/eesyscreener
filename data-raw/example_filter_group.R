# First example, now meta row for the filter group ============================

example_filter_group <- data.frame(
  time_period = rep("201718", 7),
  time_identifier = rep("Academic year", 7),
  geographic_level = rep("National", 7),
  country_code = rep("E92000001", 7),
  country_name = rep("England", 7),
  establishment_type_group = c(
    "Local authority maintained", "Local authority maintained",
    "Local authority maintained", "Non-maintained", "Non-maintained",
    "Non-maintained", "All establishment types"
  ),
  education_phase = c(
    "All phases", "Primary", "Secondary",
    "All phases", "Special", "Independent school", "All phases"
  ),
  enrolment_count = c(1000, 300, 700, 910, 450, 460, 1910)
)

example_filter_group_meta <- data.frame(
  col_name = c("education_phase", "enrolment_count"),
  col_type = c("Filter", "Indicator"),
  label = c("Education phase", "Number of enrolments"),
  indicator_grouping = c("", ""),
  indicator_unit = c("", ""),
  indicator_dp = c(NA, 0),
  filter_hint = c("", ""),
  filter_grouping_column = c("establishment_type_group", "")
)

usethis::use_data(example_filter_group, overwrite = TRUE)
usethis::use_data(example_filter_group_meta, overwrite = TRUE)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Second example, same data but has an extra row for the filter group =========

example_filter_group_wrow <- example_filter_group

example_filter_group_wrow_meta <- rbind(
  example_filter_group_meta,
  data.frame(
    col_name = "establishment_type_group",
    col_type = "Filter",
    label = "Type of establishment",
    indicator_grouping = "",
    indicator_unit = "",
    indicator_dp = NA,
    filter_hint = "",
    filter_grouping_column = ""
  )
)

usethis::use_data(example_filter_group_wrow, overwrite = TRUE)
usethis::use_data(example_filter_group_wrow_meta, overwrite = TRUE)
