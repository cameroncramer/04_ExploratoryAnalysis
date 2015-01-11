# Pulls data from current directory
hhe<-read.csv("household_power_consumption.txt", header=TRUE, sep=c(";"), colClass=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), strip.white=TRUE, na.strings =c("?", ""))

# Renames several "?" in data to NA 
hhe[hhe == "?"] = NA

# Pastes together date and time to new variable Date_Time
hhe2$Date_Time = paste(hhe2$Date, hhe2$Time, sep=" ")

# COnverts pasted character classes (Date & Time) into POSIXct  
hhe2$Date_Time <- as.POSIXct(strptime(hhe2$Date_Time,format="%d/%m/%Y %H:%M:%S"))

# Rename Date_Time to DATE for clarity
colnames(hhe2)[colnames(hhe2)=="Date_Time"] <- "DATE"

# Subsets the dates needed for timeframe analysis
HHE<- subset(hhe2, DATE >= as.POSIXct('2007-02-01 00:00') & DATE <= as.POSIXct('2007-02-02 23:59'))

# Produces plot 3
plot(HHE$DATE,HHE$Sub_metering_1 == "sub", type = "l", ylab = "Energy sub metering", xlab = "", ylim=range(HHE$Sub_metering_1))
lines(HHE$DATE,HHE$Sub_metering_1,col="black")
lines(HHE$DATE,HHE$Sub_metering_2,col="red")
lines(HHE$DATE,HHE$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1)

# Prints plot 3 to a png
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
#This is plot 3 all set and ready to go
plot(HHE$DATE,HHE$Sub_metering_1 == "sub", type = "l", ylab = "Energy sub metering", xlab = "", ylim=range(HHE$Sub_metering_1))
lines(HHE$DATE,HHE$Sub_metering_1,col="black")
lines(HHE$DATE,HHE$Sub_metering_2,col="red")
lines(HHE$DATE,HHE$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty=1)
dev.off()