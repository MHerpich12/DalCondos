library(shiny)
library(ggplot2)

dataset <- read.csv("DalCondos.csv",stringsAsFactors=FALSE)

shinyUI(pageWithSidebar(
  
  headerPanel("Dallas Condos"),
  
  sidebarPanel(
    sliderInput("ziprange","Zipcode:",min=min(dataset$Zipcode),max=max(dataset$Zipcode),value=c(75201,75220),sep=""),
    sliderInput("bedrange","Bedrooms:",min=0,max=max(dataset$Bed),value=c(1,6),step=1,sep=""),
    selectInput('x', 'X', c("Price","Bed","Bath","SqFt","DolPerFt")),
    selectInput('y', 'Y', c("Price","Bed","Bath","SqFt","DolPerFt")),
    selectInput('color', 'Color', c("Name","Price","Bed","Bath","SqFt","DolPerFt")),
    h4('Average Price ($000s):'),
    verbatimTextOutput("meanPrice"),
    h4('Average Sq Footage:'),
    verbatimTextOutput("meanSqFt"),
    h4('Average $/Ft:'),
    verbatimTextOutput("meanDolPerFt")
  ),
  
  mainPanel(
    plotOutput('plot'),
    plotOutput('plot2')
  )
)
)