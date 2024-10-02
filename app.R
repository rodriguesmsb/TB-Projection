library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)


theme <- bs_theme(
  bootswatch = "darkly",
  base_font = font_google("Inter"),
  navbar_bg = "#25443B"
)



#Deine UI for app
ui <- page_fluid(
  
  #add title page
  
  #create navset fill
  accordion(  
    
    #add panel for descripton
    accordion_panel( 
      title = "About", 
      icon = bsicons::bs_icon("book-half"),
      
      "Some nice text about app"
      
     
    ),
    
    #add panel for descriptive analys
    
    accordion_panel( 
      title = "About", 
      icon = bsicons::bs_icon("graph-up"),
      #create a sidebar
      page_sidebar(
        sidebar = sidebar(
            #create a box to select input
            varSelectInput(
              inputId = "yvar",
              label = "Select one variable",
              data = combined_data_vif_10 %>% select(c(HIV_Positive,DOT,BCG_Rates))

            )
        ),
        card(plotlyOutput(outputId = "ts_plot"))
        )
      )
    )
)

#define server function

server <- function(input,output){
  
  output$ts_plot <- renderPlotly({

    plot <- ggplot(combined_data_vif_10) +
      geom_point(aes(x = Time, y = !!input$yvar))

    ggplotly(plot) %>% layout(paper_bgcolor='rgb(254, 247, 234)') %>%
      layout(plot_bgcolor='rgb(254, 247, 234)')


  })
  
}

shinyApp(ui = ui, server = server)

