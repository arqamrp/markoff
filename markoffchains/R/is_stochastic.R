#' Checks whether a matrix is stochastic.
#'
#' This function takes any matrix as input and finds whether it is a valid transition probability matrix of a stochastic process.
#'
#' @param P The matrix.
#'
#' @return A boolean value representing whether it is stochastic.
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' is_stochastic(mtx)
#' 
#' mtx2 <- matrix(1, 2, 3)
#' is_stochastic(mtx2)
#'
#' @export


is_stochastic <- function(P){
  dp <- dim(P)
  if(length(dp) ==2 & dp[1] == dp[2] & setequal(rowSums(P),numeric(length = dp[1])+1)) return(TRUE)
  else return(FALSE)
}
