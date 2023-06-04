#' This function takes the transition probability matrix as input and finds states accessible from each state.
#'
#' @param P The transition probability matrix.
#'
#' @return A matrix of binary values where the i, j th entry indicates whether the jth state is accessible from the ith one.
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' access(mtx)
#' 
#' mtx2 = matrix(1/3, 3, 3)
#' access(mtx2)
#' 
#' @export


access <- function(P){
  if(is_stochastic(P))
  {  
    n <- dim(P)[1]
    access_mtx <- matrix(0,n,n)
    temp_mtx <- (P + diag(1,n,n)) 
    
    # a state that is accessible can be reached in at most n - 1 steps
    # check for states accessible in 1st, 2nd...(n-1)th steps
    for(i in 1:n-1){
      access_mtx <- (access_mtx + temp_mtx)
      temp_mtx <- temp_mtx %*% P
    }
    return((access_mtx>0) +0)
  }
  else return("Invalid stochastic matrix")
}

# a graph based approach could be used as well