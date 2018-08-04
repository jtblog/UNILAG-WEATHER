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
library(DT)
source("rscript/main.R")
dat = "";

# Define UI for application that draws a histogram
ui <- fluidPage(
  # tags$style("#table thead > tr:nth-child(2) {display:none;}"),
  includeScript("www/main.js"), 
  useShinyjs(),
   
   # Application title
   titlePanel("UNILAG WEATHER"),

   fluidRow(
     
     column(2,
            textInput("long", "Longitude:", value = "3.399259"),
            textInput("lat", "Latitude:", value = "6.519250"),
            radioButtons("tf", "Timeframe (X):", c("Hourly" = "hrly", "Daily" = "drly")),
            radioButtons("scol", "Variable (Y):", c("Humidity" = "hum", "Pressure" = "pres"))
            
     ),
     column(6,
            mainPanel(width = 12,
              
              # Output: Tabset w/ plot, summary, and table ----
              tabsetPanel(type = "tabs",
                          tabPanel("Plot", plotOutput("distPlot")),
                          tabPanel("Map", leafletOutput("map")),
                          tabPanel("Table", dataTableOutput("table"))
              )
            )
     ),
     column(4,
            tabsetPanel(type = "tabs",
                        tabPanel("app.R", ""),
                        tabPanel("main.R", "")
            )
     )
     
     ),

   fluidRow(
     column(12, "Notes:",
            ""
     )
   )
   
)

# Define server
server <- function(input, output, session) {
  
   output$distPlot <- renderPlot({
     dat <<- switch(input$tf, 
            hrly = tweakframe("hourly"),
            drly = tweakframe("daily")
            )
     yaxs <<- switch(input$scol,
                   hum = ggplot(aes(x=time, y=humidity), data=dat) + geom_line(),
                   pres = ggplot(aes(x=time, y=pressure), data=dat) + geom_line()
              )
     yaxs
     
   })
   
   
   
   opts = list(scrollX = TRUE,  scrollY = 300, extensions = 'Scroller', filter = 'top')
  output$table <- DT::renderDataTable(DT::datatable({
    dat <<- switch(input$tf, 
                   hrly = tweakframe("hourly"),
                   drly = tweakframe("daily")
    )
    data <- dat
    },options = opts))
     
     
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
getData(3.399259, 6.519250)
shinyApp(ui = ui, server = server)

# deployApp()
