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
#' Groups of acceptable time identifier values. Identifiers should
#' be from the same group to be considered compatible.
#'
#' @format A list of acceptable time identifier values
#' @source maintained by explore.statistics@@education.gov.uk
"acceptable_time_ids"

# Time identifiers that should be 4 digit numbers ====
#' Time identifiers that should have 4 digit numbers
#'
#' A vector of time identifier values that should have 4 digit numbers.
#' This is a subset of the acceptable_time_ids list.
#'
#' @format A vector of time identifier values that should have 4 digit numbers
#' @source maintained by explore.statistics@@education.gov.uk
"four_digit_identifiers"

# Time identifiers that should be 6 digit numbers ====
#' Time identifiers that should have 6 digit numbers
#'
#' A vector of time identifier values that should have 6 digit numbers.
#' This is a subset of the acceptable_time_ids list.
#'
#' @format A vector of time identifier values that should have 6 digit numbers
#' @source maintained by explore.statistics@@education.gov.uk
"six_digit_identifiers"

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
