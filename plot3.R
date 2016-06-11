#3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
#1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

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
pm2.5.data <- aggregate(Emissions ~ year + type, data=NEI.baltimore, sum)


#Make plot
library(ggplot2)
g <- qplot(year, Emissions, data=pm2.5.data, color=type, geom = "path",
           main="Baltimore PM2.5 Emissions Type (1999 to 2008)", xlab="Year", ylab="Total Emissions (thousands of tons)")

ggsave(g, file="plot3.png", width=5, height=5)