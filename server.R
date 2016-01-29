library(shiny)
library(ggplot2)


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("Movie ~", input$variable)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$moviePlot <- renderPlot({
    if(input$variable == "imdbRating"){
    qplot(Title, weight = imdbRating, data =top10imdb, geom = "bar", ylab = "imdb Rating")
    }else if(input$variable == "Metascore"){
      qplot(Title, weight = Metascore, data =top10imdb, geom = "bar", ylab = "Metascore")
    }else if(input$variable == "imdbVotes"){
      qplot(Title, weight = imdbVotes, data =top10imdb, geom = "bar", ylab = "imdb Votes")
    }else if(input$variable == "Genre"){
      qplot(Genre_1, weight = imdbVotes, data =top10imdb, geom = "bar", ylab = "imdb Votes")
    }
  })
  
  output$mytable2 = renderDataTable({
    top10imdb
  }, options = list(orderClasses = TRUE))
  
  output$instructions <- renderText({  
    readLines("instructions.html")  
  })
})