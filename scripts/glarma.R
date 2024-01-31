install.packages('glarma')
library(glarma)


## oberservation driven data that is not normally distrubted data
## accounts for variability
## autoregressive models: predicting future values based on past values
## vignette not very helpful

## 3 types of models (poisson, negative binomial, and binomial)
## log of the poisson distribution
## intercept 1 needs to be a matrix.. why?
## null mddel using the intercept and then the explanatory model
## lag can be anything