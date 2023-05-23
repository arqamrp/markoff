#' Finds communicating classes in a stochastic process.
#'
#' This function takes the transition probability matrix as input and returns the communicating classes.
#'
#' @param P The transition probability matrix.
#' @param mode "binarr" (returns binary array with i,j th entry indicating whether jth element is present in ith class) or "list" (with ith element of list being a vector of states present in ith class)
#'
#' @return A binary array or list of vectors of 
#'
#' @examples
#' mtx = diag(1, 3, 3)
#' comm_classes(mtx, "list")
#' 
#' mtx2 <- matrix(1/3, 3, 3)
#' comm_classes(mtx2)
#'
#' @export

comm_classes <- function(P, mode = "bin_arr"){
  if(!is_stochastic(P)) print("Invalid transition probability matrix")
  else{
      n <- dim(P)[1]
      step_mtx <- ((P + diag(1,n,n))>0) + 0 # classes accessible in first step
      access_mtx <- access(P)
      commun_mtx <- access_mtx * t(access_mtx) # states which are accessible from each other communicate
      eq_class <- unique(commun_mtx) # states belonging to same equivalent class communicate with same set of states
  
      foo <- character(0)
      for(i in 1:dim(eq_class)[1]) foo <- c(foo, paste("class", i, sep= ""))
      rownames(eq_class) <- foo
  
      if(mode == "bin_arr") return(eq_class) # ith row means ith equivalent class
    
      else if(mode == "list"){
        num_classes <- dim(eq_class)[1]
        output_list <- replicate(num_classes, list(), simplify = FALSE)
        
        for(i in 1:num_classes){
          temp <- c()
        
          for(j in 1:n){
            if(eq_class[i,j] == 1) temp = c(temp, j)
          }
        
          output_list[[i]] <- temp
        }
        
        return(output_list)
      }
  }
}

