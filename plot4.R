setwd("d:/DataScience/Coursera/ExData_Plotting1")

if (!file.exists("./data")){
  dir.create("./data")
}


## Download Electric Power Consumption Dataset to data folder

library("RCurl")
fileURL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL1,destfile ="./data/Dataset.zip", method="libcurl")

## Unzip Dataset to ./data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Load large dataset
filename <- "./data/household_power_consumption.txt"
powerData <- read.table(filename,
                        header = TRUE,
                        sep = ";",
                        colClasses = c("character", "character", rep("numeric",7)),
                        na = "?")

## Subset 2 day data, 1/2/2007 and 2/2/2007 
attach(powerData)
twoDayData <- powerData[Date == "1/2/2007"| Date == "2/2/2007", ]
attach(twoDayData)
x <- paste(Date, Time)
twoDayData$DateTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
rownames(twoDayData) <- 1:nrow(twoDayData)
attach(twoDayData)

## Open PNG on screen graphic device
png(filename = "plot4.png",
    width = 480, height = 480,
    units = "px", bg = "transparent")

## Create multi panel plotting window of 2 x 2
par(mfrow = c(2,2))

## Plot Top-left line chart
plot(DateTime, Global_active_power,
     type = "l",
     xlab = "", ylab = "Global Active Power")

## Plot Top-right line chart
plot(DateTime, Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")

## Plot Bottom-left line chart
plot(DateTime, Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(DateTime, Sub_metering_2, col = "red")
lines(DateTime, Sub_metering_3, col = "blue")
  # remove legend box of Bottom-left line chart by setting bty = n
  legend("topright",
        bty = "n",
        col = c("black", "red", "blue"),
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lwd = 1)
  
## Plot Bottom-right line chart
plot(DateTime, Global_reactive_power,
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(twoDayData)[4])

dev.off()