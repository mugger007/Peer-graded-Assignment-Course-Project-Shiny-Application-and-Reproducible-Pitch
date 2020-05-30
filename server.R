#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
    mtcars$wtsp<-ifelse(mtcars$wt-2.5>0,mtcars$wt-2.5,0)
    model1<-glm(hp~wt,data=mtcars)
    model2<-lm(hp~wtsp+wt,data=mtcars)
    model1pred<-reactive({
        wtInput<-input$sliderWT
        predict(model1,newdata=data.frame(wt=wtInput))
    })
    model2pred<-reactive({
        wtInput<-input$sliderWT
        predict(model2,newdata=data.frame(wt=wtInput,
                                          wtsp=ifelse(wtInput-2.5>0,wtInput-2.5,0)))
    })
    output$plot1<-renderPlot({
        wtInput<-input$sliderWT
        plot(mtcars$wt,mtcars$hp,xlab='Weight',ylab='Horsepower',bty='n',pch=16,xlim=c(1,6))
        if(input$showModel1){
            abline(model1,col='red',lwd=2)
            points(wtInput,model1pred(),col='red',pch=16,cex=2)
        }
        if(input$showModel2){
            model2lines<-predict(model2,newdata=data.frame(wt=1:6,wtsp=ifelse(1:6-2.5>0,1:6-2.5,0)))
            lines(1:6,model2lines,col='blue',lwd=2)
            points(wtInput,model2pred(),col='blue',pch=16,cex=2)
        }
        legend(5,100,c('Model 1 Prediction','Model 2 Prediction'),bty='n',pch=16,col=c('red','blue'),cex=1.2)
    })
    output$pred1<-renderText({
        model1pred()
    })
    output$pred2<-renderText({
        model2pred()
    })
})
