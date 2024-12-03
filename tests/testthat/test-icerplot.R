# Test 1

test_that("data argument is a dataframe and non-dataframe objects are rejected", {
  # Create non-dataframe object
  icers_list <- list(
    intervention = c("int1", "int2", "int3", "int4", "int5"),
    effect = c(1, 2, 3, 4, 5),
    cost = c(2, 4, 6, 2, 8))
  expect_error(icerplot(
    data = icers_list,
    x = "effect",
    y = "cost"),
    "data input must be a dataframe. Your object is of structure: list")
})

# Test 2

test_that("function only retrieves columns found in dataframe", {
  # Create test dataframe for test_that() functions
  test_df <- data.frame(
    intervention = c("int1", "int2", "int3", "int4", "int5"),
    effect = c(1, 2, 3, 3, 4),
    cost = c(2, 4, 6, 2, 8))

  # Test that function passes with proper inputs
  expect_no_error(icerplot(data = test_df, x = "effect", y = "cost", names = "intervention"))

  # Test that function does not pass with non-numeric inputs
  expect_error(icerplot(test_df, x = "effects", y = "cost", names = "group"))

})

# Test 3

test_that("function only handles numeric and NA x-y arguments but rejects df with character inputs", {
  # Create a test df with a non-numeric observation
  test_df_char <- data.frame(
    intervention = c("int1", "int2", "int3", "int4", "int5"),
    effect = c(1, 2, 3, 3, 4),
    cost = c(2, "x", 6, 2, 8))

  # Create a test df with NA observations
  test_df_na <- data.frame(
    intervention = c("int1", "int2", "int3", "int4", "int5"),
    effect = c(1, 2, 3, 3, 4),
    cost = c(2, NA, 6, 2, 8))

# Test function works with NA values but not character values
  expect_no_error(icerplot(data = test_df_na, x = "effect", y = "cost", names = "intervention", na.rm = TRUE))

  expect_error(icerplot(test_df_char, x = "effect", y = "cost", names = "intervention", na.rm = TRUE))
})

# Test 4

test_that("function properly maps legend labels based on names argument", {

  # Create test dataframe for test_that() functions
  test_df <- data.frame(
    intervention = c("int1", "int2", "int3", "int4", "int5"),
    effect = c(1, 2, 3, 3, 4),
    cost = c(2, 4, 6, 2, 8))

  # Generate plot structure for testing using native ggplot2 and this package function

  # Using ggplot2
  gg_plot <- ggplot2::ggplot(test_df, ggplot2::aes(effect, cost, color = intervention)) +
    ggplot2::geom_point(size = 2) +
    ggplot2::labs(
      title = "Cost-Effectiveness Plot with ICERs",
      x = "Incremental Effectiveness (QALY)",
      y = "Incremental Cost ($)"
    ) +
    ggplot2::guides(color = ggplot2::guide_legend(title = NULL)) +
    cowplot::theme_cowplot()

  # Using icerplot
  my_plot <- icerplot(test_df, x = "effect", y = "cost", names = "intervention")


  # Extract plot structures for both plots
  my_plot_str <- ggplot2::ggplot_build(my_plot)
  gg_plot_str <- ggplot2::ggplot_build(gg_plot)

  # Test that labels are equal
  expect_equal(my_plot_str$plot$guides$color, gg_plot_str$plot$guides$color)
})

# Test 5

test_that("function properly maps legend labels when names argument is NULL", {

  # Create test dataframe for test_that() functions
  test_df <- data.frame(
    intervention = c("A", "B", "C", "D", "E"),
    effect = c(1, 2, 3, 3, 4),
    cost = c(2, 4, 6, 2, 8))

  # Generate plot structure for testing using native ggplot2 and this package function

  # Using ggplot2
  gg_plot <- ggplot2::ggplot(test_df, ggplot2::aes(effect, cost, color = intervention)) +
    ggplot2::geom_point(size = 2) +
    ggplot2::labs(
      title = "Cost-Effectiveness Plot with ICERs",
      x = "Incremental Effectiveness (QALY)",
      y = "Incremental Cost ($)"
    ) +
    ggplot2::guides(color = ggplot2::guide_legend(title = NULL)) +
    cowplot::theme_cowplot()

  # Using icerplot
  my_plot <- icerplot(test_df, x = "effect", y = "cost", names = NULL) # As default when names = NULL, legend entries will be recognized as letters in alphabetical order.


  # Extract plot structures for both plots to access legend structure
  my_plot_str <- ggplot2::ggplot_build(my_plot)
  gg_plot_str <- ggplot2::ggplot_build(gg_plot)

  # Test that labels are equal
  expect_equal(my_plot_str$plot$guides$color, gg_plot_str$plot$guides$color)
})
