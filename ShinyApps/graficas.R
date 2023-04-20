#Shiny de graficos de jugadore

pacman::p_load(ggplot2,shiny,tidyr)

ui <- fluidPage( theme = shinytheme("sandstone"),
  titlePanel("Graficas de campeones"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      fileInput("file1", "Seleccionar archivo CSV",
                accept = c(".csv")
      ),
      
      selectInput("variable",label = "Variable",
                  choices = list("Played Times" = "Veces.jugadas","Damage" = "DMG.partida","CS" = "cs.partida","Kills" = "kill.partida","Deaths" = "deaths.partida","Assists" = "assists.partida"),
                  selected = "Damage"),
      
      sliderInput("plotsize", "Tamaño de la gráfica:", min = 10, max = 20, value = 15,step = 1),
      
      
      actionButton("submitbutton", "Submit", class = "btn btn-primary")
      ),
      mainPanel(
        tags$h1("Header 1"),
        
        fluidRow(
          column (width = 6,
                  sidebarPanel(
                    h3("Resultados"),
                    tableOutput(outputId = "tableData")
                  )),
          
          column( width = 6,
                  plotOutput(outputId = "p1")
          )
        )
        
      )
  )
)

server <- function(input,output){
  
  observeEvent(input$submitbutton, {
    
    data <- read.csv(input$file1$datapath)
    data$X <- factor(data$X)
    data <- data[data$Veces.jugadas > 4,]
    
    
    p1 <- ggplot(data, aes(x = X, y = !!as.name(input$variable)),
                 col = "blue")+
          geom_col()+
          labs(x = "Campeones", y = input$variable)
    
    output$p1 <- renderPlot(p1,width = (input$plotsize)*100,height = (input$plotsize)*50)
    dataTable <- subset(data, ,select = c("X",input$variable))
    
    output$tableData <- renderTable(dataTable)
  })
}

shinyApp(ui=ui, server = server)
