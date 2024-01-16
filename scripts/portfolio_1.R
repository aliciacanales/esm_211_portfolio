library(tidyverse) 
library(here)
library(janitor)
library(readxl)
library(dplyr)
library(ggplot2)

## Reading in the data and cleaning it up
coho <- readxl::read_xlsx(here('data', 'OC Coho Abundance.xlsx')) %>%
  clean_names() %>% 
  distinct() %>% 
  select(year, alsea, beaver, coos) %>% 
  pivot_longer(cols = 2:4,
               names_to = 'population',
               values_to = 'abundance')

## Mutating the data into a date format
coho_yr <- coho %>%
  mutate(date = lubridate::as_date(year)) 

## Making a ggplot of the time series
ggplot(data = coho_yr, aes(x = year, y = abundance, color = population)) + 
  geom_line() +
  scale_color_manual(values = c('#355c7d', '#f67280', '#f8b195'), 
                     labels = c('Alsea', 'Beaver', 'Coos')) +
  scale_x_continuous(breaks=seq(1994, 2019, 
                                by = 1)) +
  scale_y_continuous(labels=scales::comma) +
  labs(x = 'Year',
       y = 'Abundance',
       title = 'Times Series of Oregon Coast Coho Salmon Populations from 1994 to 2019',
       color = 'Population') +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))









