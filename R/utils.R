##' Returns the number of stations in the AHCCD with climate data
##'
##' @title Number of AHCCD stations
##' @return The number of stations as a length-1 integer
##' @author Gavin L. Simpson
##'
##' @importFrom crul HttClient
##' @importFrom jsonlite fromJason
`n_stations` <- function() {
    ## create a HttpClient object, defining the url
    url <- "https://geo.weather.gc.ca/geomet/features/collections/ahccd-stations/items?limit=0"
    cli <- HttpClient$new(url = url)
    ## do a GET request
    res <- cli$get()
    ## check to see if request failed or succeeded
    ## - if succeeds this will return nothing and proceeds to next step
    res$raise_for_status()
    ## convert to JSON
    js <- fromJSON(res$parse("UTF-8"))
    ## return the number of records matched
    js[["numberMatched"]]
}

