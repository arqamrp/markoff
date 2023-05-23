#' Function to classify states as recurrent or transient
#' 
#' This function takes the transition probability matrix as input and returns whether it is recurrent (1) or transient (0)
#'
#' @param P The transition probability matrix.
#' @param mode Ouptut format: Either "binarr" or "visual"
#'
#' @return A matrix of binary values or dataframe 
#' 
#' @examples
#' mtx <- matrix(c(0, 1, 0, 0, 0, 1, 0, 1, 0 ),3, 3, byrow =TRUE)
#' classify_states(mtx, "visual")
#'
#' mtx2 <- matrix(1/3, 3, 3)
#' classify_states(mtx2)
#'
#' @export

classify_states <- function(P, mode = "bin_arr"){
  if(!is_stochastic(P)) print("Invalid transition probability matrix")
  else{
    n <- dim(P)[1]
    access_mtx <- access(P)
    #commun_mtx <- access_mtx * t(access_mtx)
    good_mtx <- access_mtx * (t(access_mtx) - access_mtx)
    rt_state <- matrix((rowSums(good_mtx) ==0)+0,n,1)
    if(mode == "bin_arr") return(rt_state)
    else if(mode == "visual"){
      vis <- as.data.frame(matrix(as.character(factor(rt_state, levels = c(0,1), labels = c("transient", "recurrent"))), n,1))
      colnames(vis) <- "type"
      return(vis)
    }
  }
}
