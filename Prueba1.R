library(tidyverse)
library(sf)
library(ggplot2)
library(osmdata)
library(leaflet)

bbox_poly <- getbb("Benito Juarez, Ciudad de México", format_out = "sf_polygon")
leaflet(bbox_poly) %>%
  addTiles() %>% 
  addPolygons()

MH <- opq(bbox) %>% 
  add_osm_feature(key = "highway")

MH <- MH %>% 
  osmdata_sf()

calles <- MH$osm_lines

head(calles) 
ggplot() +
  geom_sf(data = calles)

calles <- st_intersection(calles, bbox_poly)

calles <- calles %>% 
  mutate(maxspeed = as.numeric(maxspeed),
         lanes = ifelse(is.na(lanes), 1, as.numeric(lanes)))

ggplot(calles) +
  geom_sf(aes(color = maxspeed), alpha = 0.5) +
  scale_color_viridis_c() +
  theme_void() +
  labs(title = "Rosario",
       subtitle = "Vías de circulación",
       caption = "fuente: OpenStreetMap",
       color = "velocidad máxima")