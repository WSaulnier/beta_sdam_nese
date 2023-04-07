library(tidyverse)
library(prism)
# library(raster) #Avoid conflicts with plyr and do not load. Call directly instead. #Can we replace with exactextractr?
# library(exactextractr) #Avoid conflicts with plyr and do not load. Call directly instead.
library(randomForest)
library(sf)
library(rgdal)
library(shiny)
library(shinycssloaders)
library(shinycustomloader)
library(shinyWidgets)
library(formatR)
library(shinyjs)
library(magrittr)
library(rslates)
library(leaflet)
library(leaflet.extras)
library(dataRetrieval)
source('./R/prism_data.R')
# Load the final RF model
RF_NE <- readRDS("./model/RF_V4_NE.rds")
RF_SE <- readRDS("./model/RF_V4_SE.rds")

# Required predictors for model
predictors <- row.names(RF_SE$importance)

for (r in row.names(RF_SE$importance)){
  print(r)
}
# Load shapefile with regions
# regions <- read_sf("./spatial/Major_SDAM_regions.shp") %>%
#         st_transform(crs = 4326)
# light weight version of regions shapefile to speed up leaflet rendering
regions_leaflet <- read_sf("./spatial/regions_simp_noPRVI.shp")




run_model <- function(
    user_lat = NA,
    user_lon = NA,
    user_TotalAbundance = NA,
    user_richness = 0,
    user_Slope = NA,
    user_UplandRootedPlants_score = NA,
    user_SubstrateSorting_score = NA,
    user_BankWidthMean = NA,
    user_PctShade = NA,
    user_NaturalValley_score = NA,
    user_DRNAREA = NA,
    user_TA_0_10_32_plus = NA
){
  
  # get prism precip data for specified lat/long
  print(user_lat)
  print(user_lon)
  prism_df <- prism_fetch(user_lat, user_lon)

  df <- tibble(lat = user_lat,
               lon = user_lon,
               ppt.8910 = (prism_df$ppt.m08+prism_df$ppt.m09+prism_df$ppt.m10)/3,
               ppt.567 = (prism_df$ppt.m05+prism_df$ppt.m06+prism_df$ppt.m07)/3,
               Slope = user_Slope,
               UplandRootedPlants_score = user_UplandRootedPlants_score,
               SubstrateSorting_score = user_SubstrateSorting_score,
               BankWidthMean = user_BankWidthMean,
               PctShading = user_PctShade,
               NaturalValley_score = user_NaturalValley_score,
               DRNAREA_0.5bin = case_when(user_DRNAREA<0.5~0, T~1),
               DRNAREA_0.1bin = case_when(user_DRNAREA<0.1~0, T~1),
               TA_0_10_32_plus = case_when(user_TotalAbundance<1~0,
                                           ((user_TotalAbundance>=1) & (user_TotalAbundance<=10)~1),
                                           ((user_TotalAbundance>=11) & (user_TotalAbundance<=32)~2),
                                           user_TotalAbundance>=33~3),
               BMI_score_alt4 = case_when(user_TotalAbundance >= 10 & user_richness>=3  ~3,
                                          user_richness >= 5~3,  
                                          user_TotalAbundance>=4 ~2,   
                                          user_TotalAbundance>0~1, 
                                          T~0)
               
                 
    )

  # print(df$lat)
  # print(df$lon)
#   print(df$ppt.8910)
# # 
  # check to see if user supplied lat/long is in Eastern regions
  pnts_df <- sf::st_as_sf(df, coords = c("lon", "lat"), crs = 4326, remove = FALSE)
  pnts_join_df <- sf::st_join(pnts_df, regions_leaflet) %>%
    rename(Strata_UNC = region)

  # if user supplied location is outside of study regions, return an error message
  # otherwise continue to RF model
  if (is.na(pnts_join_df$Strata_UNC)){
    spatial_msg <- paste0(
      "<h5>",
      "<p>The location of your site is outside of the SDAM Study areas.<p><br>",
      "<p>Please check your latitude and longitude coordinates to ensure they are entered correctly.<p><br>"
    )
    print(spatial_msg)

  } else if (pnts_join_df$Strata_UNC == 'Northeast'){
    print("running NE model")
    # apply random forest model to user supplied data
    ClassProbs <- predict(RF_NE, newdata = pnts_join_df, type="prob") %>% as.data.frame()
    # assign appropriate class based on probabilities
    output_df <- bind_cols(pnts_join_df, ClassProbs) %>%
      mutate(ALI = I + P,
             Class = case_when(P>=.5~"perennial",
                               I>=.5~"intermittent",
                               E>=0.5~"ephemeral",
                               ALI >= 0.5 ~ "at least intermittent",
                               T~"Need more information")
      )
    print(glue::glue("User Supplied Coordinates: '{output_df$Strata_UNC}'"))
    paste0("This reach is classified as ", tolower(output_df$Class),".")
  } else if (pnts_join_df$Strata_UNC == 'Southeast') {
    print("running SE model")
    # apply random forest model to user supplied data
    ClassProbs <- predict(RF_SE, newdata = pnts_join_df, type="prob") %>% as.data.frame()
    # assign appropriate class based on probabilities
    output_df <- bind_cols(pnts_join_df, ClassProbs) %>%
      mutate(ALI = I + P,
             Class = case_when(P>=0.5~"perennial",
                               I>=0.5~"intermittent",
                               E>=0.5~"ephemeral",
                               ALI >= 0.5 ~ "at least intermittent",
                               T~"Need more information")
      )
    print(glue::glue("User Supplied Coordinates: '{output_df$Strata_UNC}'"))
    paste0("This reach is classified as ", tolower(output_df$Class),".")
  }
}
  
  
point_region <- function(
  user_lat = 0,
  user_lon = 0
){
  df <- tibble(lat = user_lat,
               lon = user_lon)
  # check to see if user supplied lat/long is in Great Plains regions
  pnts_df <- sf::st_as_sf(df, coords = c("lon", "lat"), crs = 4326, remove = FALSE)
  pnts_join_df <- sf::st_join(pnts_df, regions_leaflet) 

  pnts_join_df
}

# retrieve appropriate precip metric for report generation
prism_output <- function(lat,long,region){
  prism_df <- prism_fetch(lat, long)
  if (region == 'Northeast'){
    precip <- (prism_df$ppt.m08+prism_df$ppt.m09+prism_df$ppt.m10)/3
  } else if (region == 'Southeast') {
    precip <- (prism_df$ppt.m05+prism_df$ppt.m06+prism_df$ppt.m07)/3
  }
  precip
}

# retrieve appropriate drainage area metric for report generation
da_output <- function(da, region){
  if(region=='Northeast'){
    drain_area <- case_when(da<0.5~0, T~1)
  } else if(region=='Southeast'){
    drain_area <- case_when(da<0.1~0, T~1)
  }
  drain_area
}

# retrieve appropriate bmi metric for report generation
bmi_output <- function(ta, richness){
    bmi <- BMI_score_alt4 = case_when(
      ta==0 && richness==0~0,
      ta>=1 && ta<=3 && richness==0~1,
      ta>=4 && ta<10 && richness<5~2,
      ta>=10 && ta && richness>=3 && richness<5~3,
      ta>=0 && richness>=5~3)
    bmi
}

# retrieve appropriate ta metric for report generation
ta_output <- function(ta){
  if(region=='Southeast'){
    ta <- case_when(ta<1~0,
                    ((ta>=1) & (ta<=10)~1),
                    ((ta>=11) & (ta<=32)~2),
                    ta>=33~3)
  }
}

