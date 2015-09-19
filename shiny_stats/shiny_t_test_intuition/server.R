shinyServer(function(input, output) {
  
  output$plot1 <- renderPlot({
    #set.seed(42)
    library(ggplot2)
    n <- input$npoints
    t <- seq(-4,4, by = 0.01)
    y <- dt(t*sqrt(n) , df = n-1)
    df <- as.data.frame(cbind(t,y) )
    colnames( df) <- c("t" , "y")
    alpp <- as.numeric(input$conf)/100
    #alpha <- 0.5
    interval <- 1 - (1 - alpp)/2
    #interval <- 0.1
    lo1 <- -qt(interval , df = n-1 )/sqrt(n)
    up1 <-  qt(interval , df = n-1 )/sqrt(n)
    yo  <- ifelse( t < up1 & t > lo1, t , 0 )
    df$yo <- yo
    ggplot( df , aes( x=t , y=y )) + 
      geom_line()+
      geom_area(mapping = aes( yo ) , fill = "red") +
      scale_y_continuous(limits = c(0, input$yup_lim)) +
      scale_x_continuous(limits = c(input$xlow_lim , input$xup_lim))  +
      xlab("Estimated effect size (measured in standard deviations away from the 
           (null) hypothesized mean)") +
      ylab("Probability")
  })
}
)