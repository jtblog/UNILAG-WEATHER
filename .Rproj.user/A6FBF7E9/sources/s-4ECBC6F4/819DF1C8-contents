library(darksky)
library(tidyverse)
# packageVersion("darksky")

Sys.setenv(DARKSKY_API_KEY = "2f2200fed4d946888cb58dc172da817f")
data = "";
sframe = "";

getTime <- function(){
  return(Sys.Date())
}

getData <- function(lng, lat){
  data <<- get_current_forecast(lng, lat);
}

tweakframe <- function(mframe){
  sframe <<- mframe;
  if(sframe == "hourly" || sframe == ""){
    return(data$hourly);
  }else if(sframe == "daily"){
    return(data$daily);
  }
  
}