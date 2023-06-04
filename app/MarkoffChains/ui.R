library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Markoff Chains"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          numericInput(
            inputId = "n_states",
            label = "Number of states",
            value = 4,
            min = 2,
            max = 10,
            step = 1
          ),
          
          uiOutput("MtxIn"), # Issue no. 1: fractional input incompatible due to floatinig point imprecision
          uiOutput("mode")
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("checkMtx"),
            verbatimTextOutput("verbatim"),
            plotOutput("visual")
          
        )
    )
)
