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

library(tidyverse)
library(osmdata)
library(sf)
library(ggmap)

head(available_features())
head(available_tags("amenity"))
head(available_tags("shop"))

q <- getbb("Madrid") %>%
  opq() %>%
  add_osm_feature("amenity", "cinema")

str(q) #query structure


cinema <- osmdata_sf(q)
cinema

mad_map <- get_map(getbb("Madrid"), maptype = "toner-background")

#final map
ggmap(mad_map)+
  geom_sf(data = cinema$osm_points,
          inherit.aes = FALSE,
          colour = "#238443",
          fill = "#004529",
          alpha = .5,
          size = 4,
          shape = 21)+
  labs(x = "", y = "")

m <- c(-10, 30, 5, 46)

#building the query
q <- m %>% 
  opq (timeout = 25*100) %>%
  add_osm_feature("name", "Mercadona") %>%
  add_osm_feature("shop", "supermarket")

#query
mercadona <- osmdata_sf(q)

#final map
ggplot(mercadona$osm_points)+
  geom_sf(colour = "#08519c",
          fill = "#08306b",
          alpha = .5,
          size = 1,
          shape = 21)+
  theme_void()