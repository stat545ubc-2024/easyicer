#' Sum values in numeric column sorted by variable groupings.
#'
#' This function sums column of numeric type using dplyr pipeline. Users can set grouping hierarchies and filter conditions to specify calculations.
#'
#' @param data A dataframe that the function will be applied to.
#' @param group_vars variable(s)/column name(s) of a dataframe that is used to group the observations based on common characteristics. "group_vars" specifies the type of operation (group_by). Set to "NULL" as default.
#' @param sum_var a character string that represents a column name/variable containing numeric values. "sum_var" specifies the type of operation (sum) for the variable.
#' @param filter_vars variable(s)/column(s) called on to set conditions for filtering. "filter_vars" specifies the type of operation (filter) for the selected variables. Set to TRUE as default so user can select filter conditions or leave the argument unused.
#' @param na.rm argument specifying how to handle NA values in data when performing sum operation; set to "TRUE" as default to prevent an NA output in the sum operation when the column is passed through the function.
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#'
#' @return A dataframe with a new column named "cumulative" containing the summed output value for each grouping.
#' @export
#'
#' @examples
#' # Using the function without any grouping or filtering conditions
#' summed_output(data = palmerpenguins::penguins,
#'               sum_var = "body_mass_g")
#'
#' # Applying filters by storing filter conditions as an object in the function call
#' sex_male_year_2007 <- palmerpenguins::penguins$sex == "male" & palmerpenguins::penguins$year == 2007
#'
#' summed_output(data = palmerpenguins::penguins,
#'               group_vars = c("island", "species"),
#'               sum_var = "bill_depth_mm",
#'               filter_vars = sex_male_year_2007,
#'               na.rm = TRUE)


summed_output <- function(data, group_vars = NULL, sum_var, filter_vars = TRUE, na.rm = TRUE) {
  if(!is.numeric(data[[sum_var]])) {
    stop("input is not numeric. Your object is of class ", class(sum_var))
  }
  data %>%
    dplyr::filter(filter_vars) %>%
    dplyr::group_by(dplyr::across(dplyr::all_of(group_vars))) %>%
    dplyr::summarize(cumulative = sum(.data[[sum_var]], na.rm = na.rm))
}
