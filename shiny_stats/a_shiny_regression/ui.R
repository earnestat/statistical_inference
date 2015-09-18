shinyUI(fluidPage(
  #App Title
  titlePanel("playing with linear regression"),
  #Sidebar with slider
  sidebarLayout(position = "right" ,
    sidebarPanel( h3("play with parameters here:") ,
                  helpText("How many data points?"),
                  selectInput("npoints", 
                              label = "you choose",
                              choices = c("10", "50",
                                          "100", "500"),
                              selected = "50"),
                  sliderInput("slope",
                              "slope:",
                              min = 1,
                              max = 50,
                              value = 30),
                  sliderInput("intercept",
                              "intercept:",
                              min = 0,
                              max = 50,
                              value = 0),
                  sliderInput("error",
                              "error standard deviation:",
                              min = 0,
                              max = 20,
                              value = 5)
                  ),
    mainPanel(p('here you can generate data consisting of an
                independent and dependent variable: you choose
                i) the number of data points, ii) the slope, iii)
                the offset & iv) the i.i.d gaussian error standard deviation;
                we fit a linear model to it, display it and tell you the 
                correlation coefficient. Get a feel for how the error, slope
                and correlation coefficient are related by playing.'),
      plotOutput("plot1")
              )
  )
)
  
)