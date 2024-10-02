library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)


#create a main theme
theme <- bs_theme(
  bootswatch = "united",
  base_font = font_google("Inter"),
  navbar_bg = "blue"
)

#customize h1 title
style_h1 <- "color:green; font-weight: bold;"

df <- readRDS("data.rds")

#Deine UI for app
shinyUI(
  
  page_fluid(
    theme = theme,
    #add title page
  titlePanel(
    h1("Impact of Strategic Public Health Interventions to Reduce Tuberculosis 
              Incidence in Brazil: A Bayesian Structural Time-Series Scenario Analysis",
       align = "center", style = style_h1)),
    
  
    #create navset fill
    accordion(  
    
    #add panel for descripton
        accordion_panel( 
          title = "Sobre o Projeto", 
          icon = bsicons::bs_icon("book-half"),
      
          "Apresentar um breve resumo sobre o projeto"),
        #add panel for descriptive analys
    
        accordion_panel( 
          title = "Serie temporal dos descritores", 
          icon = bsicons::bs_icon("graph-up"),
          
          #create a sidebar
          page_sidebar(
            sidebar = sidebar(
              #create a box to select input
              varSelectInput(
                inputId = "predictors",
                label = "Select one variable",
                data = df %>% select(c(HIV_Positive,DOT,BCG_Rates))),
              bg = "blue"),
            
            #create a layout with two columns for booth graphs
            layout_columns(
              card(plotlyOutput(outputId = "ts_plot")),
              card(plotlyOutput(outputId = "ts_plot_tb_inc")))
            )
            
          )
        )
    )
  )
#rsconnect::deployApp()

