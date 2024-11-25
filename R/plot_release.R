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
#' plot_release(release)
#' @import ggplot2
#' @export
plot_release <- function(release, months = NULL) {
  if (!is.numeric(release)) {
    stop("release must be a numeric vector.")
  }

  time <- seq_along(release)

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
  }

  data <- data.frame(
    Time = time,
    Release = release
  )

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = .data$Time, y = .data$Release)) +
    ggplot2::geom_line(color = "red", size = 1) +
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
