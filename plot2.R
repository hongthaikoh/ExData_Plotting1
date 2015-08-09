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
png(filename = "plot2.png",
    width = 480, height = 480,
    units = "px", bg = "transparent")

## Plot line charts
plot(DateTime, Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
