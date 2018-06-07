#author: Alex Filazzola
## Lat long to UTM
# datum must be stated. WGS84 is one frequently used
# state UTM zone to be transfered to
proj4string(latlong.data) <- CRS("+proj=longlat +datum=WGS84")
utm.data <- spTransform(latlong.data, CRS("+proj=utm +zone=10 ellps=WGS84"))
utm.data <- as(utm.data, "SpatialPoints")
## UTM to lat long
# state UTM zone to be transfered to
# datum must be stated. WGS84 is one frequently used
proj4string(utm.data) <- CRS("+proj=utm +zone=10 ellps=WGS84")
latlong.data <- spTransform(utm.data, CRS("+proj=longlat ellps=WGS84"))
latlong.data <- as(latlong.data, "SpatialPoints")
