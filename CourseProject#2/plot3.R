#Exp Data Course Project #2
#Q3 Of the four types of sources indicated by the type which of these four sources 
#have seen decreases in emissions from 1999-2008 for Baltimore City?
#Set working directory, import data and load packages

NEI <- readRDS("summarySCC_PM25.rds")
NEI2 <- NEI
NEI2$year <- factor(NEI$year) 
library("plyr")
library("ggplot2")

#Filter by Baltimore fips and summerise Baltimore emmisions by year 
Balt <- NEI2[NEI2$fips =="24510",]
BaltByType <- ddply(Balt, .(year, type), summarize, Emissions=sum(Emissions))

#Plot data to viewer
g<- ggplot(BaltByType, aes(x=year, y=Emissions))
g + geom_point(aes(color = type), size = 6, alpha = 3/4) +
labs(title="Baltimore PM2.5 Emissions by Type",
             x="Year", y="Emissions (Tons)")
       
#Plot dat to PNG
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
g<- ggplot(BaltByType, aes(x=year, y=Emissions))
g + geom_point(aes(color = type), size = 6, alpha = 3/4) +
        labs(title="Baltimore PM2.5 Emissions by Type",
             x="Year", y="Emissions (Tons)")
dev.off()                                                 