icercalc <- function(data, rev = c("neither", "rows", "columns", "both")) {
  if(!all(sapply(data,is.numeric))) {
    stop("Object is not numeric. Your object contains columns of class: ", paste(unique(sapply(data, class)), collapse = ", "))
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

