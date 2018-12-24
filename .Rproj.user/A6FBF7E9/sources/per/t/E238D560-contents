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
library(ggplot2)
library(plotly)
source("rscript/main.R")
dat = "";
txt = "A Joseph T. Obagbemisoye's project supervised by Prof. Raymond Okafor"

# Define UI for application that draws a histogram
ui <- fluidPage(
  # tags$style("#table thead > tr:nth-child(2) {display:none;}"),
  includeScript("www/main.js"), 
  useShinyjs(),
  
  # Application title
  titlePanel("UNILAG WEATHER"),
  
  fluidRow(
    column(12, txt
    )
  ),
  
  fluidRow(
    
    column(2, style='padding:20px;',
           textInput("long", "Longitude:", value = "3.399259"),
           textInput("lat", "Latitude:", value = "6.519250"),
           radioButtons("tf", "Timeframe (X):", c("Hourly" = "hrly", "Daily" = "drly")),
           radioButtons("scol", "Variable (Y):", c("Humidity" = "hum", "Pressure" = "pres", 
                                                   "Dew Point" = "dwpnt", "Wind Speed" = "wndspd",
                                                   "Wind Gust" = "wndgst", "Cloud Cover" = "cldcvr",
                                                   "Ozone" = "ozn"))
           
    ),
    column(6, style='padding:20px;',
           mainPanel(width = 12,
                     
                     # Output: Tabset w/ plot, summary, and table ----
                     tabsetPanel(type = "pills",
                                 tabPanel("Plot", plotlyOutput("distPlot")),
                                 tabPanel("Map", leafletOutput("map")),
                                 tabPanel("Table", dataTableOutput("table")) )
           )
    ),
    column(4, style='padding:20px;',
           tabsetPanel(type = "pills",
                       tabPanel("app.R", textAreaInput("appr", "APP", "Loading...", width = "100%", rows = 18, resize = "none")),
                       tabPanel("main.R", textAreaInput("mainr", "MAIN", "Loading...", width = "100%", rows = 18, resize = "none")),
                       tabPanel("Code Error", textAreaInput("err", "ERROR", "No error", rows = 18, width = "100%", resize = "none"))
                       
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
  output$distPlot <- renderPlotly({
    dat <<- switch(input$tf, 
                   hrly = tweakframe("hourly"),
                   drly = tweakframe("daily")
    )
    yaxs <<- switch(input$scol,
                    hum = ggplotly( ggplot(aes(x=time, y=humidity), data=dat) + geom_line() ),
                    pres = ggplotly( ggplot(aes(x=time, y=pressure), data=dat) + geom_line() ),
                    dwpnt = ggplotly( ggplot(aes(x=time, y=dewPoint), data=dat) + geom_line() ),
                    wndspd = ggplotly( ggplot(aes(x=time, y=windSpeed), data=dat) + geom_line() ),
                    wndgst = ggplotly( ggplot(aes(x=time, y=windGust), data=dat) + geom_line() ),
                    cldcvr = ggplotly( ggplot(aes(x=time, y=cloudCover), data=dat) + geom_line() ),
                    ozn = ggplotly( ggplot(aes(x=time, y=ozone), data=dat) + geom_line() )
    )
    yaxs
    
  })
  
  updateTextAreaInput(session, "appr", value = getR0())
  updateTextAreaInput(session, "mainr", value = getR1())
  
  opts = list(scrollX = TRUE,  scrollY = 300, extensions = 'Scroller', filter = 'top')
  output$table <- DT::renderDataTable(DT::datatable({
    dat <<- switch(input$tf, 
                   hrly = tweakframe("hourly"),
                   drly = tweakframe("daily")
    )
    data <- dat
  },options = opts))
  
  
  observe({
    # tags$style(type='text/css', "#appr { vertical-align: middle; height: 50px; width: 100%; font-size: 30px;}")
    disable("lat")
    disable("long")
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers( lng=3.399259, lat=6.519250, popup="University of Lagos") %>%
      addTiles()
    
  })
  
  # observeEvent(input$cmd, {
  #   cmd = input$cmd
  #   if(cmd == "save"){
  #     
  #   }
  # }, once = TRUE)
  
  #lng=3.399259, lat=6.519250 Unilag's Weather
  
  err <- ""
  tryCatch({
    suppressWarnings(getData(3.399259, 6.519250))
  }, warning = function(war) {
    err <<- paste (err, war, sep = "\n", collapse = NULL)
    updateTextAreaInput(session, "err", value = err)
  }, error = function(err0) {
    err <<- paste (err, err0, sep = "\n", collapse = NULL)
    updateTextAreaInput(session, "err", value = err)
  }, finally = {
    
  }) # END tryCatch
  
}

# Run the application 
shinyApp(ui = ui, server = server)

# library(rsconnect)
# deployApp()
