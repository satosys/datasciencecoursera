
library(shiny)
data(mtmtcars)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Motor Trend Car Road Tests Data Exploration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #Set parameters for varirables
      strong('Histogram parameters'), p(''),
      sliderInput("bins", "Bins for histogram:", min = 1, max = 30, value = 15),
      selectInput('histX', 'Select variable for histogram', names(mtcars), selected = 'Fertility'),
      p(''), 
      p(''), 
      p(''),
      
      #Set parameters for scatterplot
      strong('Scatter plot parameters'), p(''),
      selectInput('scatterX', 'Select x axis for scatter plot', 
                  names(mtcars), selected = 'mpg'),
      selectInput('scatterY', 'Select y axis for scatter plot', 
                  names(mtcars), selected = 'mpg'),
      selectInput('scatterCol', 'Select color for scatter plot', 
                  names(mtcars), selected = 'mpg'),
      
      
      #Describe variables
      strong("Variable Description"),
      tags$ul(
        tags$li('mpg: Miles/(US) gallon'),
        tags$li('cyl: Number of cylinders'),
        tags$li('disp: Displacement (cu.in.)'),
        tags$li('hp: Gross horsepower'),
        tags$li('drat: Rear axle ratio'),
        tags$li('wt: Weight (1000 lbs)'),
        tags$li('qsec: 1/4 mile time'),
        tags$li('vs: V/S'),
        tags$li('am: Transmission (0 = automatic, 1 = manual)'),
        tags$li('gear: Number of forward gears'),
        tags$li('carb: Number of carburetors')
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      p('This app explores the mtcars data, The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)'),
      p(''),
      p('This app allows the exploration of the following:'),
      p('(1) select one variable and the bin size to disply the distribution in a histogram'),
      p('(2) select three variables to disply the corrleation in a scatter plot'),
      
      plotOutput('HistOneVar'),
      plotOutput('ScatThreeVar')
    )
  )
))