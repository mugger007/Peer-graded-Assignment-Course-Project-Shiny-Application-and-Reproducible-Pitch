#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Horsepower from Weight"),
    sidebarLayout(
        sidebarPanel(
            helpText('Provide information about the weight and the prediction model that you want.'),
            sliderInput("sliderWT",
                        "Weight of the car:",
                        min = 1,
                        max = 6,
                        value = 2.5,
                        step = 0.1),
            checkboxInput("showModel1",
                        "Show/Hide Model 1",
                        value = TRUE),
            checkboxInput("showModel2",
                          "Show/Hide Model 2",
                          value = TRUE),
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Horsepower from Model 1:"),
            textOutput("pred1"),
            h3("Predicted Horsepower from Model 2:"),
            textOutput("pred2"),
        )
    )
))
