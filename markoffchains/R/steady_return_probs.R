#' Function to find steady state probabilities of returning to the initial state
#' 
#' This function takes the transition probability matrix as input and returns probabilities of returning to the same state at t = infinity.
#'
#' @param P The transition probability matrix.
#'
#' @return A matrix (1 * n_states) of probabilities 
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
#' steady_return_probs(test)
#'
#' @export



steady_return_probs <- function(P){
  
  n <- dim(P)[1]
  ans <- numeric(n)
  
  
  recur_vec <- which(as.logical(classify_classes(P)))
  
  for(i in recur_vec){
    mem_vec <- comm_classes(P)[i,]
    mem_idx_vec <- which(as.logical(mem_vec))
    subP <- submtx(P, mem_idx_vec)
    srm <- steady_recurrent(subP)
    ans <- ans + srm %*% mem_onehot(mem_idx_vec, n)
  }
  
  return(ans)
}


