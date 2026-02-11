# Required metadata columns ====
#' Required metadata columns
#'
#' @format A vector of the required metadata column names
#' @source maintained by explore.statistics@@education.gov.uk
"req_meta_cols"

# Optional metedata columns ====
#' Optional metadata columns
#'
#' @format A vector of the acceptable, optional metadata column names
#' @source maintained by explore.statistics@@education.gov.uk
"optional_meta_cols"

# Required data columns ====
#' Required data columns
#'
#' @format A vector of the required data column names
#' @source maintained by explore.statistics@@education.gov.uk
"req_data_cols"

# Geographic levels and columns ====
#' Acceptable geographic levels and their associated columns
#'
#' @format data.frame
#' @source maintained by explore.statistics@@education.gov.uk
"geography_df"

# Acceptable time identifiers ====
#' Acceptable time identifiers
#'
#' @format A vector of acceptable time identifier values
#' @source maintained by explore.statistics@@education.gov.uk
"acceptable_time_ids"

# API character limits ====
#' API character limits
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{name}{The name of the type of value}
#' \item{id}{The id of the type of value}
#' \item{char_limit}{The character limit for that type of value}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"api_char_limits"

# Data dictionary ====
#' Data dictionary
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{col_name}{Standard column names}
#' \item{col_type}{Column types of defined columns: "Filter" or "Indicator"}
#' \item{filter_item}{Possible filter items within standard filters}
#' \item{col_name_parent}{Standardised parent (filter grouping) column names}
#' \item{filter_item_parent}{Possible parent (filter grouping) filter items}
#' \item{cbds_code}{Common basic data set code where applicable}
#' \item{item_error_flag}{Flag as to whether this applies to API data sets or all data sets}
#' \item{contexts}{Context or publication area of definition}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"data_dictionary"
