#' Helper function to create concatenated one hot vectorss
#'
#' @param idx A numeric matrix containing the indices to convert to one hot
#' @param n The number of states in the MC
#'
#' @return A matrix with concatenated one hot vectors
#' 
#' @examples
#' idx <- c(2,3)
#' mem_onehot(idx, 6) 
#'
#' @export


mem_onehot <- function(idx, n){
  p <- length(idx)
  ans <- matrix(0, p, n)
  for(i in 1:p) ans[i, idx[i]] <- 1
  return(ans)
}