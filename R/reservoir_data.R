#' Reservoir Data
#'
#' Monthly reservoir inflows, demands, and storage limits.
#'
#' @docType data
#' @usage data(reservoir_data)
#' @format A data frame with 12 rows and 5 variables:
#' \describe{
#'   \item{Month}{Abbreviated month names (character).}
#'   \item{Inflow}{Monthly inflow volumes in cubic meters (numeric).}
#'   \item{Demand}{Monthly demand volumes in cubic meters (numeric).}
#'   \item{S_min}{Minimum storage limits in cubic meters (numeric).}
#'   \item{S_max}{Maximum storage limits in cubic meters (numeric).}
#' }
#' @details
#' This dataset is used to demonstrate the optimization of reservoir releases using the \code{OptGoal} package.
#' @source
#' Mahaweli Authority of Sri Lanka.
"reservoir_data"
