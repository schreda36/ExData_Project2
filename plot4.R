#4. Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999-2008?

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
SCC.coal <- SCC[grep("Coal", SCC$EI.Sector), 1]
NEI.coal <- subset(NEI, NEI$SCC %in% SCC.coal)
pm2.5.data <- aggregate(Emissions ~ year, data=NEI.coal, sum)

#Make plot
png("plot4.png", width=480, height=480)

plot(pm2.5.data$year, pm2.5.data$Emissions, type="b", pch=18, col="blue", xlab="Year", 
     ylab="Total Emissions (thousands of tons)", main="US PM2.5 Coal Emissions (1999 to 2008)")

dev.off()