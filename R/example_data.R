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
#'   \item{establishment_type}{Type of establishment}
#'   \item{enrolment_count}{Number of enrolments}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_data"

#' Example metadata
#'
#' This data set contains example metadata for the example data.
#'
#' @format A data frame with 3 rows and 8 columns:
#' \describe{
#'   \item{col_name}{Name of column in data file}
#'   \item{col_type}{Type of colummn in data file}
#'   \item{label}{Human readable label for column}
#'   \item{indicator_grouping}{Grouping for indicator columns}
#'   \item{indicator_unit}{Unit prefix or suffix}
#'   \item{indicator_dp}{Number of decimal places}
#'   \item{filter_hint}{Optional hint text to accompany filter}
#'   \item{filter_grouping_column}{Grouping column showing a filter hierachy}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"example_meta"
