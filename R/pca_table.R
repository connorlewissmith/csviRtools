#' Perform principal component analysis and return a table of results
#' @name pca_table
#'
#' @param df A data frame
#' @param cols A character vector specifying the numeric column names to include in the analysis
#' @return A data frame with the variable loadings, variable kmo, total kmo, proportion of variance, ss loadings,
#' and Bartlett's test of sphericity p-values
#'
#' @importFrom  psych principal KMO cortest.bartlett
#' @importFrom  stats cor
#' @export
#'
#' @examples
#' data(iris)
#' pca_table(iris, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))

pca_table <- function(df, cols) {

  # Select specified numerical columns
  df <- df[, cols]

  # Calculate correlation matrix
  cor_matrix <- stats::cor(df)

  # Perform principal component analysis with varimax rotation
  pca_res <- psych::principal(df, nfactors = 1, rotate = "varimax", scores = TRUE)

  # Extract the factor loadings
  loadings_table <- as.data.frame(cols)

  loadings_table$loadings <- pca_res$loadings[1:ncol(df)]

  # Calculate KMO of the correlation matrix
  loadings_table$variable_kmo <- as.data.frame(psych::KMO(cor_matrix)[2])

  # Extract the Overall MSA value
  loadings_table$overall_msa <- psych::KMO(cor_matrix)$MSA

  # Extract the proportion of variance
  loadings_table$prop_variance <- pca_res$Vaccounted[2,1]

  # Extract SS loadings
  loadings_table$ss_loadings <- pca_res$Vaccounted[1,1]

  # Extract Bartlett's Test p value
  loadings_table$bartlett_test <- psych::cortest.bartlett(cor_matrix, n = nrow(cor_matrix))$p.value

  # Rename the variables in the data frame
  names(loadings_table) <- c("Variables", "Loadings", "Variable KMO", "Overall KMO", "Proportion of Variance","SS Loadings", "Bartlett's Test")

  # Return the resulting table
  return(loadings_table)
}
