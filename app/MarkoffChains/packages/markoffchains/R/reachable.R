#' Checks whether a state is reachable from another state.
#'
#' This function takes the transition probability matrix as input and finds whether the jth state is accessible/reachable from the ith state.
#'
#' @param P The transition probability matrix.
#' @param i The original state.
#' @param j The target state.
#'
#' @return A boolean value representing whether it is reachable.
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' reachable(mtx, 1, 2)
#' 
#' mtx2 <- matrix(1/3, 3, 3)
#' reachable(mtx2, 1, 2)
#'
#' @export


reachable <- function(P , i, j){
  if(is_stochastic(P)){
  access_mtx <- access(P)
  return(access_mtx[i,j])
  }
  else print("Invalid transition probability matrix")
}