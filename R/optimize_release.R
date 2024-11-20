#' Optimize Water Release Using Goal Programming
#'
#' This function optimizes water release strategies for a single reservoir using goal programming,
#' considering time-varying minimum and maximum storage limits.
#'
#' @param inflow Numeric vector of inflow amounts over time.
#' @param demand Numeric vector of demand amounts over time.
#' @param constraints List of constraints including:
#'   \describe{
#'     \item{\code{initial_storage}}{Initial storage value (numeric).}
#'     \item{\code{S_min}}{Numeric vector of minimum storage limits over time (length equal to \code{inflow}).}
#'     \item{\code{S_max}}{Numeric vector of maximum storage limits over time (length equal to \code{inflow}).}
#'   }
#'
#' @return A list containing optimized release schedules, storage levels, deviations, and the objective value.
#' @examples
#' \dontrun{
#' # Example usage
#' inflow <- c(7569, 6383, 8472, 13084, 9689,
#' 4301, 399, 2896, 2723, 7239, 14849, 13304)
#' demand <- c(1586.72, 1057.81, 1586.72, 1057.81, 1586.72,
#' 1057.81, 1586.72, 1057.81, 1586.72, 1057.81, 1586.72, 1057.81)
#' S_min_vector <- rep(2824.55, time=12)
#' S_max_vector <- rep(26864.25, time=12)
#' constraints <- list(
#'   initial_storage = 500,
#'   S_min = S_min_vector,
#'   S_max = S_max_vector
#' )
#' result <- optimize_release(inflow, demand, constraints)
#' }
#' @import lpSolve
#' @export
optimize_release <- function(inflow, demand, constraints) {
  T <- length(inflow)  # Number of time periods

  # Input validation
  if (length(demand) != T) {
    stop("Inflow and demand vectors must be of the same length.")
  }
  if (length(constraints$S_min) != T ||
      length(constraints$S_max) != T) {
    stop("S_min and S_max must be vectors of length equal to the number of time periods.")
  }
  if (any(constraints$S_min > constraints$S_max)) {
    stop("Each element of S_min must be less than or equal to the corresponding element in S_max.")
  }

  # Decision variables for each time period:
  # R_t (release), S_t (storage), d_t^+, d_t^-
  num_vars <- T * 4  # Total number of variables

  # Objective function coefficients
  obj_coeffs <- c(rep(0, T * 2), rep(1, T), rep(1, T))

  # Initialize constraints matrices
  total_constraints <- T * 4       # Continuity, Goal, Storage Limits (lower and upper)
  constraints_matrix <- matrix(0, nrow = 0, ncol = num_vars)
  constraints_direction <- character(0)
  constraints_rhs <- numeric(0)

  # Constraint indices
  idx_R <- 1:T
  idx_S <- (T + 1):(2 * T)
  idx_d_plus <- (2 * T + 1):(3 * T)
  idx_d_minus <- (3 * T + 1):(4 * T)

  # Continuity Equations
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_S[t]] <- 1  # S_t

    if (t == 1) {
      # S_t = S_0 + I_t - R_t
      rhs <- constraints$initial_storage + inflow[t]
    } else {
      row[idx_S[t - 1]] <- -1  # -S_{t-1}
      rhs <- inflow[t]
    }
    row[idx_R[t]] <- -1  # -R_t

    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, "=")
    constraints_rhs <- c(constraints_rhs, rhs)
  }

  # Storage Limits (Lower Bounds)
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_S[t]] <- 1  # S_t

    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, ">=")
    constraints_rhs <- c(constraints_rhs, constraints$S_min[t])
  }

  # Storage Limits (Upper Bounds)
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_S[t]] <- 1  # S_t

    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, "<=")
    constraints_rhs <- c(constraints_rhs, constraints$S_max[t])
  }

  # Non-negativity constraints for release
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_R[t]] <- 1  # R_t
    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, ">=")
    constraints_rhs <- c(constraints_rhs, 0)
  }

  # Non-negativity constraints for Deviations variables
  # d_t^+ >= 0
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_d_plus[t]] <- 1  # d_t^+
    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, ">=")
    constraints_rhs <- c(constraints_rhs, 0)
  }

  # d_t^- >= 0
  for (t in 1:T) {
    row <- rep(0, num_vars)
    row[idx_d_minus[t]] <- 1  # d_t^-
    constraints_matrix <- rbind(constraints_matrix, row)
    constraints_direction <- c(constraints_direction, ">=")
    constraints_rhs <- c(constraints_rhs, 0)
  }

  # Solve the optimization problem
  result <- lp(
    direction = "min",
    objective.in = obj_coeffs,
    const.mat = constraints_matrix,
    const.dir = constraints_direction,
    const.rhs = constraints_rhs
  )

  if (result$status != 0) {
    stop("Optimization did not find a feasible solution.")
  }

  # Extract the optimized release and storage
  optimized_release <- result$solution[idx_R]
  optimized_storage <- result$solution[idx_S]
  deviations_positive <- result$solution[idx_d_plus]
  deviations_negative <- result$solution[idx_d_minus]

  # Return the results
  return(
    list(
      release = optimized_release,
      storage = optimized_storage,
      deviations_positive = deviations_positive,
      deviations_negative = deviations_negative,
      objective_value = result$objval
    )
  )
}
