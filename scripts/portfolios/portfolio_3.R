library(growthrates)
library(janitor)
library(here)

# Find $r$ and $K$ for the bison dataset using at least three different models (e.g. exponential, logistic, spline).
# Hint: try functions `fit_easylinear`, `fit_growthmodels`, and `fit_splines`.


## Loading in the data, cleaning it, and inspecting it 
bison <- read_csv(here('data', 'bison.csv')) %>% 
  clean_names() %>% 
  rename('abundance' = 'bison')

head(bison %>%
       select(year, bison))

## Plotting a single growth curve
bison %>%
  ggplot(aes(x = year, y = abundance)) +
  geom_line() +
  theme(text = element_text(size = 12)) +
  ylim(0, NA)

## Finding r for the bison data using fit linear which uses exponential growth

fit <- fit_easylinear(bison$year, bison$abundance)
coef(fit) ## mumax is r

## Plotting the growth curve
par(mfrow = c(1, 2))
plot(fit, log = "y", cex.lab = 2, cex.axis = 2)
plot(fit, cex.lab = 2, cex.axis = 2)

## Finding r for the bison data using fit_splines which fits models piecewise

res <- fit_spline(bison$year, bison$abundance)
coef(res)

## Plotting the growth curve
par(mfrow = c(1, 2))
plot(res, log = "y", cex.lab = 2, cex.axis = 2)
plot(res, cex.lab = 2, cex.axis = 2)

## Finding r for the bison data using fit_growthmodels for parametric nonlinear models 
p <- c(y0 = 0.00, mumax = 0.5, K = 4100)

fit1 <- fit_growthmodel(FUN = grow_logistic, 
                        p = p, 
                        bison$year, 
                        bison$abundance)

coef(fit1)

## Plotting the growth curve
plot(fit1, cex.lab = 2, cex.axis = 2)


## r = .2 k = ~2000


## Do the different models agree on the parameter values?
## Answer: No easylinear says that r is 1.338074e-01 where the other two models say that r is .2