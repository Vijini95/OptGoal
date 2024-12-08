
# OptGoal

<!-- badges: start -->
<!-- badges: end -->

Optimal water release plan is an important category under water reservoir management. Operations research (OR) is a problem-solving and decision-making analytical method that is effective in the management of organizations. Goal programming is a type of operational research concept that fits for having multiple goals instead of a single objective. This package provides tools for optimizing water release strategies from reservoirs using goal programming techniques. The package allows users to determine optimal release schedules considering inflow, demand, and constraints. It also assesses the reliability of these release strategies against water demand. Visualization functions are included to display reliability metrics, release schedules, and demand, facilitating effective interpretation and decision-making in water reservoir management.

## Installation

You can install the development version of **OptGoal** from GitHub with:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install OptGoal from GitHub
devtools::install_github("Vijini95/OptGoal", build_vignettes = TRUE)
```

## Example

This is an example which shows you how to solve a common problem:

``` r
library(OptGoal)

inflow <- c(7569, 6383, 8472, 13084, 9689, 4301, 399, 2896, 2723, 7239,14849, 13304)
demand <- c(11586.72, 4057.81, 3586.72, 10057.81, 3456.72, 1057.81, 6586.72, 2057.81, 1096.72, 1057.81, 1186.72, 1808.81)
S_min <- rep(2824.55, time=12)
S_max <- rep(26864.25, time=12)
constraints <- list(initial_storage = 500, S_min = S_min, S_max = S_max)

# Run the optimize_release function
result <- optimize_release(inflow, demand, constraints)

# Run the assess_reliability function
reliability_results <- assess_reliability(result$release, demand)

# Run the plot_release function
plot_release(result$release)

# Run the plot_release_vs_demand function
plot_release_vs_demand(result$release, demand)
```
## References

[1] http://www.pgis.pdn.ac.lk/rescon2021/abstracts/ICTMS/44.pdf

[2] https://r-pkgs.org/

[3] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=ab4bd579b616522619686295eaee77bfc17745a8

[4] https://www.researchgate.net/publication/336186183_Assessing_water_management_alternatives_in_a_multipurpose_reservoir_cascade_system_in_Sri_Lanka
