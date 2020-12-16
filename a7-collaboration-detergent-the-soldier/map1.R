#Voting differences between republicans and democrats
library(ggplot2)
library(dplyr)
library(stringr)

county_data <- map_data("county") 
presidential_data <- read.csv("data/presidential_2008-2016.csv.bz2", header = TRUE, sep = "\t", quote = "\t", stringsAsFactors = FALSE)

#Converting subregion/county data
presidential_data <- presidential_data %>% 
  mutate(county = tolower(county),
         county = str_replace(county, ' county', ''))

#Merging data
county_votes <- full_join(county_data, presidential_data, by = c('subregion' = 'county'))
gop_2016_data <- select(county_votes, long, lat, group, region, subregion, fips_code, gop_2016, dem_2016) %>%  
  mutate(voting_differences = gop_2016 - dem_2016)

#Mapping Data
gop_2016_data %>%
  ggplot(aes(long, lat)) +
  geom_polygon(aes(group = group, fill = voting_differences)) +
  coord_map("albers",  at0 = 45.5, lat1 = 29.5) +
  scale_fill_continuous(name = 'Vote difference') +
  labs(title = 'Republican versus Democratic Vote Differences in 2016',
       subtitle = 'Data from US Department of Agriculture Economic Research Service',
       x = 'Longitude',
       y = 'Latitude')

