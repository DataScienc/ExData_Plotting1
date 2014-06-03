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

##  Plot 3
par(mar = c(3.1, 5.1, 3.1, 2.1))
plot(x$DateTime, x$Submetering1,
     type="l", ylab="Energy sub metering", xlab="")
points(x$DateTime, x$Submetering2, type="l", col="red")
points(x$DateTime, x$Submetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))
png(filename="./ExData_Plotting1/plot3.png")
plot(x$DateTime, x$Submetering1,
     type="l", ylab="Energy sub metering", xlab="")
points(x$DateTime, x$Submetering2, type="l", col="red")
points(x$DateTime, x$Submetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))
dev.off()
