#Exp Data Course Project #2
#Q2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#Set working directory, import data and load packages

setwd("~/R/04_ExploratoryData/04_ExploratoryAnalysis/CourseProject#2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
library("plyr")

#Subset by Baltimore fips and summerise Baltimore emmisions by year 
Balt <- NEI[NEI$fips =="24510",]
BaltSum <- ddply(Balt, c("year"), summarise, Emissions = sum(Emissions))

#Plot data to viewer

plot(BaltSum$year, BaltSum$Emissions, type= "l", main = "Total Baltimore PM2.5 Emissions", xlab = "Year", ylab = "Emissions (Tons)")
lines(BaltSum$year, BaltSum$Emissions, type="b", pch=0,  lty=1, lwd=3, col = "red")

#Plot data to PNG

png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
plot(BaltSum$year, BaltSum$Emissions, type= "l", main = "Total Baltimore PM2.5 Emissions", xlab = "Year", ylab = "Emissions (Tons)")
lines(BaltSum$year, BaltSum$Emissions, type="b", pch=0,  lty=1, lwd=3, col = "red")
dev.off()
