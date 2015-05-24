library(shiny)
library(ggplot2)
library(swirl)
library(caret)

options(warn=-1)
dataset <- read.csv("ListingData.csv",stringsAsFactors=FALSE)

shinyServer(function(input,output) {
  
  filtdata <- reactive({
    subdata1 <- subset(dataset,Zipcode>=min(input$ziprange) & Zipcode<=max(input$ziprange))
    subdata2 <- subset(subdata1,Beds>=min(input$bedrange)&Beds<=max(input$bedrange))
    subdata3 <- subset(subdata2,Price>=min(input$pricerange)&Price<=max(input$pricerange))
    subdata3$Size <- as.numeric(subdata3$Size)
    subdata3$DolPerFt <- as.numeric(subdata3$DolPerFt)
    subdata3
  })

  
  output$numListings <- renderText(length(as.numeric(filtdata()[["Price"]])))
  output$meanPrice <- renderText(mean(as.numeric(filtdata()[["Price"]])))
  output$meanSqFt <- renderText(mean(as.numeric(filtdata()[["Size"]])[!is.na(as.numeric(filtdata()[["Size"]]))]))
  output$meanDolPerFt <- renderText(mean(as.numeric(filtdata()[["DolPerFt"]])[!is.na(as.numeric(filtdata()[["DolPerFt"]]))]))
  output$plot <- renderPlot(qplot(filtdata()[[input$x]],filtdata()[[input$y]],color=filtdata()[[input$color]],xlab=input$x,ylab=input$y)+theme(text=element_text(size=10)))
})
