robot_test_files <- c(
  "all_geographies",
  "data-further-education-and-skills",
  "dates",
  "dates-replacement",
  "filter_hierarchy_student_enrolment",
  "grouped-filters-and-indicators",
  "grouped-filters-and-indicators-replacement",
  "invalid-data-set",
  "large-data-set",
  "mixed-categorical-numerical-data-test",
  "tiny-one-filter",
  "tiny-two-filters",
  "upload-file-test",
  "upload-file-test-with-filter"
)

read_robot <- function(
  robot_name,
  robot_url = paste0(
    "https://raw.githubusercontent.com/dfe-analytical-services/",
    "explore-education-statistics/refs/heads/dev/tests/robot-tests/tests/files/"
  )
) {
  list(
    robot_name = robot_name,
    data = readr::read_csv(paste0(robot_url, robot_name, ".csv")) |>
      dplyr::mutate(
        dplyr::across(dplyr::everything(), as.character),
        dplyr::across(dplyr::everything(), ~ dplyr::if_else(is.na(.), "", .))
      ),
    meta = readr::read_csv(paste0(robot_url, robot_name, ".meta.csv")) |>
      dplyr::mutate(
        dplyr::across(dplyr::everything(), as.character),
        dplyr::across(dplyr::everything(), ~ dplyr::if_else(is.na(.), "", .))
      )
  )
}

ees_robot_test_data <- lapply(
  robot_test_files,
  read_robot
)

usethis::use_data(ees_robot_test_data, overwrite = TRUE)
