#' @title Class filtering
#' @author Jacques van Helden
#' @description Given a data table and a vector of class memberships, discard the classes having less than a users-specified number of individuals.
#' @param x a data frame with one row per variable and one column per individual
#' @param classes a vector indicating the class of each individual
#' @param minPerClass=20 minimal number of inidividuals per class
#' @return a list containing the filtered data table and vector of class memberships
#' @export
FilterClasses <- function(x,
                          classes,
                          minPerClass=20) {

  ## Check that the data table and class vector have consistent dimensions
  if (length(classes) != ncol(x)) {
    stop("The number of columns of x shoudl be identical to the length of classes")
  }

  ## Prepare a list that will hold the different pieces of result
  result <- list()
  result$x <- data.frame() ## will contain the subset of the data table restricted to the selected individuals
  result$classes <- vector() ## will contain the class membership for the selected individuals

  ## Extract  class names
  classNames <- unique(classes) ## get a vector with unique values for class names
  classSizes <- table(classes) ## compute class sizes
  # print(classsSizes)

  ## iterate over classes
  for (class in classNames) {

    ## apply the threshold on class size
    if (classSizes[class] >= minPerClass) {

      ## Identify the individuals that belong to the current class
      selected <- (classes == class)

      ## A bit tricky: rbind will not work for the first class.
      ## create the data table with the first class, or append rows for subsequent classes.
      if (ncol(result$x) == 0) {
        result$x <- t(x[, selected])
      } else {
        result$x <- rbind(result$x, t(x[, selected]))
      }

      ## Append the class name for the individuals of the current class
      result$classes <- append(result$classes, classes[selected])
    }
  }

  ## Build the result object (list) by adding fields with the relevant information
  result$nbClasses <- length(result$classes) ## Number of classes after filtering
  result$nbIndividuals <- nrow(result$x) ## Number of individuals
  result$nbVariables <- ncol(result$x) ## Number of variables
  result$classNames <- unique(result$classes) ## class names after filtering
  result$individualNames <- rownames(result$x) ## names of the remaining individuals after class filtering
  result$variableNames <- colnames(result$x) ## variable names
  result$classSizes <- table(result$classes) ## class sizes after filtering
  return(result)

}
