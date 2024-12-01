# Test 1

test_that("Function rejects data object with non-numeric values", {

  matrix_data_character <- matrix(c(24, "x", 8, 6), nrow = 2, ncol = 2, byrow = TRUE)
  expect_error(icercalc(data = matrix_data_character),
               "Object is not numeric. Your object contains values of class: character")
})

# Test 2

test_that("Function rejects data object not in matrix format", {

  non_matrix_data <- c(3, 2, 4, 1)
  expect_error(icercalc(non_matrix_data))
})


# Test 3

test_that("Function properly applies rev argument", {

  matrix_ordered <- matrix(c(24, 12, 8, 6), nrow = 2, ncol = 2, byrow = TRUE)
  icer_ordered <- icercalc(matrix_ordered)

  matrix_unordered <- matrix(c(6, 8, 12, 24), nrow = 2, ncol =2, byrow = TRUE)
  icer_unordered <- icercalc(matrix_unordered, rev = "both")

  expect_equal(icer_ordered, icer_unordered)
})
