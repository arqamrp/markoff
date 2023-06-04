#' Classifies equivalent classes as recurrent and transient.
#'
#' This function takes the transition probability matrix as input and returns the classification of equivalent classes.
#'
#' @param P The transition probability matrix.
#' @param mode "binarr" (returns binary vector with ith entry indicating whether the ith class is recurrent) or "visual" (returns readable dataframe with class elements and classification)
#'
#' @return A binary array or dataframe
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' classify_classes(mtx, "visual")
#' 
#' mtx2 <- matrix(1/3, 3, 3)
#' classify_classes(mtx2)
#'
#' @export

classify_classes <- function(P, mode = "bin_arr"){
  n <- dim(P)[1]
  comm_class <- comm_classes(P)
  rt_state <- classify_states(P)
  ans <- (comm_class %*% rt_state > 0)+0
  y<- factor(ans, levels = c(0,1), labels = c("transient", "recurrent"))
  y <- as.character(y)
  
  df <- as.data.frame(matrix(0, dim(comm_class)[1],2))
  chars <- character(dim(comm_class)[1])
  for(i in 1:dim(comm_class)[1]){
    nom <- character(0)
    for(j in 1:n){
      if(comm_class[i,j] == 1) nom <- paste(nom, j)
    }
    chars[i] <- nom
  }
  
  df[,1] <- chars 
  df[,2] <- y
  colnames(df) <- c("elements", "type")
  
  foo <- character(0)
  for(i in 1:dim(comm_class)[1]) foo <- c(foo, paste("class", i, sep= ""))
  rownames(df) <- foo
  
  if(mode == "bin_arr") return(ans)
  else if(mode == "visual") return(df)
}
