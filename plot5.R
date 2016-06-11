#5. How have emissions from motor vehicle sources changed from 1999-2008 in 
#Baltimore City?

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

#Make plot
library(ggplot2)
g <- ggplot(NEI.baltimore.veh, aes(x=year, y=Emissions, group=1))+
      geom_point(color="blue", alpha=0.35)+
      labs(x="Year", y="Emissions (tons)", title="Baltimore Vehicle PM2.5 Emissions")+
      stat_summary(fun.y=sum, colour="red", geom="line", size = 1, show.legend = TRUE)+
      geom_point(aes(color="Total"))+
      geom_point(aes(color="Data"))+
      scale_colour_manual("", values=c("Data"="blue","Total"="red"))+
      guides(colour = guide_legend(override.aes = list(linetype=c(0,1)
                                                       , shape=c(16,NA))))

ggsave(g, file="plot5.png", width=5, height=5)


