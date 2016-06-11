#Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot
#answering this question.

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
NEI.baltimore <- subset(NEI, NEI$fips=="24510")
pm2.5.data <- aggregate(Emissions ~ year, data=NEI.baltimore, sum)

#Make plot
png("plot2.png", width=480, height=480)

plot(pm2.5.data$year, pm2.5.data$Emissions, type="b", pch=23, bg="blue", xlab="Year", 
     ylab="PM2.5 Total Emissions", main="Baltimore PM2.5 Measurements (1999 to 2008)")

dev.off()