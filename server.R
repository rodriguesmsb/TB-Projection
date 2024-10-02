#define server function
library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)

df <- readRDS("data.rds")

shinyServer(function(input,output){
  
  
  #plot time series of TB incidence
  output$ts_plot_tb_inc <- renderPlotly({
    
    tb_plot <- ggplot(df) +
      geom_point(aes(x = Time, y = New_Cases)) +
      labs(x = NULL, y = "Incidencia de Tuberculose no Brasil")
    
    ggplotly(tb_plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')
    
  })
  
  #plot time series of TB incidence
  output$ts_plot<- renderPlotly({
    
    ts_pred_plot <- ggplot(df) +
      geom_point(aes(x = Time, y = !!input$predictors)) +
      labs(x = NULL, y = "Incidencia de Tuberculose no Brasil")
    
    ggplotly(ts_pred_plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')
    
  })
  
})