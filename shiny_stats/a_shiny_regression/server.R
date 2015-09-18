shinyServer(function(input, output) {
    
  output$plot1 <- renderPlot({
    #set.seed(42)
    library(ggplot2)
    x <- runif(input$npoints)
    er <- rnorm(input$npoints , mean = 0 , sd = input$error)
    y <- input$intercept + input$slope*x + er
    cc <- signif(cor(x,y),3)
    llb1 <- paste("R^2==" , cc)
    qplot(x, y, xlim = c(0,1) , ylim = c(0,100)) +
      stat_smooth( method = 'glm' , family = gaussian ) +
      annotate("text", x = 0.1, y = 100, label = llb1 , parse = TRUE )
  })
  output$plot2 <- renderPlot({
    library(ggplot2)
    x <- runif(input$npoints)
    er <- rnorm(input$npoints , mean = 0 , sd = input$error)
    y <- input$intercept + input$slope*x + er
    cc <- cor(x,y)
    qplot(x, y, xlim = c(0,1) , ylim = c(0,100)) +
      stat_smooth( method = 'glm' , family = gaussian ) +
      annotate("text", x = 0.5, y = 25, label = "Some text")
  })
  output$text1 <- renderText({
    x <- runif(input$npoints)
    er <- rnorm(input$npoints , mean = 0 , sd = input$error)
    y <- input$intercept + input$slope*x + er
    "You have selected this"
    paste("This app is",input$range,"%",input$var,"!!!")
  })
  output$text1 <- renderText({ 
    "You have selected this"
    paste("This app is",input$range,"%",input$var,"!!!")
  })
  
}
)