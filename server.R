#define server function
library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)



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
  
  #filter data 

  
  #plot projection
  output$projections_plot <- renderPlotly({
    
    plot_dat <- filter(projection, type == input$indicators & 
                         reducao == input$reduction)
 
    
    projections_plot <- ggplot(plot_dat) +
      geom_point(aes(x = Year, y = Mean_Forecast)) +
      geom_ribbon(aes(x = Year, ymin = Lower_CI, ymax = Upper_CI), alpha = 0.7) +
      labs(x = NULL, y = "Projecao de Tuberculose no Brasil")
    
    ggplotly(projections_plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')
    
  })
  
})