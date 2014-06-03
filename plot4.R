#################################################################
#       Plots Sub Metering Over Two Days           #
################################################################

##      Loads and formats data, subsets two days in February

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")
x <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"), ]
x <- cbind(x, paste(x$Date, x$Time))
colnames(x)[10] <- "DateTime"
library(lubridate)
x$DateTime <- dmy_hms(x$DateTime)
x <- cbind(x$DateTime, data.frame(sapply(x[,3:9], as.numeric)))
colNames <- c("DateTime", "GlobalActivePower", "GlobalReactivePower", "Voltage", 
              "GlobalIntensity", "Submetering1", "Submetering2", "Submetering3")
colnames(x) <- colNames

##  Plot 4 
par(mar = c(5.1, 4.1, 2, 2), mfcol = c(2, 2), cex="0.6")
    
## Top Top Left
plot(x$DateTime, x$GlobalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Plot Bottom Left
plot(x$DateTime, x$Submetering1,
     type="l", ylab="Energy sub metering", xlab="")
points(x$DateTime, x$Submetering2, type="l", col="red")
points(x$DateTime, x$Submetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"), bty = "n")

## Plot Top Right
plot(x$DateTime, x$Voltage, type="l", ylab="Voltage", xlab="datetime")

## Plot Bottom Right
plot(x$DateTime, x$GlobalReactivePower, type="l", ylab="Global_reactive_power", xlab="datetime")

## Print same plot to .PNG

dev.copy(png, file = "./ExData_Plotting1/plot4.png")
dev.off()
