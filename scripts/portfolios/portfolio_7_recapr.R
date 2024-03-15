#script for simple mark recapture
#Feb 12 2024
#alicia canales
##################################

library(here)
library(tidyverse)
library(recapr)


# 'recapr' package https://cran.r-project.org/web/packages/recapr/recapr.pdf

## This package estimates the numerical counts of something

n1<-75 # number of individuals marked in the first sampling
n2<-59 # number of individuals captured in the second sampling effort
m2<- 7 # number of individuals in the second sampling effort that were marked.
  
# Runs the model, get the estimate of N and calculates a confidence interval
NPetersen(n1, n2, m2) # estimates the population size as 632.1429
ciPetersen(n1,n2,m2)  # 95% CIs using normal approximation ($ciNorm) and bootstrapping ($ciBoot) CI being 368.75 and 1475.00

# Sample size recommendation
n2RR(N=8000, n1=75)
plotn2sim(N=8000, n1=75)


#Sass et al. (2010) Silver carp study
n1_sc <- 4540
n2_sc <- 2239 
m2_sc <- 30

NChapman(n1_sc, n2_sc, m2_sc) ## estimated population size as 328122.0
ciChapman(n1_sc, n2_sc, m2_sc) ## CI 242185.7 to 484372.3

# Sample size recommendation
n2RR(N=328192, n1=4540)
plotn2sim(N=328192, n1=4540)

### Run the pertersen estimator for the silver carp

NPetersen(n1_sc, n2_sc, m2_sc) # estimates the population size as 332235.3
ciPetersen(n1_sc,n2_sc,m2_sc) ## confidence interval is between 245928.3 and 508253.0

## What is the difference 
## Chapman coefficient was closest to the literature value and the confidence interval range is smaller. The peterson coefficient overshot the literature value and the confidence interval range is wider. 

## How many m&ms are in the bag 
## 1171

