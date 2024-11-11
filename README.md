
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
devtools::install_github("Vijini95/OptGoal")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(OptGoal)
## basic example code
```

## Next Steps

For the remainder of the semester, I plan to complete the implementation and optimization of the `optimize_release` and `assess_reliability` functions, write comprehensive documentation with detailed descriptions and usage examples for each function, and use the `testthat` package to write unit tests, improving the package's reliability.
