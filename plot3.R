
# opening the data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "epcdata.zip")
epc <- read.table(unz("epcdata.zip", "household_power_consumption.txt"), 
                  header= TRUE, sep = ";", colClasses = "character") 

library(lubridate)
library(dplyr)

epc$datetime <- paste(epc$Date, epc$Time)
epc$datetime <- as.POSIXct(epc$datetime, format= "%d/%m/%Y %H:%M:%S")
epc$Date <- dmy(epc$Date)

epc07 <- subset(epc, Date >= "2007-02-01" & Date <= "2007-02-02")

#PLot 3: line plot of energy sub_metering over days
with(epc07, plot(datetime, Sub_metering_1, type="l",
                 xlab= " ",
                 ylab= "Energy sub metering"))
lines(epc07$datetime, epc07$Sub_metering_2, type="l", col = "red")
lines(epc07$datetime, epc07$Sub_metering_3, type="l", col = "blue")
legend("topright", 
       legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       lty = 1, col = c("black", "red", "blue"))

#save as PNG
dev.copy(png, file = "plot3.png")
dev.off()