#' Plot Release Over Time
#'
#' This function plots the release data over time.
#'
#' @param release Numeric vector of release amounts over time.
#'
#' @return A ggplot object displaying the release over time.
#' @examples
#' plot_release(result$release)
#' @import ggplot2
#' @export
plot_release <- function(release) {
  if (!is.numeric(release)) {
    stop("release must be a numeric vector.")
  }
  time <- 1:length(release)
  data <- data.frame(
    Time = time,
    Release = release
  )

  plot <- ggplot2::ggplot(data, ggplot2::aes(x = Time, y = Release)) +
    ggplot2::geom_line(color = "blue", size = 1) +
    ggplot2::geom_point(color = "blue") +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = "Release Over Time",
      x = "Month",
      y = "Release Volume (m^3)"
    )

  return(plot)
}
