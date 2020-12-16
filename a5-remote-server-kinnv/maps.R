### This is the stub script to read the data and plot the maps
### You have to write the code suggested here.
### Feel free to follow the ideas in a different manner/in a different file.
### However, you have to submit your main code file.
###
### The file must be executable on the server!
### I.e. someone else must be able to just run it with 'Rscript maps.R'
### /on server/ and get the correct output.


## read the data
##
## hint1: figure out the correct format and use the correct function.
##
## hint2: read.table and friends are slow (about 6 min to read data).
## You may use data.table::fread instead (a few seconds)

library(ggplot2)
library(dplyr)
library(mapproj)
library(decrypt)


data <- read.csv("/opt/data/temp-prec-encrypted.csv.bz2", sep="\t", stringsAsFactors = FALSE)
data <- decrypt::decryptData(data)

## filter out North American observations

na_obs <- data %>%
  filter(latitude > 0 & latitude < 85) %>%
  filter(longitude > 180 & longitude < 310) %>% 
  filter(time %in% c("1960-04-01", "1986-04-01", "2014-04-01"))

## delete the original (large data) from R workspace
## this is necessary to conserve memory.

rm(data)


## -------------------- do the following for 1960, 1986, 2014 and temp/precipitation --------------------

## select jpg graphics device

jpeg("1960p.jpg")
filter(na_obs, time == "1960-04-01") %>%
 ggplot() +
    geom_tile(aes(x = longitude, y= latitude, fill= precipitation)) +
    ggtitle("North America 1960 Precipitation") +
    coord_map()
dev.off()

jpeg("1986p.jpg")
filter(na_obs, time == "1986-04-01") %>%
ggplot() +
  geom_tile(aes(x = longitude, y= latitude, fill= precipitation)) +
  ggtitle("North America 1986 Precipitation") +
  coord_map()
dev.off()

jpeg("2014p.jpg")
filter(na_obs, time == "2014-04-01") %>%
ggplot() +
  geom_tile(aes(x = longitude, y= latitude, fill = precipitation)) +
  ggtitle("North America 2014 Precipitation") +
  coord_map()
dev.off()

jpeg("1960t.jpg")
filter(na_obs, time == "1960-04-01") %>%
ggplot() +
  geom_tile(aes(x = longitude, y= latitude, fill= airtemp)) +
  ggtitle("North America 1960 Temperature") +
  coord_map()
dev.off()

jpeg("1986t.jpg")
filter(na_obs, time == "1986-04-01") %>%
ggplot() +
  geom_tile(aes(x = longitude, y= latitude, fill= airtemp)) +
  ggtitle("North America 1986 Temperature") +
  coord_map()
dev.off()

jpeg("2014t.jpg")
filter(na_obs, time == "2014-04-01") %>% 
  ggplot() +
  geom_tile(aes(x = longitude, y= latitude, fill= airtemp)) +
  ggtitle("North America 2014 Temperature") +
  coord_map()
dev.off()
  

## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can use something else too.
## 
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).
## Warning: map projections may be slow (several minutes per plot).

## close the device

## -------------------- you are done.  congrats :-) --------------------

