#Exp Data Course Project #2
#Q4 Coal Combustion as source since#have seen decreases in emissions from 1999-2008 for Baltimore City?
#Set working directory, import data and load packages

setwd("~/R/04_ExploratoryData/04_ExploratoryAnalysis/CourseProject#2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library("plyr")

#Subsets by coal as a source from class code dataset and match names
coal <- as.data.frame(SCC[ grep("coal", SCC$EI.Sector, ignore.case=T),1 ])
names(coal) <- "SCC"

#Merge datasets on coal
coalMerge <- merge(coal, NEI, by="SCC", na.rm=TRUE)

#Summarise coal data by total and average emissions
coalSum <- ddply(coalMerge, c("year"), summarise, Emissions = sum(Emissions))
coalAvg <- ddply(coalMerge, c("year"), summarise, Emissions = mean(Emissions))

#Plot data in viewer
par(mfrow = c(2,1))
plot(coalAvg$year, coalAvg$Emissions, xlab = "Year", ylab = "Average Emissions (Tons)",  col = "red", main="National Coal PM2.5 Emissions")
lines(coalAvg$year, coalAvg$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)
plot(coalSum$year, coalSum$Emissions, xlab = "Year", ylab = "Total Emissions (Tons)",  col = "red", main="National Coal PM2.5 Emissions")
lines(coalSum$year, coalSum$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)  

#Plot data to PNG
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
par(mfrow = c(2,1))
plot(coalAvg$year, coalAvg$Emissions, xlab = "Year", ylab = "Average Emissions (Tons)",  col = "red", main="National Coal PM2.5 Emissions")
lines(coalAvg$year, coalAvg$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3)
plot(coalSum$year, coalSum$Emissions, xlab = "Year", ylab = "Total Emissions (Tons)",  col = "red", main="National Coal PM2.5 Emissions")
lines(coalSum$year, coalSum$Emissions, col = "red",  type="b", pch=0,  lty=1, lwd=3) 
dev.off()