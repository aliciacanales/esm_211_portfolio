install.packages("growthrate")
library(growthrate)
library(here)

##..........fit_easylinear..............
## specfiy what time is
## fit_easylinear algothrim uses subsets of h = n to find where the highest r <-growth rate. Uses time data and 
##murmax is r 

##..........fit_splines..............
## uses polynomials. non parametric 

##..........parametric nonlinear models........
## FUN defines growth rate?
## spar = is smoothness of data

## can be used for dose-response curves. You would get different r values at different concentrations of the antibiotic

##.......find r and k using bison data using three different models (exp,logistic, spline)............
## code is in linus box

