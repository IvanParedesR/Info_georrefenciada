library(gmapsdistance)
library(ggmap)
#definimos mi API key que obtengo en google.com
key1 <- "XXXXXX Key de Google XXXXXX"
register_google(key = key1)
?register_google
sessionInfo()

set.api.key("XXXXXX Key de Google XXXXXX")
results = gmapsdistance(origin = c("Irapuato+Gto", "Guadalajara+Jal"), destination = c("Ciudad+de+Mexico+CDMX", "Toluca+de+Lerdo+Mex"), mode = "bicycling")
results
origin = c("Washington+DC", "New+York+NY", "Seattle+WA", "Miami+FL")
destination = c("Los+Angeles+CA", "Austin+TX", "Chicago+IL")

results = gmapsdistance(origin, destination, mode = "driving", shape = "long")
