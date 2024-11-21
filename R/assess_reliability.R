#' Assess Reliability of Water Release Strategy
#'
#' This function assesses the reliability of the release strategies against demand,
#' calculating time-based reliability, and volume-based reliability.
#'
#' @param release Numeric vector of release amounts over time.
#' @param demand Numeric vector of demand amounts over time.
#'
#' @return A data frame containing the reliability metrics.
#' @examples
#' reliability_results <- assess_reliability(result$release, demand)
#' print(reliability_results)
#' @export
assess_reliability <- function(release, demand) {
  if (length(release) != length(demand)) {
    stop("Release and demand vectors must be of the same length.")
  }
  T <- length(release)

  # Time-Based Reliability
  time_reliability <- sum(release >= demand) / T

  # Volume-Based Reliability
  volume_reliability <- sum(release) / sum(demand)

  # Compile results
  reliability_results <- data.frame(time_reliability = time_reliability, volume_reliability = volume_reliability)

  return(reliability_results)
}
