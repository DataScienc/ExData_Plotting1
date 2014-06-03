#################################################################
#       Plots Global Active Power Over Two Days           #
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
              "GlobalIntensity", "Submetering1", "submetering2", "submetering3")
colnames(x) <- colNames

##  Plot 2
par(mar = c(3.1, 5.1, 3.1, 2.1))
plot(x$DateTime, x$GlobalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")

png(filename="./ExData_Plotting1/plot2.png")
plot(x$DateTime, x$GlobalActivePower, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
