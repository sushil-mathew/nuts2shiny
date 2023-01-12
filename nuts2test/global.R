library(tidyverse)
library(eurostat)
library(sf)
library(conflicted)

conflict_prefer("select", "dplyr")
SHP_0 <- get_eurostat_geospatial(resolution = 10, 
                                 nuts_level = 2, 
                                 year = 2016,
                                 crs = 3035)
EU28 <- eu_countries %>% 
  select(CNTR_CODE = code, name)

tgs00007 <- get_eurostat("tgs00007", time_format = "num")

tgs00007_shp <- tgs00007 %>% 
  right_join(SHP_0, by = "geo") %>%
  right_join(EU28, by = "CNTR_CODE") %>%
  select(NUTS_ID, NAME_LATN, name, values, geometry, CNTR_CODE) %>% 
  st_as_sf()
tgs00007_shp$norm <- runif(nrow(tgs00007_shp))

mydata <- tgs00007_shp
#row.names(mydata) <- mydata$NUTS_ID