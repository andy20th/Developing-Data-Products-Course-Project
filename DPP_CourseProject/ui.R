#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

# Documentation: 
# This Shiny Web app uses the advertising.csv dataset to create a prediction for sales for a user definable marketing mix. 
# The user can specify may specify marketing spending across 3 different channels, TV, Radio, and Newspaper.
# A multiple linear regression model is trained to make the prediction.
# - The advertising dataset can be obtained from Kaggle https://www.kaggle.com/bumba5341/advertisingcsv
# - The ui.R file allows selection of information regarding to different channels via checkboxes and selection of the prediction via sliders
# - The server.R file contains the code for the model
# - Predictions are displayed in the main window of ui.R

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Marketing Plan: How should marketing dollars be spent"),
        
        # Sidebar with checkboxes to select plotting of information regarding to separate channels and slider input for prediction
        sidebarLayout(
                sidebarPanel(
                        h4("Show marketing channels"),    
                        checkboxInput("TV", "Hide/Show relationship with sales of TV", value=TRUE),
                        checkboxInput("Radio", "Hide/Show relationship with sales of Radio", value=TRUE),
                        checkboxInput("Newspaper", "Hide/Show relationship with sales of Newspaper", value=TRUE),
                        h4("Select spending per channel:"),
                        sliderInput("sliderTV","TV spending",value=0,min=0,max=300,step=1),
                        sliderInput("sliderRadio","Radio spending",value=0,min=0,max=50,step=1),
                        sliderInput("sliderNewspaper","Newspaper spending",value=0,min=0,max=100,step=1)
                ),
                
                
                mainPanel(
                        # Show selected plot
                        h4("Relation of spending to sales per channel"),
                        plotOutput("distPlot"),
                        
                        #plot the prediction of the mulitple linear regression
                        h4("Predicted sales"),
                        textOutput("pred") 
                )
        )
))
