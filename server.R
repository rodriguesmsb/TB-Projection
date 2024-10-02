#define server function
library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)

df <- readRDS("data.rds")

shinyServer(function(input,output){
  
  output$ts_plot <- renderPlotly({
    
    plot <- ggplot(df) +
      geom_point(aes(x = Time, y = !!input$yvar))
    
    ggplotly(plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')
    
    
  })
})