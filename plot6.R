#6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#Obtain Data
setwd("/Users/schre/DataScience/wd/exdata_plot/Project2")
if(!file.exists("./data")){dir.create("./data")}
if (!file.exists('data/exdata-data-NEI_data.zip')) {
      fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
      download.file(fileurl, 'data/exdata-data-NEI_data.zip')
      unzip('data/exdata-data-NEI_data.zip', exdir='./data')
}

#Read Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset only coal related sources
SCC.vehicle <- SCC[grep("veh", SCC$EI.Sector), 1]
NEI.baltimore.veh <- subset(NEI, NEI$fips=="24510" & NEI$type=="ON-ROAD")
NEI.la.veh <- subset(NEI, NEI$fips=="06037" & NEI$type=="ON-ROAD")  
#NEI.balt.la.veh <- merge(NEI.baltimore.veh, NEI.la.veh)
pm2.5.data.balt <- aggregate(Emissions ~ year, data=NEI.baltimore.veh, sum)
pm2.5.data.la <- aggregate(Emissions ~ year, data=NEI.la.veh, sum)

#Make plot
png("plot6.png", width=600, height=480)
par(mfrow=c(1,2))

plot(pm2.5.data.balt$year, pm2.5.data.balt$Emissions, type="b", pch=23, bg="blue", xlab="Year", 
     ylab="Total Emissions (thousands of tons)", main="Baltimore PM2.5 Emissions")

plot(pm2.5.data.la$year, pm2.5.data.la$Emissions, type="b", pch=23, bg="blue", xlab="Year", 
     ylab="", main="Los Angeles PM2.5 Emissions")

dev.off()