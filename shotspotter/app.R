

library(shiny)
library(htmltools)
library(tidyverse)
library(ggplot2)
library(fs)
library(sf)
library(ggthemes)
library(leaflet)

dc <- read_csv("shotspotter_dc.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Shotspotter Data in Washington D.C."),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sliderInput(inputId = "year",
                  label = "Year",
                  min = 2006,
                  max = 2016,
                  value = 1,
                  step = 1,
                  sep = "",
                  animate = TRUE
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         leafletOutput("leafletPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
   output$leafletPlot <- renderLeaflet({
     
     data <- subset(dc, year == input$year)
     
     map <- data %>%
       leaflet() %>%
       addTiles() %>%
       addCircleMarkers(data = data, radius = .5, label = ~htmlEscape(incidentid)) %>%
       setView(lat = 38.865, lng = -77, zoom = 12.25) 
     
     map
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

