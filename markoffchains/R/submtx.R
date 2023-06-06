#' Helper function to create a submatrix of a TPM consisting of specific states
#' 
#' @param P The TPM
#' @param idx A numeric matrix containing the indices 
#'
#' @return A matrix with only the specific states (generally for a recurrent class)
#' 
#' @examples
#' idx <- c(2,3)
#' P <- matrix(c(1,0,0, 0, 1, 0, 0, 0, 1), 3, 3, byrow =TRUE)
#' submtx(P, idx) 
#'
#' @export



submtx <- function(P, idx){
  n <- length(idx)
  ans <- matrix(0, n, n)
  for(i in 1:n){
    for(j in 1:n) ans[i,j] = P[ idx[i] , idx[j] ]
  }
  return(ans)
}
