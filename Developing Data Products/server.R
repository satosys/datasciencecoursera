library(shiny)
library(ggplot2)
data(mtcars)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #----- PART I: HISTOGRAM
  # Extract the column of interest from the mtcars data and save the column
  # Reactive is used like a function!
  
  histVal <- reactive({
    mtcars[, input$histX]
  })
  
  # Make the histogram
  output$HistOneVar <- renderPlot({
    hist(mtcars[, input$histX],
         breaks = seq(min(histVal()) , max(histVal()), length.out = input$bins + 1),
         #set the breaks according the the bins
         #ge the min and max for each column - call histVal AS A FUNCTION!
         xlab = input$histX, 
         main = paste('Distribution of', input$histX),
         col = 'darkgray', border = 'white')
  })
  
  
  #----- PART II: SCATTER PLOT
  #Extract the columns of interst from the mtcars data and save the data
  scatX <- reactive({
    mtcars[, input$scatterX]
  })
  
  scatY <- reactive({
    mtcars[, input$scatterY]
  })
  
  scatCol <- reactive({
    mtcars[, input$scatterCol]
  })
  
  # Make the scatter plot
  output$ScatThreeVar <- renderPlot({
    ggplot(data = mtcars, aes(x = scatX(), y = scatY(), color = scatCol())) +
      geom_point() +
      xlab(input$scatterX) + ylab(input$scatterY) +
      labs(colour = input$scatterCol) +
      ggtitle(paste('Scatter plot of', input$scatterX, 'vs', input$scatterY)) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  
})