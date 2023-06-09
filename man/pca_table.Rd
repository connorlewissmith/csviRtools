% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pca_table.R
\name{pca_table}
\alias{pca_table}
\title{Perform principal component analysis and return a table of results}
\usage{
pca_table(df, cols)
}
\arguments{
\item{df}{A data frame}

\item{cols}{A character vector specifying the numeric column names to include in the analysis}
}
\value{
A data frame with the variable loadings, variable kmo, total kmo, proportion of variance, ss loadings,
and Bartlett's test of sphericity p-values
}
\description{
Perform principal component analysis and return a table of results
}
\examples{
data(iris)
pca_table(iris, c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
}
