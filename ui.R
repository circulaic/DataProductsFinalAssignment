library(shiny)
library(plotly)
library(lubridate)

cvd <- read.csv("owid-covid-data-subset.csv", header = TRUE,sep = ",")  ## add col classes
cvd$date<-dmy(cvd$date) ##covert dates to date format

# Use shiny sidebar layout 

shinyUI(pageWithSidebar(
    
    ##page title
    headerPanel("COVID-19 Statistics by Continent & Country to 13/01/21"), ## page title
    
    ## sidebar contents
    sidebarPanel(
          p(strong("User Guide:",style="color:blue")),
          p("This app allows users to explore key cumulative COVID-19 metrics by continent."),
          p("To use, make two selections below in the input selection area: 1) select the continent; 2) select the metric"),
          p("Once these choices are made, the right-hand graph will update to display the COVID-19 data"),
          hr(),
          p(strong("Input Selection:",style="color:blue")),
          selectInput("Continent", "Continent:",  
                    choices=c("Africa","Asia","Europe","North America","Oceania","South America")), 
          selectInput("Metric", "Metric:",  
                      choices=c("Total Cases","Total Deaths","Total Cases per Million Population","Total Deaths per Million Population")), 
        hr(),
        p(strong("Data Sources:",style="color:blue")),
        p("Data used for this app is obtained from the open source", a("Our World in Data Coronavirus Source Data",href="https://ourworldindata.org/coronavirus-source-data")),
        hr(),
    ),
    
    ##plot area
    mainPanel(
        p(),
        plotlyOutput("graph")   
    )
))   
    
   
    
    
