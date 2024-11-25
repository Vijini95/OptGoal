#' Plot Release and Demand Over Time
#'
#' This function plots both the release and demand data over time on the same graph,
#' allowing for easy comparison between the two.
#'
#' @param release Numeric vector of release amounts over time.
#' @param demand Numeric vector of demand amounts over time.
#' @param months Optional character vector of month names corresponding to the data.
#'               If not provided and the length of data is 12, defaults to Jan-Dec.
#'
#' @return A ggplot object displaying the release and demand over time.
#' @examples
#' # Example usage
#' inflow <- c(7569, 6383, 8472, 13084, 9689,
#'             4301, 399, 2896, 2723, 7239, 14849, 13304)
#' demand <- c(1586.72, 1057.81, 1586.72, 1057.81, 1586.72,
#'             1057.81, 1586.72, 1057.81, 1586.72, 1057.81, 1586.72, 1057.81)
#' S_min_vector <- rep(2824.55, times = 12)
#' S_max_vector <- rep(26864.25, times = 12)
#' constraints <- list(
#'   initial_storage = 500,
#'   S_min = S_min_vector,
#'   S_max = S_max_vector
#' )
#' result <- optimize_release(inflow, demand, constraints)
#' release <- result$release
#' plot_release_vs_demand(release, demand)
#' @import ggplot2
#' @importFrom reshape2 melt
#' @export
plot_release_vs_demand <- function(release, demand, months = NULL) {
  if (!is.numeric(release)) {
    stop("release must be a numeric vector.")
  }
  if (!is.numeric(demand)) {
    stop("demand must be a numeric vector.")
  }
  if (length(release) != length(demand)) {
    stop("release and demand must be of the same length.")
  }

  time <- seq_along(release)

  # Assign default month names if appropriate
  if (is.null(months) && length(release) == 12) {
    months <- month.abb  # Built-in vector of abbreviated month names
  }

  # Use months if provided
  if (!is.null(months)) {
    if (length(months) != length(release)) {
      stop("Length of 'months' must match length of 'release' and 'demand'.")
    }
    time_labels <- months
  } else {
    time_labels <- time
  }

  data <- data.frame(
    Time = time,
    Release = release,
    Demand = demand
  )

  # Melt data for plotting
  data_melted <- reshape2::melt(data, id.vars = "Time")

  # Create the plot
  plot <- ggplot2::ggplot(data_melted, ggplot2::aes(x = .data$Time, y = .data$value, color = .data$variable)) +
    ggplot2::geom_line(size = 1) +
    ggplot2::geom_point() +
    ggplot2::scale_x_continuous(breaks = time, labels = time_labels) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Release vs. Demand Over Time",
      x = "Month",
      y = "Volume (Cubic meters)",
      color = "Legend"
    )

  return(plot)
}
