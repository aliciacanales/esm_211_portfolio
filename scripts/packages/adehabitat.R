install.packages(adehabitat)
library(adehabitat)

## calculates home ranges
## used fot connectivity and fragmentation, CP (identifying priority areas), disease ecology, and informing management decisions.
## minimum convex polygons- polygons are calcuted based on the rea that the observed individuals have traveled in
## Kernel density estimation. h factor <- smoothing factor. Large H more smoothing so it increased homerange size

## Type of data - telemetry data 
## need a spaital points data frame first then calculate the minimum convex. Then set the percentage 

## Kernel density
## spatial points data frame used kernalUD function
## reference bandwidth <- ouver estimates habitat range

##UD probability that the species hangs out ther 
## doesn't take time into consideration
## the dip is showing that the kernel are fitting the model with least outleirs correctly 