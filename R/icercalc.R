#' Calculate the ratio of incremental change between a new and comparator state.
#'
#' This function takes a 2x2 matrix and calculates the ratio of the difference between two numerator and denominator states. This function is intended to calculate the ICER between two defined strategies or interventions in a health economics assessment.
#'
#' @param data An object containing a 2x2 matrix of exactly 4 numerical values
#' @param rev An argument specifying the order of the matrix inputted into the "data" argument. Includes "rows" (reverses order of rows), "columns" (reverses columns) or "both" (reverses both). Set to "neither" as default.
#'
#' @return The matrix used to calculate the output after the "rev" argument has been applied and a numeric output.
#' @details
#' This function expects the "data" argument to list an object storing a 2x2 matrix containing exactly 4 numerical values. Using labels as expected for an ICER calculation, the following structure is expected:
#'
#' ```
#'              old     new
#' cost (ref)   n00     n01
#' qaly (ref)   n10     n11
#' ```
#'
#' The function extracts matrices outputs for the calculation relative to the defined reference values. If the matrix is not in the desired format, the "rev" argument can be used to switch the order of the rows, columns or both. It is set to "neither" as default and will calculate the ICER using the current order of the values presented.
#'
#' @export
#'
#' @examples
#'
#' icer_table <- matrix(c(24, 12, 8, 6), nrow = 2, ncol = 2, byrow = TRUE)
#'
#' # Calculating ICER with the native matrix as inputted with the default rev = "neither"
#' icercalc(data = icer_table)
#'
#' # Applying a "rev" argument to rearrange the matrix for ICER calculation
#' icercalc(data = icer_table, rev = "columns")



icercalc <- function(data, rev = c("neither", "rows", "columns", "both")) {
  if(!all(sapply(data,is.numeric))) {
    stop("Object is not numeric. Your object contains values of class: ", paste(unique(sapply(data, class)), collapse = ", "))
  }
  if(!is.matrix(data)) {
    stop("Object structure is not accepted. Object must be in matrix format.")
  }
  if(length(data) != 4) {
    stop("Object must be a 2x2 matrix containing exactly 4 values")
  }

  rev <- match.arg(rev)

  if (rev == "rows") {
    data <- data[2:1, ]  # Reverse rows
  } else if (rev == "columns") {
    data <- data[, 2:1]  # Reverse columns
  } else if (rev == "both") {
    data <- data[2:1, 2:1]  # Reverse both rows and columns
  }

  print("Modified matrix:")
  print(data) # Print modified matrix after applying rev argument

  icer <- (data[1,2] - data[1,1]) / (data[2,2] - data[2,1])

  print(icer)
}

