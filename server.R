#define server function

server <- function(input,output){
  
  output$ts_plot <- renderPlotly({
    
    plot <- ggplot(combined_data_vif_10) +
      geom_point(aes(x = Time, y = !!input$yvar))
    
    ggplotly(plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')
    
    
  })
  
}