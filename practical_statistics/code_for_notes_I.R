#Notes on practical statistics I: accompanying code

#You first need to set the working directory (this is where your
#script will look for files etc...):
setwd("~/repos/statistical_inference/practical_statistics/")
#You can also get your working directory printed to the console:
getwd()

#Load necessary libraries
library(ggplot2)
library(GGally)

###NOTE --  run the following and look at your console:
help(getwd)
###You should see an explanation of the getwd function: the 'help' command will
###be one of your best friends! It will tell you what many R commands do.


###########################################
###LOADING & PLAYING WITH DATA
###########################################
#Method 1: load data from file
#Load some data:
df <- read.csv("mm.csv") #read in a .csv as a dataframe

#Plot using ggplot
p <- ggplot( data = df , aes( x = factor(Expt) , y = Speed)) # initializes the ggplot plot 
#for more on factors, see http://www.stat.berkeley.edu/~s133/factors.html
#to quote, "Conceptually, factors are variables in R which take on a limited number of different values;
#such variables are often refered to as categorical variables."
p + geom_point() #plot a scatterplot
p + geom_boxplot() #plot a boxplot
#already, you can see some interesting things!
#Maybe you want to change the label on the x-axis? Then try
p + geom_boxplot() + xlab("Experiment")

#Method 2: load data from R (there are already datasets in R!)
cars <- mtcars #pre-existingdataset in R
p1 <- ggplot(data = cars , aes(x=mpg)) #initialize plot to look at miles per gallon
p1 + geom_histogram( binwidth = 1 ) #plot histogram & play around with binwidth if desired

ggpairs(cars) #plot how all features relate to each other: takes time to load
ggpairs(diamonds) #do the same for another inbuilt dataset

#Method 3: generate your own data
set.seed(42) #set seed for reproducible results!
#Draw data drawn from a Gaussian (normal) distribution & plot
xn <- rnorm( n = 1000 , mean = 0 , sd = 1) #sample Gaussian
hist(xn) #plot histogram
qplot(xn , binwidth = 0.5) #now plot histogram using ggplot: nicer!
qplot( xn , stat = "ecdf" , geom = "step")  #plot empirical cdf
qplot( "type", xn , geom = "boxplot")  #plot boxplot

#Now we turn this vector x into a dataframe
df <- as.data.frame( xn )
df$type = 1 #create a new column called 'type', in case we want to add additional, different data later
pn <- ggplot(data = df , aes(x = xn)) #initialize plot
pn + geom_histogram( binwidth = 0.5) #plot histogram
pn + stat_ecdf() #plot ecdf

pn <- ggplot(data = df , aes(x = type , y = xn)) #initialize plot with type on x-axis, value on y-axis
pn + geom_boxplot()

##plot a pdf:
xdata <- seq(-3,3 , by = 0.01) #create a vector, specifying endpoints & step-size
ydata <- dnorm( x = xdata , mean = 0 , sd = 1) #vector of P(xdata), where P is Gaussian
qplot(xdata , ydata ) #plot density function

#Draw data drawn from exponential & gamma distributions & plot
x1 <- rexp(n = 1000 , rate = 1) #sample exponential distribution
x2 <- rgamma(n = 1000 , shape = 1 , rate = 1) #sample gamma distribution (shape = 1: exponential)
x3 <- rgamma(n = 1000 , shape = 3 , rate = 1) #sample gamma distribution

##combine these data into a single dataframe with a column labelling the different samples
df1 <- as.data.frame( x1 ) #turn vector into dataframe
colnames(df1) = 'value' #change column names
df2 <- as.data.frame( x2 ) #turn vector into dataframe
colnames(df2) = 'value' #change column names
df3 <- as.data.frame( x3 ) #turn vector into dataframe
colnames(df3) = 'value' #change column names
df1$type <- 1 #create a new column called 'type'
df2$type <- 2 #create a new column called 'type'
df3$type <- 3 #create a new column called 'type'
df <- rbind(df1,df2,df3) #build dataframe from these data

#plot histogram of exponentially distributed data
ph1 <- ggplot( df1 , aes( x = value)) #initialize plot
ph1 + geom_histogram() #plot histogram
ph1 + geom_histogram(binwidth = 1.5) #play around with binwidth

#plot histogram of gamma distributed data
ph3 <- ggplot( df3 , aes( x = value)) #initialize plot
ph3 + geom_histogram() #plot histogram
#play around with binwidth to see why it is so important:
ph3 + geom_histogram( binwidth = 2.5)

#plot ecdf
ph3 + stat_ecdf()

#plot all data just generated (exponential & gamma & gamma) 
p <- ggplot(df , aes( x = factor(type) , y=value )) #initialize plot
p + geom_point() #scatterplot (you really want a beeswarm but we won't do this here)
p + geom_boxplot() #boxplot

#Note -- see here for common, useful R commands:
#http://personality-project.org/r/r.commands.html

###########################################
###THE CENTRAL LIMIT THEOREM
###########################################


##Here we perform a simple demonstration of the Central Limit Theorem
##Random Variable defined by p(0)=p(1)=0.5. Draw n samples (e.g. n = 1000)
##& retrieve the mean. Do this m times (e.g. m = 10,000) and plot 
##the distribution of means:
n <- 1000 #number of samples for each trail
m <- 10000 #number of trails
x <- rbinom( m , n , 0.5 )/n # sample distribution and return vector of means
qplot(x , binwidth = 0.005) #plot histogram of means
#also plot the Gaussian with mean, SD given by the data stored in x
