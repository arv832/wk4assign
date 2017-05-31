#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressMessages(library(shiny))
suppressMessages(library(plotly))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Comparing Auto vs Manual Transmission"),
  p("Using the mtcars dataset this interractive page allows you to choose a parameter and view the data as a box plot. We evalualte linear models to compare how accurately your selection is predicted using all remaining variables and compare it with a prediction that uses a standard set of variables (HP, Weight and Transmission Type)."),
  p("Models that explain a lower percentage of the variables will be innacurate when used in prediction."),
  sidebarLayout(
      sidebarPanel(
            radioButtons("col", "Select a parameter to compare Auto and Manual Transmission Types:",
               c("MPG" = 1,
                 "Cylinders" = 2,
                 "Displacement" = 3,
                 "HP" = 4,
                 "Drat" = 5,
                 "Weight" = 6,
                 "QSec" = 7,
                 "Gears" = 10,
                 "Carbs" = 11))
        ),
    mainPanel(
        plotlyOutput("distPlot"),
        textOutput("text")
    )
  )
))
