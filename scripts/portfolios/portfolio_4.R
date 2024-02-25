#Comparing Time Lags for Bison Population Modeling

#download glarma and library 
install.packages(glarma)
library(glarma)
library(here)
library(dplyr)
library(tidyverse)

#load in the bison data
bison<- read_csv(here('data', 'bison.csv'))
  
#add an intercept 
bison$intercept<-as.integer(1)

#Identify variables
y <- bison$bison # y value is bison counts
x0 <- bison %>% 
  select(intercept) 
x0 <- as.matrix(x0) # turns x0 into a matrix 

#Create three glarma models that have a time lag of 1, 2, and 7
bison_null_lag <- glarma(y, x0, phiLags = c(1), type = "Poi", method = "FS",
                              residuals = "Pearson", maxit = 100, grad = 1e-6)
bison_lag_2 <- glarma(y, x0, phiLags = c(2), type = "Poi", method = "FS",
                         residuals = "Pearson", maxit = 100, grad = 1e-6)
bison_lag_7 <- glarma(y, x0, phiLags = c(7), type = "Poi", method = "FS",
                         residuals = "Pearson", maxit = 100, grad = 1e-6)

# 1. Visually compare the plots. Which looks like the best fit?
plot.glarma(bison_lag_7) #if you have an error in plot.window for the last plot, it's okay to ignore 

##Lag 2 looks like the better fit

# 2. Compare the AIC for the models. Which is actually the best fit? 
summary(bison_null_lag) ## AIC 7200.3
summary(bison_lag_2) ## AIC 6684.275
summary(bison_lag_7) ## AIC 14214.01

## Checks out the lag 2 is the better fit

# 3. Create a model with major events factored in and compare it with the best fit model identified in question 2. Is the model with major events a better fit? 

#Add intercept and major events
bison$major_events <- as.integer(0)

bison$major_events[bison$year==1995] <- 1 # reintroduction of wolves to yellowstone NP

bison$major_events[bison$year==1988] <- 1 # 1988 Yellowstone Fire

#Identify variables
x1 <- bison %>% select(intercept, major_events) # x1 explanatory variables, presence of major events
x1 <- as.matrix(x1) #turns x1 into a matrix

#Create the model with major events. Make the lag the same as the best fit model from question 2 

## changed the lag to 2 since that was the best fit model from above
bison_exp_lag <- glarma(y, x1, phiLags = c(2), type = "Poi", method = "FS", 
                             residuals = "Pearson", maxit = 100, grad = 1e-6)
#summary 
summary(bison_exp_lag) ## AIC: 6265.411 

## This model is now the best fit model


#extra if you're feeling spry 
#Plots the model (black) and the bison count data (gray)

bison_mod <- bison 

bison_mod$est <- bison_exp_lag$fitted.values #adds fitted values

bison_plot<-ggplot(bison_mod, aes(x=year)) + 
  geom_point(col="gray",aes(y=bison),size=3) + 
  geom_point(col="black",aes(y=est),size=3) +
  geom_line(col="black",aes(y=est)) +
  labs(x="Year", y="Bison Population") +
  ylim(0,4100) + xlim(1970,1997)+
  theme_bw()

#Adds two red horizontal lines for the occurrence of fire and reintroduction of wolves
bison_plot <-bison_plot + 
  annotate("rect", xmin = 1988, xmax =1988.1, ymin = 0, ymax = 4100, alpha = .75,fill = "red") + 
  annotate("rect", xmin = 1995, xmax =1995.1, ymin = 0, ymax = 4100, alpha = .75,fill = "red")
