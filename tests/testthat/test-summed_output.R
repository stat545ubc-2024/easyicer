# Test 1

test_that("sum_var is a numeric vector", {
  expect_true(is.numeric(palmerpenguins::penguins$flipper_length_mm))
  expect_error(summed_output(data = palmerpenguins::penguins,
                             group_vars = c("island", "sex"),
                             sum_var = "species"),
               "input is not numeric. Your object is of class character")
})

# Test 2

test_that("na.rm argument handles NA values correctly", {

  # Test that no NA values are outputted when na.rm = TRUE

  function_result_narm_true <- summed_output(
    data = palmerpenguins::penguins,
    group_vars = c("island", "species"),
    sum_var = "bill_depth_mm",
    na.rm = TRUE)

  expected_result_narm_true <- palmerpenguins::penguins %>%
    dplyr::group_by(island, species) %>%
    dplyr::summarize(cumulative = sum(bill_depth_mm, na.rm = TRUE))

  expect_equal(function_result_narm_true, expected_result_narm_true)

  rm(list = c("function_result_narm_true", "expected_result_narm_true"))

  # Test that NA values are present in output when na.rm = FALSE

  function_result_narm_false <- summed_output(
    data = palmerpenguins::penguins,
    group_vars = c("island", "species"),
    sum_var = "bill_depth_mm",
    na.rm = FALSE)

  expected_result_narm_false <- palmerpenguins::penguins %>%
    dplyr::group_by(island, species) %>%
    dplyr::summarize(cumulative = sum(bill_depth_mm, na.rm = FALSE))

  expect_equal(function_result_narm_false, expected_result_narm_false)

  rm(list = c("function_result_narm_false", "expected_result_narm_false"))

})

# Test 3

test_that("filter is working; non-filtered output column length is greater than filtered column length", {

  no_filter_result <- summed_output(data = palmerpenguins::penguins,
                                    group_vars = c("island", "sex"),
                                    sum_var = "body_mass_g")

  adelie_2007 <- palmerpenguins::penguins$species == "Adelie" & palmerpenguins::penguins$year == 2007

  filter_result <- summed_output(data = palmerpenguins::penguins,
                                 group_vars = c("island", "sex"),
                                 sum_var = "body_mass_g",
                                 filter_vars = adelie_2007)

  expect_gt(length(no_filter_result$cumulative), length(filter_result$cumulative))

  rm(list = c("no_filter_result", "filter_result", "adelie_2007"))

})
