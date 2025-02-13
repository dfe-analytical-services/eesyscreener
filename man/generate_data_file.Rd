% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_test_files.R
\name{generate_data_file}
\alias{generate_data_file}
\title{Generate a data file for testing}
\usage{
generate_data_file(
  years,
  pcon_names,
  pcon_codes,
  num_filters,
  num_indicators,
  verbose = FALSE
)
}
\arguments{
\item{years}{A vector of 4 digit years}

\item{pcon_names}{A vector of PCon names}

\item{pcon_codes}{A vector of PCon codes}

\item{num_filters}{The number of filters to generate, currently
will give each filter 5 items}

\item{num_indicators}{The number of indicators to generate, currently
generates random numbers between 100 and 1000}

\item{verbose}{Optional console messages highlighting the number of
rows being created}
}
\value{
A data frame following the EES data standards
}
\description{
This function is designed to be used within \code{generate_test_dfs} to
complement the meta file generated by \code{generate_meta_file}.
}
\details{
Use the parameters to quickly create beefy files!
}
\keyword{internal}
