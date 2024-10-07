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
)


#fix colors in input using css
css <- "
.selectize-dropdown-content .option {
    color: white;
}
    
.selectize-input .item {
   color: white !important;
}
"


#customize h1 title
style_h1 <- "color:#86C232; font-weight: bold; font-size:52px"
style_p <- "color:#ffffff; font-weight: normal; font-size:20px"

load("objects.RData")



#Deine UI for app
shinyUI(
  
  page_fluid(
    theme = theme,
    tags$head(
      tags$style(HTML(css))
    ),
    #add title page
  titlePanel(
    h1("Avaliação do Impacto de Intervenções de Saúde Pública para Reduzir 
        a Incidência da Tuberculose no Brasil",
       align = "center", style = style_h1)),
    
  
    #create navset fill
    accordion(  
    
    #add panel for descripton
        accordion_panel( 
          title = "Sobre o Projeto", 
          icon = bsicons::bs_icon("book-half"),
      
          p("Bem-vindo à nossa Plataforma de Previsão de Incidência de TB, uma 
          ferramenta avançada projetada para auxiliar profissionais e gestores 
          de saúde pública a avaliarem como melhorias nos preditores-chave de 
          Tuberculose podem reduzir as taxas de incidência nacional nos próximos 
          anos. Baseada em um modelo robusto, desenvolvido a partir de dados 
          nacionais de vigilância epidemiológica, essa plataforma oferece 
          projeções dinâmicas da incidência de TB sob diversos cenários 
          estratégicos. Através de uma interface intuitiva de visualização de 
          dados, os usuários podem simular como melhorias anuais em indicadores 
          essenciais de controle da Tuberculose e reduções no número casos da 
          doença em populações vulnerabilizadas, podem ser eficazes em diminuir 
          as projeções da incidência de Tuberculose até 2030. Os cenários variam 
          desde intervenções mais conservadoras (melhorias anuais de 5% nos indicadores) 
          até estratégias ambiciosas (melhorias anuais de até 30%), permitindo uma 
          análise aprofundada e diferenciada de como intervenções direcionadas podem 
          influenciar a trajetória da doença. Esta plataforma oferece uma 
          base sólida para o planejamento estratégico e a formulação de 
          políticas públicas eficazes, com o objetivo de reduzir a TB e avançar 
          em direção às metas globais de eliminação da doença. Além disso, 
          funciona como uma poderosa ferramenta de divulgação científica e 
          visualização de dados, ampliando o acesso e o impacto dos resultados 
          apresentados em nosso estudo: Avaliação do Impacto de Intervenções de 
          Saúde Pública para Reduzir a Incidência da Tuberculose no Brasil:
          Uma Analise Bayesiana de Cenário em Séries-Temporais, atualmente 
          sob revisão na prestigiada revista The Lancet: Regional Health Americas.",
            align = "justify", style = style_p)),
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
              bg = "#F5F5F5",
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
                choices =  c("Baseline","Pop_vul","All","Combined"),
                selected = "Baseline"),
            
            #reduction selector
            selectizeInput(
              inputId = "reduction",
              label = "Reduzido em:",
              choices =  c(0,5,10,20,30
              )),
            bg = "#F5F5F5",
            border_raidus = TRUE),
            
            #create a card for plot
            card(plotlyOutput(outputId = "projections_plot")))
          )
        )
  )
  )
