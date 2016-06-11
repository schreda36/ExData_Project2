#Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

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
pm2.5.data <- aggregate(Emissions ~ year, data=NEI, sum)

#Make plot
png("plot1.png", width=480, height=480)

plot(pm2.5.data$year, pm2.5.data$Emissions, type="b", pch=18, col="blue", xlab="Year", 
            ylab="PM2.5 Total Emissions", main="US PM2.5 Measurements (1999 to 2008)")

dev.off()