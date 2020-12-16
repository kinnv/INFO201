library(ggplot2)
library(dplyr)
library(stringr)

county_data <- map_data('county')
voting <- read.csv("data/presidential_2008-2016.csv.bz2", header = TRUE, sep = "\t", quote = "\t", stringsAsFactors = FALSE)

# Further Organizing Data
voting <- voting %>% 
  mutate(county = tolower(county),
         county = str_replace(county, ' county', ''))

# Joining County Data with Voting Data
gop_data <- full_join(county_data, voting, by = c("subregion" = "county"))
gop_2008_data <- select(gop_data, long, lat, group, order, region, fips_code, gop_2008) 


# Plotting Joined Data

gop_2008_data %>% ggplot(aes(long, lat)) +
  geom_polygon(aes(group = group, fill = gop_2008)) +
  coord_map("albers",  at0 = 45.5, lat1 = 29.5) +
  scale_fill_continuous(name = 'Number of GOP Voters by County (2008)') +
  labs(title = 'Number of GOP Voters per County (2008)',
       subtitle = 'Data from US Department of Agriculture Economic Research Service',
       x = 'Longitude',
       y = 'Latitude')

  
  
  