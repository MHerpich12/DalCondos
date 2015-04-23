library(shiny)
library(ggplot2)
library(swirl)
library(caret)

dataset <- read.csv("DalCondos.csv",stringsAsFactors=FALSE)

shinyServer(function(input,output) {
  
  filtdata <- reactive({
      subdata1 <- subset(dataset,Zipcode>=min(input$ziprange) & Zipcode<=max(input$ziprange))
      subdata2 <- subset(subdata1,Bed>=min(input$bedrange)&Bed<=max(input$bedrange))
      subdata2
  })
  output$meanPrice <- renderText(mean(filtdata()[["Price"]]))
  output$meanSqFt <- renderText(mean(filtdata()[["SqFt"]]))
  output$meanDolPerFt <- renderText(mean(filtdata()[["DolPerFt"]]))
  output$plot <- renderPlot(qplot(filtdata()[[input$x]],filtdata()[[input$y]],color=filtdata()[[input$color]],xlab=input$x,ylab=input$y))
  output$plot2 <- renderPlot(hist(filtdata()[[input$x]],xlab=input$x,col="blue"))
})
