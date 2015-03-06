library(lubridate)
library(dplyr)
if(!file.exists("./data")) {
    dir.create("./data")
}
if(!file.exists("./data/household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  "./data/household_power_consumption.zip", mode="wb")
    unzip("./data/household_power_consumption.zip", exdir="./data")
}
power <- read.table("./data/household_power_consumption.txt", 
                    sep=";", 
                    header=TRUE,
                    colClasses=c(rep("character",2),rep("numeric",7)),
                    na.strings="?")
# 2007-02-01 and 2007-02-02 only
power <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")
power$DateTime <- paste(power$Date, power$Time, sep=" ")
power$DateTime <- dmy_hms(power$DateTime)

png("./plot3.png", width = 480, height = 480)
with(power, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering", cex.lab=0.8, cex.axis=0.8))
with(power, lines(DateTime, Sub_metering_1))
with(power, lines(DateTime, Sub_metering_2, col="red"))
with(power, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, cex=0.8)
dev.off()