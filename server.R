#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

suppressMessages(library(shiny))
suppressMessages(library(GGally))
suppressMessages(library(plotly))
suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
data(mtcars)
mtcars$am <- factor(mtcars$am,labels=c('Automatic','Manual'))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$distPlot <- renderPlotly({
        # draw the boxplot of Auto vs Manual cars for the chosen variable
        plot_ly(mtcars,x=mtcars$am,y=mtcars[,as.integer(input$col)],type="box",color=mtcars$am)
        })
        output$text <- renderText({ paste("The Automatic transmission cars have a mean value of ",
                round(mean(mtcars[mtcars$am=="Automatic",as.integer(input$col)]),2),
                " and the Manual transmission cars a mean value of ",
                round(mean(mtcars[mtcars$am=="Manual",as.integer(input$col)]),2),
                ". We create a linear model to predict your selection using all variables and compare it with a standard model. The model that predicts your selection using all variables explains ",
                round(summary(lm(as.formula(paste(colnames(mtcars)[as.integer(input$col)], "~",
                                       paste(colnames(mtcars)[c(-as.integer(input$col))], collapse = "+"),
                                       sep = "")),data=mtcars))$r.squared * 100,2),
                "% of the variables compared with our standard model using HP WT and Transmission Type to explain ",
                round(summary(lm(as.formula(paste(colnames(mtcars)[as.integer(input$col)], "~ hp + wt + factor(am)",sep="")),data=mtcars))$r.squared * 100,2),
                "% of the variables.",sep="")  
            })
})
