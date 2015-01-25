#Exp Data Course Project #2
#6Compare LA & Balt Vehicle
#Set working directory, import data and load packages

setwd("~/R/04_ExploratoryData/04_ExploratoryAnalysis/CourseProject#2")
NEI <- readRDS("summarySCC_PM25.rds")
NEI2 <- NEI
NEI2$year <- factor(NEI$year)
library("plyr")
library("ggplot2"
     
#Subset LA and Baltomire fips data from dataset
LABalt <- NEI2[NEI2$fips %in% c("24510", "06037"),]

#Subset by vehicle as a source from class code dataset and match names
Veh <- as.data.frame(SCC[ grep("vehicle", SCC$EI.Sector, ignore.case=T), 1])
names(Veh) <- "SCC"

#Merge datasets on vehicle
LABaltMerge  <- merge(Veh, LABalt, by="SCC", na.rm=TRUE)
LABaltMerge$City[LABaltMerge$fips=="24510"] <- "Baltimore"
LABaltMerge$City[LABaltMerge$fips=="06037"] <- "LA"
LABaltMergeSum <- ddply(LABaltMerge, .(year, City), summarize, Emissions=sum(Emissions))

#Plot data to viewer
g2<- ggplot(LABaltMergeSum, aes(x=year, y=Emissions))
g2 + geom_point(aes(color = City), size = 6, alpha = 3/4) +
        labs(title="Baltimore/LA PM2.5 Vehicle Emissions",
             x="Year", y="Emissions (Tons)")

#Plot data to PNG
png(filename = "plot6.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
g2<- ggplot(LABaltMergeSum, aes(x=year, y=Emissions))
g2 + geom_point(aes(color = City), size = 6, alpha = 3/4) +
        labs(title="Baltimore/LA PM2.5 Vehicle Emissions",
             x="Year", y="Emissions (Tons)")
dev.off()      
        