#' Function to find steady state probabilities of entering into different communicating classes
#' 
#' This function takes the transition probability matrix as input and returns probabilities of ending up in each class from each state
#'
#' @param P The transition probability matrix.
#'
#' @return A matrix (n_states * n_classes) of probabilities
#'  
#' @examples
#' test <- matrix(c(0, 0.25, 0.5, 0.25, 0, 0,
#' 0, 0.5, 0, 0.5, 0, 0,
#' 0, 0, 0.25, 0, 0.75, 0,
#' 0, 0.5, 0, 0.5, 0, 0,
#' 0, 0, 0.75, 0, 0.25, 0,
#' 0, 0.25, 0, 0.25, 0.5, 0
#' ) , 6, 6, byrow = TRUE)
#' 
#' steady_class_probs(test)
#'
#' @export


steady_class_probs <- function(P){
  n <- dim(P)[1]
  m2 <- matrix(1, n, 1) %*% t(classify_states(P))   
  m3 <- m2 * P
  m4 <- m3/rowSums(m3)
  m5 <- m4 %*% t(comm_classes(P) )
  return(m5)
}
