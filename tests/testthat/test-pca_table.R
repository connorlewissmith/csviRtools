data(iris)

# Create a test data frame with numeric columns
test_df <- iris[, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")]

# Test the function with the test data frame
test_that("pca_table returns expected output",
          {
            result <- pca_table(test_df, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
            expect_equal(ncol(result), 7)
            expect_equal(nrow(result), 4)
            expect_true(all(c("Variables", "Loadings", "Variable KMO", "Overall KMO", "Proportion of Variance","SS Loadings", "Bartlett's Test") %in% colnames(result)))
          })

# Test the function with missing values
test_that("pca_table warning with missing values",
          {
            # Add some missing values to the test data frame
            test_df[sample(1:150, 10), 2] <- NA
            expect_warning(pca_table(test_df, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")))
          })

# Test the function with only one numeric column
test_that("pca_table errors with single-column input",
          {
            expect_error(pca_table(test_df[, 1, drop = FALSE], c("Sepal.Length")))
          })

# Test the function with non-numeric input
test_that("pca_table errors with non-numeric input",
          {
            expect_error(
              pca_table(test_df$Species, "Species"))
          })

# Test that all columns besides the first are numeric
test_that("columns are numeric", {
  result <- pca_table(test_df, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
  expect_true(all(sapply(result[, -1], is.numeric)), info = "A column is not numeric")
  expect_true(is.character(result[,1]), info = "The first column is not character")
})


