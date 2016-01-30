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
                     "Genre" = "Genre")),
    
    actionButton("imdbVotes", "Calculate imdbVotes Average"),
    p("Click the button to calculate the Average imdbVotes in the Calculate averages panel."),
    
    actionButton("Metascore", "Calculate Metascore Average"),
    p("Click the button to calculate the Average Metascore in the Calculate averages panel."),
    
    actionButton("imdbRating", "Calculate imdbRating Average"),
    p("Click the button to calculate the Average imdbRating in the Calculate averages panel.")
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    tabsetPanel(
    tabPanel("Plot", 
             plotOutput("moviePlot")), 
    tabPanel("Top10",
             dataTableOutput("mytable2")),
    tabPanel("Calculate Averages",
             verbatimTextOutput("imdbVotesText"),
             p("Average imdbVotes"),
             verbatimTextOutput("MetascoreText"),
             p("Average Metascore"),
             verbatimTextOutput("imdbRatingText"),
             p("Average imdbRating")
             ),
    tabPanel("Instructions", 
      htmlOutput('instructions'))
    
    )
  )
))