library("testthat")
library("canadastripes")

context("Testing n_stations()")

nstns <- n_stations()

test_that("n_stations() returns an integer", {
    expect_type(nstns, "integer")
})

test_that("n_stations() returns a single integer", {
    expect_length(nstns, 1L)
}
