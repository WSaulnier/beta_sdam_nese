
library(tidyverse)
library(sf)
library(prism)
library(rgdal)
library(elevatr)
library(raster)
library(exactextractr)
# function to retrieve 30 year normal precip data for specified lat/long
prism_fetch <- function(lat, long){
  main_dir <- "./prism_temp"
  download_dir <- file.path(main_dir)
  prism_set_dl_dir(main_dir)
  mydf <- data.frame(lat=lat, long=long)
  mydf_sf<-st_as_sf(mydf,
                    coords=c("long","lat"),
                    remove=F,
                    crs=4326)
  #Turn them into rasters with projection info
  # ppt.m01_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_01_bil")
  # proj4string(ppt.m01_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  # ppt.m02_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_02_bil")
  # proj4string(ppt.m02_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  # ppt.m03_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_03_bil")
  # proj4string(ppt.m03_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  # ppt.m04_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_04_bil")
  # proj4string(ppt.m04_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m05_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_05_bil")
  proj4string(ppt.m05_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m06_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_06_bil")
  proj4string(ppt.m06_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m07_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_07_bil")
  proj4string(ppt.m07_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m08_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_08_bil")
  proj4string(ppt.m08_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m09_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_09_bil")
  proj4string(ppt.m09_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  ppt.m10_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_10_bil")
  proj4string(ppt.m10_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  # ppt.m11_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_11_bil")
  # proj4string(ppt.m11_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  # ppt.m12_RS<-pd_stack("PRISM_ppt_30yr_normal_800mM4_12_bil")
  # proj4string(ppt.m12_RS)<-CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")

  mydf_prism<-data.frame(UID='user_input') %>% 
    mutate(ppt.m05 = raster::extract(ppt.m05_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1],
           ppt.m06 = raster::extract(ppt.m06_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1],
           ppt.m07 = raster::extract(ppt.m07_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1],
           ppt.m08 = raster::extract(ppt.m08_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1],
           ppt.m09 = raster::extract(ppt.m09_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1],
           ppt.m10 = raster::extract(ppt.m10_RS, mydf_sf, fun=mean, na.rm=T, sp=F)[1])

  mydf_prism
}


