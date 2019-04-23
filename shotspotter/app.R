

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      radioButtons(inputId = "year",
                   label = "Year",
                   choices = c("2006", "2007")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("leafletPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
   output$leafletPlot <- renderPlot({
     
     # data <- subset(dc, year == input$year)
     
     data <- dc
     
     map <- data %>%
       leaflet() %>%
       addTiles %>%
       addCircleMarkers(data = data, radius = .5)
     
     map
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

