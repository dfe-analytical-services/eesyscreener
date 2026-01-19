# Example data ====
#' Example data
#'
#' Simple example data file.
#'
#' @format A data frame with 9 rows and 8 columns:
#' \describe{
#'   \item{time_period}{Time period of row}
#'   \item{time_identifier}{Time identifier of row}
#'   \item{geographic_level}{Geographic level of row}
#'   \item{country_code}{Country code (9 digits)}
#'   \item{country_name}{Country name}
#'   \item{sex}{Sex of pupil}
#'   \item{education_phase}{Phase of education}
#'   \item{enrolment_count}{Number of enrolments}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_data"

# Example metadata ====
#' Example metadata
#'
#' This data set contains example metadata for the example data.
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{col_name}{Name of column in data file}
#'   \item{col_type}{Type of column in data file}
#'   \item{label}{Human readable label for column}
#'   \item{indicator_grouping}{Grouping for indicator columns}
#'   \item{indicator_unit}{Unit prefix or suffix}
#'   \item{indicator_dp}{Number of decimal places}
#'   \item{filter_hint}{Optional hint text to accompany filter}
#'   \item{filter_grouping_column}{Grouping column showing a filter hierarchy}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_meta"

# Example filter group data ====
#' Example filter group data
#'
#' Simple example data file showing an example of filter groups in action
#'
#' @format A data frame with 9 rows and 8 columns:
#' \describe{
#'   \item{time_period}{Time period of row}
#'   \item{time_identifier}{Time identifier of row}
#'   \item{geographic_level}{Geographic level of row}
#'   \item{country_code}{Country code (9 digits)}
#'   \item{country_name}{Country name}
#'   \item{establishment_type_group}{Type of establishment}
#'   \item{education_phase}{Education phase}
#'   \item{enrolment_count}{Number of enrolments}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_filter_group"

# Example filter group metadata ====
#' Example filter group metadata
#'
#' This data set contains example metadata for the example filter group data
#' and does not include a row for the filter grouping column.
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{col_name}{Name of column in data file}
#'   \item{col_type}{Type of column in data file}
#'   \item{label}{Human readable label for column}
#'   \item{indicator_grouping}{Grouping for indicator columns}
#'   \item{indicator_unit}{Unit prefix or suffix}
#'   \item{indicator_dp}{Number of decimal places}
#'   \item{filter_hint}{Optional hint text to accompany filter}
#'   \item{filter_grouping_column}{Grouping column showing a filter hierarchy}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_filter_group_meta"

# Example filter group data with extra row ====
#' Example filter group with extra row data
#'
#' Simple example data file showing an example of filter groups in action
#'
#' @format A data frame with 9 rows and 8 columns:
#' \describe{
#'   \item{time_period}{Time period of row}
#'   \item{time_identifier}{Time identifier of row}
#'   \item{geographic_level}{Geographic level of row}
#'   \item{country_code}{Country code (9 digits)}
#'   \item{country_name}{Country name}
#'   \item{establishment_type_group}{Type of establishment}
#'   \item{education_phase}{Education phase}
#'   \item{enrolment_count}{Number of enrolments}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_filter_group_wrow"

# Example filter group metadata with extra row ====
#' Example filter group metadata with extra row
#'
#' This data set contains example metadata for the example filter group data
#' and includes a row for the filter grouping column.
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{col_name}{Name of column in data file}
#'   \item{col_type}{Type of column in data file}
#'   \item{label}{Human readable label for column}
#'   \item{indicator_grouping}{Grouping for indicator columns}
#'   \item{indicator_unit}{Unit prefix or suffix}
#'   \item{indicator_dp}{Number of decimal places}
#'   \item{filter_hint}{Optional hint text to accompany filter}
#'   \item{filter_grouping_column}{Grouping column showing a filter hierarchy}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_filter_group_wrow_meta"

# API long data ====
#' Example data that has a column name too long for the API
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{time_period}{Time period of row}
#'   \item{time_identifier}{Time identifier of row}
#'   \item{geographic_level}{Geographic level of row}
#'   \item{country_code}{Country code (9 digits)}
#'   \item{country_name}{Country name}
#'   \item{sex}{Sex of pupil}
#'   \item{education_phase}{Phase of education}
#'   \item{enrolment_count}{Number of enrolments}
#'   \item{mahoooooooooooooooooooooooooooooooooooooooooooooooooooosive}{Long}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_api_long"

# Example API long metadata ====
#' Example metadata that has a column name too long for the API
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{col_name}{Name of column in data file}
#'   \item{col_type}{Type of column in data file}
#'   \item{label}{Human readable label for column}
#'   \item{indicator_grouping}{Grouping for indicator columns}
#'   \item{indicator_unit}{Unit prefix or suffix}
#'   \item{indicator_dp}{Number of decimal places}
#'   \item{filter_hint}{Optional hint text to accompany filter}
#'   \item{filter_grouping_column}{Grouping column showing a filter hierarchy}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_api_long_meta"

# Example screening output ====
#' Example screening output pre-generated from example_data and example_meta
#'
#' @format A data frame with the same number of rows as there are tests in the package, and 5 columns:
#' \describe{
#'   \item{check}{Name of the check}
#'   \item{result}{Check result: PASS / FAIL / WARNING}
#'   \item{message}{Check info message}
#'   \item{guidance_url}{URL to any guidance associated with the check}
#'   \item{stage}{Stage group the listed check belongs to}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_output"
