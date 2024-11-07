
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sumvar

<!-- badges: start -->
<!-- badges: end -->

This R package contains the `summed_output()` function which takes a
column as a character string storing a vector of numeric values within a
dataframe and calculates the sum of the vector. It is designed to help
users automate repetitive sum operations based on user-defined variable
groupings and filter conditions. This package contains **magrittr** and
**rlang** as dependencies to support compatibility with tidy evaluation.

## Installation

You can install the development version of sumvar from
[GitHub](https://github.com/stat545ubc-2024/assignment-b2-bchia9) with:

    install.packages("devtools")
    devtools::install_github("stat545ubc-2024/assignment-b2-bchia9", ref = "1.0.3")

## Usage

Here is a basic example of using this package with the
`palmerpenguins::penguins` dataset:

``` r
library(sumvar)
library(palmerpenguins)

# Create a filter condition and store as an object
sex_male_year_2007 <- palmerpenguins::penguins$sex == "male" & palmerpenguins::penguins$year == 2007

summed_output(data = palmerpenguins::penguins,
              group_vars = c("island", "species"),
              sum_var = "bill_depth_mm",
              filter_vars = sex_male_year_2007,
              na.rm = TRUE)
#> # A tibble: 5 × 3
#> # Groups:   island [3]
#>   island    species   cumulative
#>   <fct>     <fct>          <dbl>
#> 1 Biscoe    Adelie          91.5
#> 2 Biscoe    Gentoo         261. 
#> 3 Dream     Adelie         194. 
#> 4 Dream     Chinstrap      249. 
#> 5 Torgersen Adelie         143.
```
