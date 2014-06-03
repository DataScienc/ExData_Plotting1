#################################################################
#       Plots a Histogram of Global Active Power                #
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

##  Plot 1

par(mar = c(5.1, 3, 2, 2), cex = 0.8, mfcol = c(1, 1))
hist(x$GlobalActivePower, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
png(filename="./ExData_Plotting1/plot1.png")
hist(x$GlobalActivePower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
