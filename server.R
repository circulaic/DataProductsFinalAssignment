library(shiny)
library(plotly)
library(lubridate)

cvd <- read.csv("owid-covid-data-subset.csv", header = TRUE,sep = ",")  ## add col classes
cvd$date<-dmy(cvd$date) ##covert dates to date format


function(input, output) { 
    
    # Fill in the spot we created for a plot 
    output$graph <- renderPlotly({
        continent<-input$Continent  ##brings in the Continent input from the UI
        cvdsub<-cvd[cvd$continent==continent,] ##subsets the data for only the selected continent
        
        metric<-input$Metric ##brings in the Metric input from the UI
        ##Returns the column index number of hte selected metric
        colplot<-ifelse(metric=="Total Cases",5,ifelse(metric=="Total Deaths",6,ifelse(metric=="Total Cases per Million Population",7,8)))
        
        ##Plots the graph with the selected metric for the selected continent
        p<-plot_ly(x = ~cvdsub$date, y = ~cvdsub[,colplot], type='scatter',mode='line', color=~cvdsub$location)
        layout(p,title="Cumulative COVID-19 Data to 13/01/2021 for Selected Metric and Continent", xaxis=list(title="Date"),yaxis=list(title=metric))

    })
}