#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(leaflet)

# Define UI for application that draws a histogram
ui <- fluidPage(
  includeScript("www/main.js"), 
  useShinyjs(),
   
   # Application title
   titlePanel("UNILAG WEATHER"),

   fluidRow(
     
     column(2,
            sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
            textInput("lat", "", value = "Latitude"),
            textInput("long", "", value = "Longitude"),
            radioButtons("scol", "Variable:", c("Humidity" = "hum", "Pressure" = "pres"))
            
     ),
     column(8,
            # Show a plot of the generated distribution
               mainPanel(
                  
                  # Output: Tabset w/ plot, summary, and table ----
                  tabsetPanel(type = "tabs",
                      tabPanel("Plot", plotOutput("distPlot")),
                      tabPanel("Map", leafletOutput("map")),
                      tabPanel("Table", tableOutput("table"))
                  )
               )
     ),
     column(2,"Welcome", 
            radioButtons("tf", "Timeframe:", c("Hourly" = "hrly", "Daily" = "drly"))
     )
     
     ),

   fluidRow(
     column(2,
            "sidebar"
     ),
     column(10,
            "main"
     )
   )
   
)

# Define server
server <- function(input, output, session) {
  
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   
   observe({
     disable("lat")
     disable("long")
   })
   
   output$map <- renderLeaflet({
     leaflet() %>%
     addTiles() %>%
     addMarkers( lng=3.399259, lat=6.519250, popup="University of Lagos") %>%
      addTiles()
     
   })
   #lng=3.399259, lat=6.519250
   
}

# Run the application 
shinyApp(ui = ui, server = server)

# deployApp();
