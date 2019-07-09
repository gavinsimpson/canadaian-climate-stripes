##' Returns the number of stations in the AHCCD with climate data
##'
##' @title Number of AHCCD stations
##'
##' @return The number of stations as a length-1 integer
##'
##' @author Gavin L. Simpson
##'
##' @importFrom crul HttpClient
##' @importFrom jsonlite fromJSON
`n_stations` <- function() {
    ## create a HttpClient object, defining the url
    url <- "https://geo.weather.gc.ca/geomet/features/collections/ahccd-stations/items?limit=0"
    ## request data from GeoMet
    js <- ahccd_request(url = url)
    ## return the number of records matched
    js[["numberMatched"]]
}

##' Make a HTTP request for AHCCD records from GeoMet
##'
##' @title HTTP request from AHCCD
##' 
##' @param url character; a URL querying GeoMet's OGC Features API
##'
##' @return The result of the HTTP requested, parsed from JSON.
##'
##' @author Gavin L. Simpson
##'
##' @importFrom crul HttpClient
##' @importFrom jsonlite fromJSON
`ahccd_request` <- function(url) {
    cli <- HttpClient$new(url = url)
    ## do a GET request
    res <- cli$get()
    ## check to see if request failed or succeeded
    ## - if succeeds this will return nothing and proceeds to next step
    res$raise_for_status()
    ## convert to JSON
    js <- fromJSON(res$parse("UTF-8"))
    js
}

##' Base URLs for AHCCD collections on GeoMet
##'
##' @title URLS for AHCCD collections
##'
##' @param collection character; return the URL for which collection?
##'
##' @return A character string containing the requested URL
##'
##' @author Gavin L. Simpson
##'
##' @importFrom rlang arg_match
##' @importFrom glue glue
`ahccd_base_url` <- function(collection = c("stations", "annual", "seasonal",
                                            "monthly")) {
    collection <- arg_match(collection)
    base_url <- "https://geo.weather.gc.ca/geomet/features/collections"
    switch(collection,
           stations = glue("{base_url}/ahccd-stations/"),
           annual   = glue("{base_url}/ahccd-annual/"),
           seasonal = glue("{base_url}/ahccd-seasonal/"),
           monthly  = glue("{base_url}/ahccd-monthly/"))
}
