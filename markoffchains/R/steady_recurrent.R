#' Outputs stable configuration for a recurrent Markov chain
#'
#' This function takes the transition probability matrix for a recurrent Markov chain as input and finds absorbent states.
#'
#' @param P The transition probability matrix.
#'
#' @return The probability matrix of the states after t= infinity.
#'
#' @examples
#' mtx = matrix(0.25, 4, 4)
#' steady_recurrent(mtx)
#'
#' @export

steady_recurrent<-function(P){
  eigen_result <- eigen(t(P)) #left eigenvector
  Q <- eigen_result$vectors[, round( eigen_result$values, digits = 6) == 1] # eigenvector with eigenvalue 1
  Q <- Q/sum(Q)
  return(Q)
}
