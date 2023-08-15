install.packages("raster")
install.packages("rgdal")

library(raster)
library(rgdal)

## Set WD
wd = "C:/Users/User/Desktop/intern maisarah RS Module/NEONDSFieldSiteSpatialData"
setwd(wd)
## Import DSM
# assign raster to object
dsm <- raster(paste0('NEON-DS-Field-Site-Spatial-Data\SJER\DigitalSurfaceModel\SJER2013_DSM.tif'))

# above code doesnt work bcs use \ instead of /
dsm <- raster(paste0("NEON-DS-Field-Site-Spatial-Data/SJER/DigitalSurfaceModel/SJER2013_DSM.tif"))

# view info about raster
dsm     

# clear all plots or else got error for parameters
dev.off(dev.list()["RStudioGD"])

# plot DSM
plot(dsm, main="Lidar Digital surface Model \n SJER, California")
plot(dsm, useRaster=TRUE)

# import dtm
dtm <- raster(paste0("NEON-DS-Field-Site-Spatial-Data/SJER/DigitalTerrainModel/SJER2013_DTM.tif"))

# view dtm info
dtm

# plot dtm
plot(dtm, main="Lidar Digital Terrain Model \n SJER, California")

# create canopy height model func

canopyCalc <- function(DTM, DSM) {
  return(DSM - DTM)
  }

# create final chm
chm2 <- canopyCalc(dsm,dtm)

chm2

# plot chm

plot(chm2, main="Canopy Height Model \n SJER, California")



# can also use overlay function

chm3 <- overlay(dsm,dtm, fun = canopyCalc)

chm3

# write raster as geo tiff

writeRaster(chm2,paste0(wd,"_chm_SJER.tif"),"GTiff")
getwd()
