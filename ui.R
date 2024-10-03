library(shiny)
library(bslib)
library(tidyverse)
library(tibble)
library(plotly)
library(magrittr)



#create a main theme
theme <- bs_theme(
  bootswatch = "darkly",
  base_font = font_google("Inter"),
  navbar_bg = "blue"
)


#customize h1 title
style_h1 <- "color:#61892F; font-weight: bold;"

load("objects.RData")



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
              tags$style(styles_selector),
              #using var slect to select columns
              varSelectInput(
                inputId = "predictors",
                label = "Select one variable",
                data = df %>% select(c(HIV_Positive,DOT,BCG_Rates))),
              bg = "#61892F",
              border_raidus = TRUE),
            
            #create a layout with two columns for booth graphs
            layout_columns(
              card(plotlyOutput(outputId = "ts_plot")),
              card(plotlyOutput(outputId = "ts_plot_tb_inc")))
            )
            
          ),
        accordion_panel(
          title = "Cenarios avaliados", 
          icon = bsicons::bs_icon("zoom-in"),
          #create a sidebar
          page_sidebar(
            sidebar = sidebar(
              tags$style(styles_selector),
              
              #using select input fo select rows
              selectizeInput(
                inputId = "indicators",
                label = "Selecione um indicador",
                choices =  c("Baseline","Pop_vul","All","Combined")),
            
            #reduction selector
            selectizeInput(
              inputId = "reduction",
              label = "Reduzido em:",
              choices =  c(0,5,10,20,30
              )),
            bg = "#61892F",
            border_raidus = TRUE),
            
            #create a card for plot
            card(plotlyOutput(outputId = "projections_plot")))
          )
        )
  )
  )


