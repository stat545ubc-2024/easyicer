#' Plot ICERs on a cost-effectiveness plane with incremental effectiveness and incremental cost plotted on the x and y axes, respectively.
#'
#' This function generates a cost-effectiveness scatter plot intended for ICERs. It handles a dataframe with x (QALY) and y (Cost) numeric columns and an optional names column .
#'
#' @param data A dataframe containing at least two numeric columns of identical length.
#' @param x A variable in the dataframe containing only numeric values. Input incremental effectiveness (i.e., QALY) for ICER plot.
#' @param y A variable in the dataframe containing only numeric values. Input incremental cost for ICER plot.
#' @param names An argument to include strategy/intervention names from dataframe in the plot legend. Set to NULL as default. If NULL, labels will default to random letters in alphabetical order based on nrows in dataframe.
#' @param na.rm An argument specifying how to handle NA values in data before creating a plot; set to "TRUE" as default.
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 labs
#' @importFrom ggplot2 guides
#' @importFrom ggplot2 guide_legend
#' @importFrom cowplot theme_cowplot
#' @importFrom dplyr %>%
#' @importFrom dplyr filter
#' @importFrom dplyr mutate
#' @importFrom dplyr n
#'
#' @return A scatter plot with a figure legend.
#' @export
#'
#' @examples
#' # Creating a dataframe with ICERs
#' icers <- data.frame(
#' intervention = c("int1", "int2", "int3", "int4", "int5"),
#' effect = c(1, 2, 3, 3, 4),
#' cost = c(2, 4, 6, 2, 8))
#'
#' # Applying function to create ICER plot with no "names" argument
#' icerplot(data = icers, x = "effect", y = "cost")
#'
#' # Applying function with "names" argument specified
#' icerplot(data = icers, x = "effect", y = "cost", names = "intervention")


icerplot <- function(data, x, y, names = NULL, na.rm = TRUE) {

  # Ensure data is in dataframe format
  if (!is.data.frame(data)) {
    stop("data input must be a dataframe. Your object is of structure: ", class(data))
  }

  # Ensure that x and y exist in the data
  if (!(x %in% colnames(data)) || !(y %in% colnames(data))) {
    stop("x and/or y column does not exist in the data frame.")
  }

  # Ensure name in argument exists in data
  if (!is.null(names)) {
    if (!(names %in% colnames(data))) {
      stop("The specified 'names' argument does not exist in the data frame.")
    }
  }

  # Ensure x and y are numeric
  if (!is.numeric(data[[x]]) || !is.numeric(data[[y]])) {
    stop("Both x and y inputs must contain only numeric values.")
  }

  # Conditional formatting if na.rm = TRUE to remove NA values
  if (na.rm) {
    data <- data %>%
      dplyr::filter(!is.na(.data[[x]]), !is.na(.data[[y]]))
  }

  # Conditional plotting using ggplot

  # Conditional formatting if names is specified
  if (!is.null(names)) {
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]], color = .data[[names]])) +
      ggplot2::geom_point(size = 2) +
      ggplot2::labs(
        title = "Cost-Effectiveness Plot with ICERs",
        x = "Incremental Effectiveness (QALY)",
        y = "Incremental Cost ($)"
        ) +
      ggplot2::guides(color = ggplot2::guide_legend(title = NULL)) +
      cowplot::theme_cowplot()
  } else {
  # Combine x and y for color mapping if name = NULL
    data <- data %>%
      dplyr::mutate(
        row_id = seq_len(dplyr::n()),
        legend_label = factor(row_id, labels = LETTERS[seq_len(dplyr::n())])
      )
    # Conditional formatting if names argument is not specified
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]], color = legend_label)) +
      ggplot2::geom_point(size = 2) +
      ggplot2::labs(
        title = "Cost-Effectiveness Plot with ICERs",
        x = "Incremental Effectiveness (QALY)",
        y = "Incremental Cost ($)"
        ) +
      ggplot2::guides(color = ggplot2::guide_legend(title = NULL)) +
      cowplot::theme_cowplot()
  }
}

