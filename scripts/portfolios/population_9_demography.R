library(demography)
rm(list = ls())

library(here)
library(tidyverse)

## I calculated it using the sheep example and will compare it with the code below code 
# bison example
bison_data<-read.csv(here("data","bison_lh.csv"))

#Creat new columns of variables for calculation
life_table_bison <- bison_data %>%
  mutate("Lx"=(lx+lead(lx))/2,
         "Lx"=replace(Lx, length(lx), 0),
         "ex"=rev(cumsum(rev(Lx)))/lx
  )

life_table_bison #output for bison


###########################
# From bison research
bison_data<-read.csv(here("data","bison_lh.csv"))

#Create new columns of variables for calculation
life_table_bison1 <- bison_data %>%
  mutate("lx*mx"=lx*mx,
         "x*lx*mx"=age*lx*mx,
         "Lx"=(lx+lead(lx))/2,
         "Lx"=replace(Lx, length(lx), 0),
         "ex"=rev(cumsum(rev(Lx)))/lx,
         "R0"=sum(lx*mx),
         "G"=sum(age*lx*mx)/R0,
         "approx.r"=log(R0)/G
  )

life_table_bison ## This output has more columns that have calculated 
## R0 = Net reproductive rate; G = Generation Time; r = true rate of increase. 

bison_plot<-ggplot(life_table_bison, aes(x=age, y=ex)) + # ex is life expectancy
  geom_line() +
  geom_point() +
  theme_minimal() ## as the population hit year 10 it starts to plateau and decreases by year 30. 

## Q: Why is age zero life expectancy less than age 1?
## A: Bison are not yet at reproductive age, so there is a lag in the population.

## Q: Why are R0, G, and r the same for each age?
## A: They are the same because these values are constant throughout the population, regardless of time/age. Generation time is the same, because the time between generations does not change. Meaning that the generation time within a population is constant. Net reproductive rate is constant because it does not change with time or population size.



