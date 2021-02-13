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
#filter data from the dates 2007-02-01 to 2007-02-02 and add detailed time to the subset
subset <- data %>%
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  mutate(DetailedTime= strptime(paste(Date,Time,sep = " "),"%d/%m/%Y %H:%M:%S"))
png("~/data/plot4.png",width = 480 ,height = 480)
par(mfrow=c(2,2))
with(subset,plot(DetailedTime,Global_active_power,type = "l",xlab = "", ylab="Global Active Power" ))
with(subset,plot(DetailedTime,Voltage,type = "l",xlab = "datetime", ylab="Voltage" ))
with(subset,plot(DetailedTime,Sub_metering_1,type = "l",col = "black",xlab = "",ylab = "Energy sub metering"))
with(subset,lines(DetailedTime,Sub_metering_2,col = "red"))
with(subset,lines(DetailedTime,Sub_metering_3,col = "blue"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty = "solid",bty = "n")
with(subset,plot(DetailedTime,Global_reactive_power,type = "l",xlab = "datetime", ylab="Global_reactive_power" ))
dev.off()


