# Install packages if necessary
# install.packages(c("sp", "rgeos", "FNN", "GISTools", "RColorBrewer")) 

library(sp) # SpatialPoints and SpatialPolygons objects
library(rgeos) # gContains function. Install libgeos-dev package (https://apps.ubuntu.com/cat/applications/libgeos-dev/) with your favourite package manager (or software centre) and you'll have /usr/bin/geos-config.
library(FNN) # nearest neighbors function
library(GISTools) # choropleth maps
library(RColorBrewer) # good color palettes for mapping

# Read data
map <- read.csv("cmaq.csv")

# Create SpatialPoints object from the coordinates in map.df.
sp.pts <- SpatialPoints(cbind(map$lon,map$lat))

# Convert the points into a grid.
# Note that we have to set the tolerance because the
# grid points are not perfectly equidistant.
#sp.grd <- points2grid(sp.pts, tolerance=0.333334) 
sp.grd <- points2grid(sp.pts, tolerance=1) 
grd.layer <- as.SpatialPolygons.GridTopology(sp.grd)

# Eliminate Unecessary Grid Cells
grd.cont <- ifelse(colSums(gContains(grd.layer, sp.pts, byid=T)) > 0, TRUE, FALSE)
grd.layer <- grd.layer[grd.cont]

plot(grd.layer)
