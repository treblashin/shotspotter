

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      radioButtons(inputId = "year",
                   label = "Year",
                   choices = c(dc$year)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("leafletPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  data <- dc %>%
    filter(year == input$year)
  
   output$leafletPlot <- renderPlot({
     
     map <- data %>%
       leaflet() %>%
       addTiles %>%
       addCircleMarkers(data = dc, radius = .5)
     
     map
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

