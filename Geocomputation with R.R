#https://geocompr.robinlovelace.net/index.html

#Geocomputation with R
#Robin Lovelace, Jakub Nowosad, Jannes Muenchow
#The blue markers indicate where the authors are from. The basemap is a tiled image of the Earth at night provided by NASA. Interact with the online version at geocompr.robinlovelace.net, for example by zooming in and clicking on the popups.

library(leaflet)
popup = c("Guadalajara", "Chihuahua")
leaflet() %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") %>%
  addMarkers(lng = c(-99, -96),
             lat = c(19, 16), 
             popup = popup)

install.packages("sf")
install.packages("raster")
install.packages("spData")
remotes::install_github("Nowosad/spDataLarge")

library(raster) 
library(sf)
library(spData) 
library(spDataLarge)

vignette(package = "sf") # see which vignettes are available
vignette("sf1")          # an introduction to the package

names(world)

plot(world)
summary(world["lifeExp"])

world_mini = world[1:2, 1:3]
world_mini

library(sp)
world_sp = as(world, Class = "Spatial")
world_sp

#2.2.3 Basic map making

plot(world[3:6])
plot(world["pop"])

world_asia = world[world$continent == "Asia", ]
asia = st_union(world_asia)

plot(world["pop"], reset = FALSE)
plot(asia, add = TRUE, col = "red")

plot(world["continent"], reset = FALSE)
cex = sqrt(world$pop) / 10000
world_cents = st_centroid(world, of_largest = TRUE)
plot(st_geometry(world_cents), add = TRUE, cex = cex)

# Mapa de México

mexico = world[world$name_long == "Mexico", ]
plot(st_geometry(mexico), expandBB = c(1, 2, 1, 1), col = "gray", lwd = 3)
plot(world[0], add = TRUE)

