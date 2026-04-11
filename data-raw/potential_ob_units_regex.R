potential_ob_units_regex <- paste0(
  "(^(country|sch|prov|inst|estab|reg|la|local|",
  "rsc|pfa|pcon|lep|mca|oa|ward|mat)",
  ".*(name|code|urn|ukprn|number|upin|id)$)",
  "|(^(laestab|estab|sch|school|schools|prov|provider|providers|inst|",
  "institution|institutions|name|code|urn|ukprn|number|upin|id|region|",
  "la|lad|rsc|pcon|lep|mca|oa|ward|mat)$)"
)

usethis::use_data(potential_ob_units_regex, overwrite = TRUE)
