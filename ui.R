library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("iflix top 10 movies by:"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("imdbRating" = "imdbRating", 
                     "Metascore" = "Metascore", 
                     "imdbVotes" = "imdbVotes",
                     "Genre" = "Genre"))
    
    
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    tabsetPanel(
    tabPanel("Plot", plotOutput("moviePlot")), 
    tabPanel("Top10",
             dataTableOutput("mytable2")),
    tabPanel("Instructions", 
      htmlOutput('instructions'))
    
    )
  )
))