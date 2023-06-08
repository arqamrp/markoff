library(tidyr)
library(devtools)

library(ggplot2)

if (!require(markoffchains)) {
  devtools::install_github("arqamrp/markoff", subdir = "markoffchains")
}

library(markoffchains)

library(shiny)
library(shinyMatrix)

function(input, output, session) {
    output$MtxIn <- renderUI(
      {
        matrixInput("matrix2", 
                    value = matrix(1/input$n_states, input$n_states, input$n_states, dimnames = list(1:input$n_states, 1:input$n_states)),
                    cols = list(names =T),
                    class = "numeric",
                    rows = list(n = input$n_states, names = T, data = 1:input$n_states)
                    )
        
        
      }
    )
    
    output$mode <- renderUI(
      {
        selectizeInput(
          "func",
          "What would you like to compute?",
          c("Steady state configuration" = "steady", "Communicating classes"="comm", "Absorbing states"="abs", "Reachable states"= "reach", "Configuration after n steps" = "n_steps")
        ) 
        
      }
    )
    
    output$extra <- renderUI(
      {
        if(input$func == "n_steps"){
          numericInput(
            "n",
            "Number of steps",
            value = 2,
            min = 1,
            max = 1e5,
            step = 1
          )
        }
        else if(input$func == "steady"){
          selectizeInput(
            "subfunc",
            "What exactly?",
            c("Stationary matrix"="stat", "Returning probabilities"="rtrn", "Class probabilities"= "class")
          ) 
          
        }
        
      }
    )
    
    
    output$checkMtx <- renderText({
      if(!is_stochastic(input$matrix2)) print("Oops, your matrix isn't a valid stochastic matrix.")
    })
    
    output$desc <- renderText(
      {
        if(is_stochastic(input$matrix2)){
          if(input$func == "n_steps") "Probabilities of each state after n time steps"
          else if(input$func == "steady"){
            if(input$subfunc == "stat") "Probabilities of each state after infinite time"
            else if(input$subfunc == "class") "Probabilities of being in each class after infinite steps"
            else if(input$subfunc == "rtrn") "Probabilities of returning to the initial state after infinite time"
          }
        }
        else "Please ensure that all row sums are equal to 1."
      }
    )
    
    output$verbatim <- renderPrint({
        if(is_stochastic(input$matrix2)){
          if(input$func == "comm" ) classify_classes(input$matrix2, "visual")
          
          else if(input$func == "abs" ) {
            str = "Absorbing state(s):";
            for(i in absorbing_states(input$matrix2, "indices")) str = paste(str, i) # modify absorbing states to return NULL when no abs states
            if(str != "Absorbing state(s):") str
            else "No absorbing states"
          }
          else if(input$func == "n_steps"){
            if(input$n < 1){
              "Please enter an integer >= 1"
            }
            else{
              p <- dim(input$matrix2)[1]
              mtx = diag(1,p,p);
              for(i in 1:input$n ){
                mtx = mtx %*% input$matrix2
              }
              mtx
            }
          }
          else if(input$func == "steady"){
            if(input$subfunc == "stat"){
              steady_state(input$matrix2)
            }
            else if(input$subfunc == "rtrn"){
              list( steady_return_probs(input$matrix2))
            }
            else if(input$subfunc == "class"){
              list( Class = comm_classes(input$matrix2, mode = "list") , Probabilities = steady_class_probs(input$matrix2))
            }
            
          }
          
        }
      else{
        mtx <- matrix(rowSums(input$matrix2));
        colnames(mtx) = "Row sums";
        mtx
      }
      })
    
    output$visual <- renderPlot({
      
      if(is_stochastic(input$matrix2)){
        
        if(input$func == "comm"){
          new <- matrix(0,dim(input$matrix2)[1],dim(input$matrix2)[1])
          com <- comm_classes(input$matrix2, "list")
          c = 0
          for(i in com){
            c = c + 1
            for(j in i){
              for(k in i){
                new[j,k] <- c
              }
            }
          }
          
          matrix_data <- new
          distinct_values <- unique(as.vector(matrix_data))
          
          num_colors <- length(distinct_values)
          color_palette <- rainbow(num_colors)
          
          df <- data.frame(matrix_data)
          df$row <- factor(rownames(df), levels = rev(rownames(df)))
          
          df_long <- gather(df, col, value, -row)
          df_long$color <- ifelse(df_long$value == 0, "0", as.character(df_long$value))
          
          # Plot the grid
          ggplot(df_long, aes(x = col, y = row, fill = color)) +
            geom_tile(color = "black", width = 1, height = 1) +
            scale_fill_manual(values = c("white", color_palette)) +
            labs(x = "", y = "") +
            theme_void()  
          
        }
        else if(input$func == "reach"){

          
          plotBinaryMatrix <- function(binary_matrix) {
            # Create a data frame for plotting
            df <- data.frame(
              row = factor(rep((1:nrow(binary_matrix)), each = ncol(binary_matrix))),
              col = factor(rep(ncol(binary_matrix):1, times = nrow(binary_matrix))),
              value = as.logical(as.vector(binary_matrix))
            )
            
            # Plot the binary matrix with row and column numbers on the axes
            ggp <- ggplot(df, aes(x = row, y = col, fill = value)) +
              geom_tile(color = "black", width = 1, height = 1) +
              scale_fill_manual(values = c("white", "grey")) +
              theme_void()+
              ggtitle("Accessible states")+
              geom_text(aes(label = paste0( 5- as.numeric(col), " to ", as.numeric(row)))) +
              coord_cartesian(clip = "off") 
            
            ggp
          }
          
          
          plotBinaryMatrix(access(input$matrix2))
          
        }
      }
    })
}

