
# OptGoal

<!-- badges: start -->
<!-- badges: end -->

Optimal water release plan is an important category under water reservoir management. Operations research (OR) is a problem-solving and decision-making analytical method that is effective in the management of organizations. Goal programming is a type of operational research concept that fits for having multiple goals instead of a single objective. The important aspect is that if we do not get the solution by the linear programming model, we can apply the goal programming model to get the values of the deviation of the original solution. 

This package provides tools for optimizing water release strategies from reservoirs using goal programming techniques. The package allows users to determine optimal release schedules considering inflow, demand, constraints, and specified goals. 

It also assesses the reliability of these release strategies against water demand. Visualization functions are included to display reliability metrics, release schedules, and demand, facilitating effective interpretation and decision-making in water reservoir management.

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

For the remainder of the semester, I plan to:

- **Finalize Core Functions**: Complete the implementation and optimization of the `optimize_release` and `assess_reliability` functions.
- **Enhance Documentation**: Write comprehensive documentation with detailed descriptions and usage examples for each function.
- **Testing**: Use the `testthat` package to write unit tests, improving the package's reliability.
- **Prepare for CRAN Submission**: Ensure the package meets all CRAN policies and guidelines for potential submission.
