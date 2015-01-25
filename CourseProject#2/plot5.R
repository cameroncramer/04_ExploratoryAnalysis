#Exp Data Course Project #2
#5Motor Vehicle Sources
#Set working directory, import data and load packages

setwd("~/R/04_ExploratoryData/04_ExploratoryAnalysis/CourseProject#2")
NEI <- readRDS("summarySCC_PM25.rds")
library("plyr")

#Subset on Baltimore fips
Balt <- NEI[NEI$fips =="24510",]

#Subsets by vehicle as a source from class code dataset and match names
BaltVeh <- as.data.frame(SCC[ grep("vehicle", SCC$EI.Sector, ignore.case=T),1 ])
names(BaltVeh) <- "SCC"

#Merges datsets on vehicle
BaltVehMerge <- merge(BaltVeh, Balt, by="SCC", na.rm=TRUE)

#Summarises data by sum and mean
BaltVehSum <- ddply(BaltVehMerge, c("year"), summarise, Emissions = sum(Emissions))
BaltVehAvg <- ddply(BaltVehMerge, c("year"), summarise, Emissions = mean(Emissions))

#Plots data to viewer
par(mfrow = c(2,1))
plot(BaltVehAvg$year, BaltVehAvg$Emissions, xlab = "Year", ylab = "Average Emissions (Tons)",  col = "red", main="Baltimore Vehicle PM2.5 Emissions")
lines(BaltVehAvg$year, BaltVehAvg$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)
plot(BaltVehSum$year, BaltVehSum$Emissions, xlab = "Year", ylab = "Total Emissions (Tons)",  col = "red", main="Baltimore Vehicle PM2.5 Emissions")
lines(BaltVehSum$year, BaltVehSum$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)   

#Plots data to PNG
png(filename = "plot5.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mfrow = c(2,1))
plot(BaltVehAvg$year, BaltVehAvg$Emissions, xlab = "Year", ylab = "Average Emissions (Tons)",  col = "red", main="Baltimore Vehicle PM2.5 Emissions")
lines(BaltVehAvg$year, BaltVehAvg$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)
plot(BaltVehSum$year, BaltVehSum$Emissions, xlab = "Year", ylab = "Total Emissions (Tons)",  col = "red", main="Baltimore Vehicle PM2.5 Emissions")
lines(BaltVehSum$year, BaltVehSum$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)  
dev.off()