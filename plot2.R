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

png("./plot2.png", width = 480, height = 480)
with(power, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", cex.lab=0.8, cex.axis=0.8))
dev.off()