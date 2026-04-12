# Valid geog code and name combinations
# Sources from dfe-published-data-qa repo for now
# TODO: Move to create from dfeR (or us as a dependency direct)

acceptable_countries <- readr::read_csv(
  render_url("data/country.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_countries, overwrite = TRUE)

acceptable_extra_geog_options <- readr::read_csv(
  render_url("data/universal_geog_options.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_extra_geog_options, overwrite = TRUE)

acceptable_regions <- readr::read_csv(
  render_url("data/regions.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  as.data.frame()

usethis::use_data(acceptable_regions, overwrite = TRUE)

acceptable_las <- readr::read_csv(
  render_url("data/las.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  dplyr::select("old_la_code", "new_la_code", "la_name") |>
  as.data.frame()

usethis::use_data(acceptable_las, overwrite = TRUE)

acceptable_lads <- readr::read_csv(
  render_url("data/lads.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  dplyr::select("lad_code", "lad_name") |>
  as.data.frame()

usethis::use_data(acceptable_lads, overwrite = TRUE)

acceptable_leps <- readr::read_csv(
  render_url("data/leps.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  dplyr::select(
    "local_enterprise_partnership_code",
    "local_enterprise_partnership_name"
  ) |>
  as.data.frame()

usethis::use_data(acceptable_leps, overwrite = TRUE)

acceptable_pcons <- dplyr::bind_rows(
  readr::read_csv(
    render_url("data/pcons.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  ) |>
    dplyr::select("pcon_code", "pcon_name"),
  readr::read_csv(
    render_url("data/pcon_2024_v2.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  ) |>
    dplyr::select(pcon_code = "PCON24CD", pcon_name = "PCON24NM")
) |>
  dplyr::distinct() |>
  as.data.frame()

usethis::use_data(acceptable_pcons, overwrite = TRUE)

acceptable_lsips <- readr::read_csv(
  render_url("data/lsips.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  dplyr::select("lsip_code", "lsip_name") |>
  dplyr::distinct() |>
  as.data.frame()

usethis::use_data(acceptable_lsips, overwrite = TRUE)

acceptable_edas <- readr::read_csv(
  render_url("data/english_devolved_areas.csv", domain = "screener_app_repo"),
  show_col_types = FALSE
) |>
  dplyr::select("english_devolved_area_code", "english_devolved_area_name") |>
  dplyr::distinct() |>
  as.data.frame()

usethis::use_data(acceptable_edas, overwrite = TRUE)

acceptable_wards <- readr::read_csv(
  render_url(
    "data/ward_lad_la_pcon_hierarchy.csv",
    domain = "screener_app_repo"
  ),
  show_col_types = FALSE
) |>
  dplyr::select("ward_code", "ward_name") |>
  dplyr::distinct() |>
  as.data.frame()

usethis::use_data(acceptable_wards, overwrite = TRUE)
