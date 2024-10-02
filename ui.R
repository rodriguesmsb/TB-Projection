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

df <- readRDS("data.rds")

#Deine UI for app
shinyUI(
  page_fluid(
    theme = theme,
    #add title page
  
    #create navset fill
    accordion(  
    
    #add panel for descripton
        accordion_panel( 
          title = "About", 
          icon = bsicons::bs_icon("book-half"),
      
          "Some nice text about app"),
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
                data = df %>% select(c(HIV_Positive,DOT,BCG_Rates)))),
            card(plotlyOutput(outputId = "ts_plot")))
          )
        )
    )
  )