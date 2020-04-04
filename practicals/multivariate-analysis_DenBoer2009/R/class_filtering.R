#' @title Class filtering
#' @author Jacques van Helden
#' @description Given a data table and a vector of class memberships, discard the classes having less than a users-specified number of individuals.
#' @param x a data frame with one row per variable and one column per individual
#' @param classes a vector indicating the class of each individual
#' @param minPerClass=20 minimal number of inidividuals per class
#' @return a list containing the filtered data table and vector of class memberships
#' @export
filterClasses <- function(x,
                          classes,
                          minPerClass=20) {

  ## Check that the data table and class vector have consistent dimensions
  if (length(classes) != ncol(x)) {
    stop("The number of columns of x shoudl be identical to the length of classes")
  }

  result <- list()
  result$x <- data.frame()
  result$classes <- vector()

  ## Extract  class names
  classNames <- unique(classes)
  classSizes <- table(classes)

  for (class in classNames) {
    if (classSizes[class] >= minPerClass) {
      selected <- classes == class
      if (ncol(result$x) == 0) {
        result$x <- t(x[, selected])
      } else {
        result$x <- rbind(result$x, t(x[, selected]))
      }
      result$classes <- append(result$classes, classes[selected])
    }
  }

  ## Compute sizes of the filtered classes
  result$individualNames <- rownames(result$x)
  result$variableNames <- colnames(result$x)
  result$nbIndividuals <- nrow(result$x) ## Number of individuals
  result$nbVariables <- ncol(result$x) ## Number of variables
  result$classNames <- unique(result$classes)
  result$classSizes <- table(result$classes)
  return(result)
}
