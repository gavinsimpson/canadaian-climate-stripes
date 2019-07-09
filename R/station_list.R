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
`station_list` <- function() {
    n <- n_stations() # number of AHCCD stations
    url <- glue("{ahccd_base_url(collection = 'stations')}/items?limit={n + 1}&startindex=0")
    
}
