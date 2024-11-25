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
#' # Example usage
#' inflow <- c(7569, 6383, 8472, 13084, 9689,
#' 4301, 399, 2896, 2723, 7239, 14849, 13304)
#' demand <- c(11586.72, 4057.81, 3586.72, 10057.81,
#' 3456.72, 1057.81, 6586.72, 2057.81, 1096.72, 1057.81, 1186.72, 1808.81)
#' S_min_vector <- rep(2824.55, time=12)
#' S_max_vector <- rep(26864.25, time=12)
#' constraints <- list(
#'   initial_storage = 500,
#'   S_min = S_min_vector,
#'   S_max = S_max_vector
#' )
#' result <- optimize_release(inflow, demand, constraints)
#' release <- result$release
#' reliability_results <- assess_reliability(release, demand)
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
