# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        #conditional plotting of the information regarding separate channels depending to selected checkboxes
        output$distPlot <- renderPlot({
                plotnum<-sum(input$Radio,input$TV,input$Newspaper)
                par(mfrow=c(1,plotnum))    
                if(input$TV==TRUE) 
                {      
                        #par(mfrow=c(1,3))
                        plot(ad.data$TV,ad.data$Sales,col="red",xlab="TV spending",ylab="Sales")
                        abline(lm(ad.data$Sales~ad.data$TV),col="red")
                }
                if(input$Radio==TRUE)
                {
                        plot(ad.data$Radio,ad.data$Sales,col="blue",xlab="Radio spending",ylab="Sales")
                        abline(lm(ad.data$Sales~ad.data$Radio),col="blue")
                }
                if(input$Newspaper==TRUE) 
                {
                        plot(ad.data$Newspaper,ad.data$Sales,col="green",xlab="Newspaper spending",ylab="Sales")
                        abline(lm(ad.data$Sales~ad.data$Newspaper),col="green")
                }
        })
        
        # Training the multiple linear regression model and prediction in a reactive statement
        modelpred<-reactive({
                model<-lm(Sales~TV+Radio+Newspaper,data=ad.data)
                newdata<-data.frame(TV=input$sliderTV, Radio=input$sliderRadio, Newspaper=input$sliderNewspaper)
                predict(model,newdata)
        })
        output$pred<-renderText({modelpred()}) #the prediction is prepared for output in ui.R
})