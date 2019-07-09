##' Queries the list of AHCCD stations from GeoMet
##'
##'
##' @title List of AHCCD stations
##'
##' @return A tibble.
##'
##' @author Gavin L. Simpson
##'
##' @importFrom glue glue
##' @importFrom tibble as_tibble
##' @importFrom purrr map_chr pluck
##' @importFrom rlang set_names names2
##' @importFrom stringr str_split
##' @importFrom dplyr select
##' @importFrom tidyr separate
`station_list` <- function() {
    n <- n_stations() # number of AHCCD stations
    url <- glue("{ahccd_base_url(collection = 'stations')}/items?limit={n + 1}&startindex=0")
    res <- ahccd_request(url = url)
    geometry <- as_tibble(res[["features"]][["geometry"]])
    properties <- as_tibble(res[["features"]][["properties"]])
    nms <- names2(properties)
    nms <- map_chr(str_split(nms, "__"), pluck, 1L)
    properties <- set_names(properties, nms)
    properties <- separate(properties, "year_range", c("start_year", "end_year"),
                           sep = "-", convert = TRUE)
    ## properties to take from returned object
    take_property <- c("station_id", "identifier", "station_name", "province", "elevation",
                       "start_year", "end_year", "joined")
    properties <- select(properties, take_property)
    properties
}
