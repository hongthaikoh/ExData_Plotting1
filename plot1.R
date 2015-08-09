setwd("d:/DataScience/Coursera/ExData_Plotting1")

if (!file.exists("data")){
  dir.create("data")
}


## download Electric Power Consumption Dataset to data folder

fileURL1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile =("/data/household_power_consumption.zip"), mode="Wb")

