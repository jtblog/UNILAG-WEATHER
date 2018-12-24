library(readr)
library(nnet)
library(foreign)
library(reshape2)
library(darksky)
library(ggplot2)
library(tidyverse)
library(dplyr)

# a = read_file("test.R")
# print(a)
# # Sys.Date() - 365
# ml <- read.dta("hsbdemo.dta")
# ml$prog2 <- relevel(ml$prog, ref = "academic")
# test <- multinom(prog2 ~ ses + write, data = ml)
# View(ml)
# str(ml)

Sys.setenv(DARKSKY_API_KEY = "2f2200fed4d946888cb58dc172da817f")
#Darksky gives prediction for 4 day ahead of today
unx = paste(Sys.Date()-32, "00:00:01")
unx = as.POSIXct(unx)
now <- get_current_forecast(3.399259, 6.519250)
data <- get_forecast_for(3.399259, 6.519250, unx)
tmp <- get_forecast_for(3.399259, 6.519250, unx) #[YYYY]-[MM]-[DD]T[HH]:[MM]:[SS]

tmp <- seq(Sys.Date()- 100, Sys.Date(), "1 day") %>%
  map(~get_forecast_for(3.399259, 6.519250, .x))

hrly <- tmp %>% map_df("hourly")
dly <- tmp %>% map_df("daily")
crntly <- tmp %>% map_df("currently")
pre <- list("hourly" = hrly, "daily" = dly, "currently" = crntly)

df0 <- anti_join(data[["daily"]], pre[["daily"]], by = "time") %>% 
  bind_rows(pre[["daily"]]) %>% arrange(time)
df1 <- anti_join(data[["hourly"]], pre[["hourly"]], by = "time") %>% 
  bind_rows(pre[["hourly"]]) %>% arrange(time)
df2 <- anti_join(data[["currently"]], pre[["currently"]], by = "time") %>% 
  bind_rows(pre[["currently"]]) %>% arrange(time)
data[["daily"]] <- df0
data[["hourly"]] <- df1
data[["currently"]] <- df2

saveRDS(data, "data/uweather.RData")

library(lubridate)
Time <- factor(unx)
# parese date
a <- ymd_hms(as.character(Time))
# get hours
hour(a)
# get minutes
minute(a)

merge = do.call(rbind, list(df1, df2))

df1 = data[["currently"]]
df2 = tmp[["currently"]]
df1[setdiff(names(df2), names(df1))] <- NA
df2[setdiff(names(df1), names(df2))] <- NA


merge$time[length(rownames(merge))]
merge$time[1] == Sys.Date()

# seq(Sys.Date()-5, Sys.Date(), "1 day") %>% 
#   map(~get_forecast_for(43.2672, -70.8617, .x)) %>% 
#   map_df("hourly") %>% 
#   ggplot(aes(x=time, y=temperature)) +
#   geom_line()

saveRDS(data, "data/uweather.RData")

    # data[["hourly"]] %>%
    #   anti_join(pre[["hourly"]], by = "time") %>%
    #   bind_rows(pre[["hourly"]]) %>%
    #   arrange(time)
    # data[["daily"]] %>%
    #   anti_join(pre[["daily"]], by = "time") %>%
    #   bind_rows(pre[["daily"]]) %>%
    #   arrange(time)
    # data[["currently"]] %>%
    #   anti_join(pre[["currently"]], by = "time") %>%
    #   bind_rows(pre[["currently"]]) %>%
    #   arrange(time)

# library(magrittr)
# iris %>% head()
# iris %>% head() %>% summary() is equivalent to summary(head(iris))

# saveRDS(data, "uweather.RData")
# saveRDS(merge, "uweather.RData")
data <- readRDS("data/uweather.RData")

View(data)

# l1 <- list(list(a = 1L), list(a = NULL, b = 2L), list(b = 3L))
# l1 %>% map("a", .default = "???")
# l1 %>% map_int("b", .default = NA)
# l1 %>% map_int(2, .default = NA)


# result <- tryCatch({
#   
#   b <- 2
#   c <- b^2
#   d <- c+2
#   if (a == 'suppress-warnings') {
#     e <- suppressWarnings(myDivide(d,a))
#   } else {
#     e <- myDivide(d,a) # 6/a
#   }
#   f <- e + 100
#   
# }, warning = function(war) {
#   
#   # warning handler picks up where error was generated
#   print(paste("MY_WARNING:  ",war))
#   b <- "changing 'b' inside the warning handler has no effect"
#   e <- myDivide(d,0.1) # =60
#   f <- e + 100
#   return(f)
#   
# }, error = function(err) {
#   
#   # error handler picks up where error was generated
#   print(paste("MY_ERROR:  ",err))
#   b <- "changing 'b' inside the error handler has no effect"
#   e <- myDivide(d,0.01) # =600
#   f <- e + 100
#   return(f)
#   
# }, finally = {
#   
#   print(paste("a =",a))
#   print(paste("b =",b))
#   print(paste("c =",c))
#   print(paste("d =",d))
#   # NOTE:  Finally is evaluated in the context of of the inital
#   # NOTE:  tryCatch block and 'e' will not exist if a warning
#   # NOTE:  or error occurred.
#   #print(paste("e =",e))
#   
# }) # END tryCatch