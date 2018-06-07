#previous HR code
#Population ####
#previous without UTM conversion
#track.pop <-data
#track.pop <- track.pop %>% filter(lizard != "x") #were not 5 relocations for x
#coordinates(track.pop) <- c("lat", "long")

#single-animal test
lizard.r <- data %>% filter(lizard == "r")
coordinates(lizard.r) <- c("lat", "long")

#MCP
mcp.lizard.r<- mcp(lizard.r, percent=95, unin = c("m"), unout = c("m2"))
as.data.frame(mcp.lizard.r)
plot(mcp.lizard.r)
plot(lizard.r, add=TRUE)

#MCP.area
mcp.area.lizard.r <- mcp.area(lizard.r, percent = seq(20,100, by = 5), unin = c("m"), unout = c("m2"), plotit = TRUE)
mcp.area.lizard.r

#Test all relocations
relocation.counts <- data %>% group_by(lizard) %>% summarise(no_rows = length(lizard)) #need at least 5 relocations
print(relocation.counts < 5)

ind.track <- data %>% filter(lizard != "x") 

coordinates(ind.track) <- c("lat", "long")
lizards <- levels(as.factor(data$lizard))


#for loop to process each separately
#telemetry <- list()
#for(i in 1:length(lizards)){
#track.temp <- subset(ind.track, lizard==lizards[i])
#mcp.temp <- mcp(track.temp, percent=95, unout = c("m2"))
#mcp.area.temp <- mcp.area(track.temp, percent = seq(20,100, by = 5), unin =    #c("m", "km"), unout = c("ha","km2", "m2"), plotit = TRUE)
# df <- data.frame(lizard=lizards[i], mcp = mcp.temp, mcp.area = mcp.area.temp)
#telemetry <- rbind(telemetry, df)
#}
#telemetry
#write.csv(telemetry, file = "data/mcp.csv")

individual.mcps <- list()
individual.mcp.areas <- list()
for(i in 1:length(lizards)){
  track.temp <- subset(ind.track, lizard==lizards[i])
  mcp.temp <- mcp(track.temp, percent=95, unout = c("m2"))
  mcp.area.temp <- mcp.area(track.temp, percent = seq(20,100, by = 5), unin =    c("m", "km"), unout = c("ha","km2", "m2"))
  ind.mcp <- data.frame(lizard=lizards[i], mcp = mcp.temp)
  individual.mcps <- rbind(individual.mcps, ind.mcp)
  ind.mcp.area <- data.frame(lizard=lizards[i], mcp.area = mcp.area.temp)
  individual.mcp.areas <- rbind(individual.mcp.areas, ind.mcp.area)
}

#individual.mcps
#individual.mcp.areas

ggplot(individual.mcps, aes(lizard, mcp.area)) + 
  geom_col(fill = "lightblue") + 
  ylab("total mcp.area") + coord_flip()

individual.mcp.areas <- individual.mcp.areas %>% mutate(rows = row.names(individual.mcp.areas))

individual.mcp.areas$rows <- as.numeric(individual.mcp.areas$rows)

ggplot(individual.mcp.areas, aes(rows, a, colour = factor(lizard))) + 
  geom_line() + geom_point() + ylab("home-range MCP")

ggplot(individual.mcp.areas, aes(rows, a)) + 
  geom_line() + 
  geom_point() + 
  ylab("home-range size") +
  xlab("home-range level") + 
  facet_wrap(~lizard, scales = "free")
