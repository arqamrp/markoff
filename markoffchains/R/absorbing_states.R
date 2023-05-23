#' Identify absorbing states of a Markov chain
#'
#' This function takes the transition probability matrix as input and finds absorbent states.
#'
#' @param P The transition probability matrix.
#' @param mode Can take value "binarr" (producing a binary array) or "indices" (returning the absorbent state indices).
#'
#' @return A binary array (if mode == "binarr") or an array of indices (if mode == "indices").
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' absorbing_states(mtx, "binarr")
#' absorbing_states(mtx, "indices")
#'
#' @export


absorbing_states <- function(P, mode = "binarr"){
  if(is_stochastic(P) == TRUE){
    n <- dim(P)[1]
    ans <- ((P * diag(1, n, n)) %*% matrix(1, n, 1)  == 1)
    if(mode == "binarr" ) return(ans + 0)
    else if (mode == "indices") return(which(ans))
  }
  else print("Invalid stochastic matrix")
}

