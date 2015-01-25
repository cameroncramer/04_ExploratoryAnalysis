#Exp Data Course Project #2
#Q1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Set working directory, import data and load packages

setwd("~/R/04_ExploratoryData/04_ExploratoryAnalysis/CourseProject#2")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
str(NEI)
library("plyr")

#Use plyr to summerise total emissions data by year

YearEmis <- ddply(NEI, c("year"), summarise, Emissions = sum(Emissions))

#Plot data to viewer

plot(YearEmis$year, YearEmis$Emissions, xlab = "Year", ylab = "Emissions (Tons)",  
     col = "red", main=" Total National PM2.5 Emissions")
lines(YearEmis$year, YearEmis$Emissions, col = "red",  type="b", pch=0,  
      lty=1, lwd=3)

#Plot data to png

png(filename = "plot1.png", width = 480, height = 480, units = "px", 
    pointsize = 12, bg = "white")
plot(YearEmis$year, YearEmis$Emissions, xlab = "Year", ylab = "Emissions (Tons)",  
     col = "red", main=" Total National PM2.5 Emissions")
lines(YearEmis$year, YearEmis$Emissions, col = "red",  type="b", pch=0,  
      lty=1, lwd=3)
dev.off()