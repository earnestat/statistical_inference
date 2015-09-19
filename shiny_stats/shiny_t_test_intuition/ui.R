shinyUI(fluidPage(
  #App Title
  titlePanel("playing with t-tests (prototype)"),
  #Sidebar with slider
  sidebarLayout(position = "right" ,
    sidebarPanel( h3("play with parameters here:") ,
                  #helpText("How many data points?"),
                  numericInput("npoints", 
                              label = "How many data points?",
                              value = 10),
                  #helpText("with what degree of confidence?"),
                  selectInput("conf", 
                              label = "with what degree of confidence (%)?",
                              choices = c("90", "95",
                                          "99", "99.9"),
                              selected = "99"),
                  sliderInput("xlow_lim",
                              "plotting x-axis lower limit:",
                              min = -4,
                              max = 0, 
                              step = 0.1,
                              value = -4),
                  sliderInput("xup_lim",
                              "plotting x-axis upper limit:",
                              min = 0,
                              max = 4,
                              step = 0.1,
                              value = 4),
                  sliderInput("yup_lim",
                              "plotting y-axis upper limit:",
                              min = 0,
                              max = 0.4,
                              value = 0.4)
                  ),
    mainPanel(plotOutput("plot1"),
p('Here I am giving an intuition towards the one-sample t-test 
                (e.g. if the result of the control is known
                and the experiment at hand is a mutant): see how i) the amount of data you have,
                ii) the amount of confidence with which you wish to state your result
                & iii) the standard deviation of the parent distribution are related.'),

p('You choose i) the number of data points, ii) the confidence with which you wish to state you results &
                iii) plotting limits. I then plot the probability of seeing any given effect size,
                measured in standard deviations away from the (null) hypothesized mean.') ,
p('I have also shaded in
                red the effect sizes that are not statistically significant, given the amount of data
                and the required confidence you have chosen. For example, with n = 10 data points, we can state
                with 99% confidence that an effect size is statistically significant if and only it is at 
                least 1 standard deviation (of the parent distribution) away from the hypothesized mean (n.b.
                in a future iteration of this app I will mathematize all of this.) 
                ')
              )
  )
)
  
)