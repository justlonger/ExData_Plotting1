library(data.table)
library(dplyr)
downloadfile <- "~/data/household_power_consumption.txt"
if (!file.exists(downloadfile))
{ ifelse(!dir.exists("~/data"),dir.create("~/data"),FALSE)
  setwd("~/data/")
  downloadurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(downloadurl,"household_power_consumption.zip")
  unzip("./household_power_consumption.zip")
  }
data <- fread(downloadfile,sep = ";",na.strings = "?") 

#filter data from the dates 2007-02-01 to 2007-02-02
subset <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007")
png("~/data/plot1.png",width = 480 ,height = 480)
hist(subset$Global_active_power,xlab = "Global Active Power(kilowatts)",
     ylab = "Frequency",main = "Glbobal Active Power",col = "red")
dev.off()
