#' Plot Release Over Time
#'
#' This function plots the release data over time with x-axis labels as months.
#'
#' @param release Numeric vector of release amounts over time.
#' @param months Optional character vector of month names corresponding to the release data.
#'               If not provided and the length of release is 12, defaults to Jan-Dec.
#'
#' @return A ggplot object displaying the release over time.
#' @examples
#' # Using the reservoir_data data set
#' data(reservoir_data)
#' constraints <- list(
#'   initial_storage = 500,
#'   S_min = reservoir_data$S_min,
#'   S_max = reservoir_data$S_max
#' )
#' result <- optimize_release(
#'   inflow = reservoir_data$Inflow,
#'   demand = reservoir_data$Demand,
#'   constraints = constraints
#' )
#' release <- result$release
#' plot_release(release)
#' @import ggplot2
#' @export
plot_release <- function(release, months = NULL) {
  if (!is.numeric(release)) {
    stop("release must be a numeric vector.")
  } #check the condition under release

  time <- seq_along(release) #Define time

  # Assign default month names if appropriate
  if (is.null(months) && length(release) == 12) {
    months <- month.abb
  }

  # Use months if provided
  if (!is.null(months)) {
    if (length(months) != length(release)) {
      stop("Length of 'months' must match length of 'release'.")
    }
    time_labels <- months
  } else {
    time_labels <- time
  } #Check the length of months and release are equal or not

  data <- data.frame(
    Time = time,
    Release = release
  ) #Assign time and release into a data frame

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = .data$Time, y = .data$Release)) +
    ggplot2::geom_line(color = "red", linewidth = 1) +
    ggplot2::geom_point(color = "red") +
    ggplot2::scale_x_continuous(breaks = time, labels = time_labels) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Release Over Time",
      x = "Month",
      y = "Release Volume (Cubic meters)"
    )

  return(plot)
}
