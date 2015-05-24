library(shiny)
library(ggplot2)

dataset <- read.csv("ListingData.csv",stringsAsFactors=FALSE)

shinyUI(pageWithSidebar(
  
  headerPanel("Dallas Listings"),
  
  sidebarPanel(
    sliderInput("pricerange","Price ($000s):",min=min(dataset$Price),max=max(dataset$Price),value=c(0,100000),sep=""),
    sliderInput("ziprange","Zipcode:",min=min(dataset$Zipcode),max=max(dataset$Zipcode),value=c(75201,75253),sep=""),
    sliderInput("bedrange","Bedrooms:",min=0,max=max(dataset$Beds),value=c(1,10),step=1,sep=""),
    selectInput('x', 'X', c("Beds","Baths","Size","Zipcode","Price","DolPerFt")),
    selectInput('y', 'Y', c("Beds","Baths","Size","Zipcode","Price","DolPerFt")),
    selectInput('color', 'Color', c("","Neighborhood","Type"))
  ),
  
  mainPanel(
    h4('Number of Listings:'),
    verbatimTextOutput("numListings"),
    h4('Average Price ($000s):'),
    verbatimTextOutput("meanPrice"),
    h4('Average Sq Footage:'),
    verbatimTextOutput("meanSqFt"),
    h4('Average $/Ft:'),
    verbatimTextOutput("meanDolPerFt"),
    plotOutput('plot')
  )
)
)