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

# PLot 4: putting all the plots together in one

par(mfrow=c(2, 2))

#plot A
with(epc07, plot(datetime, as.numeric(Global_active_power), 
                 type = "l",
                 ylab = "Global active power",
                 xlab = " "))

#plot B
with(epc07, plot(datetime, as.numeric(Voltage), 
                 type = "l",
                 ylab = "Voltage",
                 xlab = "datetime"))

#plot C
with(epc07, plot(datetime, Sub_metering_1, type="l",
                 xlab= " ",
                 ylab= "Energy sub metering"))
lines(epc07$datetime, epc07$Sub_metering_2, type="l", col = "red")
lines(epc07$datetime, epc07$Sub_metering_3, type="l", col = "blue")
legend("topright", bty = "n", cex=0.8,
       legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       lty = 1, col = c("black", "red", "blue"))

#plot D
with(epc07, plot(datetime, as.numeric(Global_reactive_power), 
                 type = "l",
                 ylab = "Global reactive power",
                 xlab = "datetime"))

#save as PNG
dev.copy(png, file = "plot4.png")
dev.off()