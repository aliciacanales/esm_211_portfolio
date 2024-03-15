library(FSA) ## Main dataset
library(FSAdata) ## to use data
library(tidyverse)
library(stringr)
library(janitor)

## Portfolio Questions: 
 
# 1. Compare and contrast the initial population sizes between the three methods
# 2. Why are the Leslie and DeLury methods not valid at estimating N0? 
# 3. What values can you look at to determine the reliability of the data? (Hint: Think back to what we learned about statistics in 206)

##Starting with the leslie method to estimate N0 (inital population size)

## Need depletion data. depletion refers to to the removal of fish
help.search("depletion", package=c("FSAdata","FSA"))

## Using small mouth bass catch and release data and will be determining the intial population 
job_fish <- FSAdata::JobfishSIO
jfish <- job_fish %>% 
  clean_names() ## only has catch and effort data

jfish_mdl <- with(jfish, depletion(catch,effort,method="Leslie",Ricker.mod = TRUE))
summary(jfish_mdl) ## 3.924260e-04
confint(jfish_mdl)
plot(jfish_mdl) ## N0 = 94453

## Moving on to the  method to estimate N0 (inital population size) using the same small mouth bass
delury <- with(jfish, depletion(catch, effort, method="Delury", Ricker.mod = TRUE))
summary(delury) ## 5.128896e-04
confint(delury)
plot(delury) ## N0 = 68963

## Lastly using the K-Pass method to estimate N0 (inital population size) using the same small mouth bass
k_pass <- with(jfish, removal(catch)) 
summary(k_pass) ## 1.38842e-01
confint(k_pass) ## N0 = 69060 and p = .013. P tells us the probability of catch

## the leslie method has a higher initial population, but delury has a lower q

## 2. Why are the Leslie and DeLury methods not valid at estimating N0? 


## 3. What values can you look at to determine the reliability of the data?

## Could look at the confidence intervals to see if there could be overlap
