# Required metadata columns ====
#' Required metadata columns
#'
#' @format A vector of the required metadata column names
#' @source maintained by explore.statistics@@education.gov.uk
"req_meta_cols"

# Optional metadata columns ====
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

# Acceptable indicator units ====
#' Acceptable values for indicator units
#'
#' @format A vector of acceptable indicator unit values
#' @source maintained by explore.statistics@@education.gov.uk
"acceptable_indicator_units"

# Acceptable GSS symbols ====
#' Acceptable values for GSS symbols
#'
#' @format A vector of acceptable GSS symbols
#' @source maintained by explore.statistics@@education.gov.uk
"gss_symbols"

# Obsolete GSS symbols ====
#' Legacy values for GSS symbols
#'
#' @format A vector of legacy GSS symbols
#' @source maintained by explore.statistics@@education.gov.uk
"legacy_gss_symbols"

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

# Potential observational unit column regex ====
#' Regex pattern for potential observational unit columns
#'
#' A regex pattern that matches common geography-related and other observational
#' unit column names (e.g. names containing prefixes like "la", "reg", "pcon"
#' or suffixes like "name", "code", "urn", "ukprn").
#'
#' @format A length 1 character vector containing a regex pattern
#' @source maintained by explore.statistics@@education.gov.uk
"potential_ob_units_regex"

# Countries lookup ====
#' Countries lookup
#'
#' A data frame of valid country codes and names as used in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{country_code}{GSS country code}
#' \item{country_name}{Country name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/country.csv
"acceptable_countries"

# Regions lookup ====
#' Regions lookup
#'
#' A data frame of valid region codes and names as used in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{region_code}{GSS region code}
#' \item{region_name}{Region name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/regions.csv
"acceptable_regions"

# Local authority districts lookup ====
#' Local authority districts lookup
#'
#' A data frame of valid local authority district code and name combinations as
#' used in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{lad_code}{GSS LAD code}
#' \item{lad_name}{Local authority district name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/lads.csv
"acceptable_lads"

# Local enterprise partnerships lookup ====
#' Local enterprise partnerships lookup
#'
#' A data frame of valid local enterprise partnership code and name combinations
#' as used in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{local_enterprise_partnership_code}{GSS LEP code}
#' \item{local_enterprise_partnership_name}{Local enterprise partnership name
#'   matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/leps.csv
"acceptable_leps"

# Local skills improvement plan areas lookup ====
#' Local skills improvement plan areas lookup
#'
#' A data frame of valid local skills improvement plan area code and name
#' combinations as used in EES data files. Includes both current and
#' historically renamed entries.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{lsip_code}{GSS LSIP code}
#' \item{lsip_name}{Local skills improvement plan area name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/lsips.csv
"acceptable_lsips"

# Parliamentary constituencies lookup ====
#' Parliamentary constituencies lookup
#'
#' A data frame of valid parliamentary constituency code and name combinations
#' as used in EES data files. Combines both pre-2024 and 2024 boundary
#' constituencies.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{pcon_code}{GSS parliamentary constituency code}
#' \item{pcon_name}{Parliamentary constituency name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo, data/pcons.csv and
#'   data/pcon_2024_v2.csv
"acceptable_pcons"

# Wards lookup ====
#' Wards lookup
#'
#' A data frame of valid ward codes and names as used in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{ward_code}{GSS ward code}
#' \item{ward_name}{Ward name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo,
#'   data/ward_lad_la_pcon_hierarchy.csv
"acceptable_wards"

# Local authorities lookup ====
#' Local authorities lookup
#'
#' A data frame of valid local authority code and name combinations as used
#' in EES data files.
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{old_la_code}{Legacy three-digit LA code}
#' \item{new_la_code}{Current GSS LA code}
#' \item{la_name}{Local authority name matching the codes}
#' }
#' @source dfe-published-data-qa screener app repo, data/las.csv
"acceptable_las"

# Extra geography options ====
#' Extra geography options
#'
#' A data frame of universal geography code and name options that are
#' acceptable for any geography level (e.g. "Not applicable", "Unknown").
#'
#' @format A data.frame with columns:
#' \describe{
#' \item{code}{GSS geography code}
#' \item{name}{Geography name matching the code}
#' }
#' @source dfe-published-data-qa screener app repo,
#'   data/universal_geog_options.csv
"acceptable_extra_geog_options"

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
#' \item{item_error_flag}{Flag as to whether this applies to API data sets
#' or all data sets}
#' \item{contexts}{Context or publication area of definition}
#' }
#' @source maintained by explore.statistics@@education.gov.uk
"data_dictionary"
