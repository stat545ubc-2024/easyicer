summed_output <- function(data, group_vars = NULL, sum_var, filter_vars = TRUE, na.rm = TRUE) {
  if(!is.numeric(data[[sum_var]])) {
    stop("input is not numeric. Your object is of class ", class(sum_var))
  }
  data %>%
    filter(filter_vars) %>%
    group_by(across(all_of(group_vars))) %>%
    summarize(cumulative = sum(.data[[sum_var]], na.rm = na.rm))
}
