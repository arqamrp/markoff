library(shiny)


fluidPage(
    
    # Application title
    titlePanel(span(img(src = "logo.png", height = 55), "Markoff")),

    sidebarLayout(
      
        sidebarPanel(
          
          tags$a(href = "https://github.com/arqamrp/markoff", "Source code"),
          tags$h1(),
          numericInput(
            inputId = "n_states",
            label = "Number of states",
            value = 4,
            min = 2,
            max = 10,
            step = 1
          ),
          
          uiOutput("MtxIn"), # Issue no. 1: fractional input incompatible due to floatinig point imprecision
          uiOutput("mode"),
          uiOutput("extra"),
          tags$a(href = "https://arqamrp.github.io", "Arqam Patel"),
          tags$h6("2023")
        ),

        mainPanel(
            textOutput("checkMtx"),
            textOutput("desc"),
            verbatimTextOutput("verbatim"),
            plotOutput("visual")
          
        )
    )
)
