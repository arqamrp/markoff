#' Function to find stationary matrix (probabilities in steady state)
#' 
#' This function takes the transition probability matrix as input and returns the probability matrix of ending up at each state at t = infinity.
#'
#' @param P The transition probability matrix.
#'
#' @return A stochastic matrix (n_states * n_states) of probabilities 
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
#' steady_state(test)
#'
#' @export



steady_state <- function(P){
  n <- dim(P)[1]
  m1 <- matrix(1, n, 1) %*% steady_return_probs(P)
  m2 <- steady_class_probs(P)
  m3 <- comm_classes(P)
  m4 <- m2 %*% m3
  return(m4 * m1)
}


