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



#Plot 1: Global active power histogram
hist(as.numeric(epc07$Global_active_power), 
     col = "red", 
     main="Global Active Power",
     xlab = "Global active power (kilowatts)")

#save as PNG
dev.copy(png, file = "plot1.png")
dev.off()