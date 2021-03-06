DF.row1 <- read.table("../exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE, nrow = 1)
nc <- ncol(DF.row1)
DF.Date <- read.table("../exdata-data-household_power_consumption/household_power_consumption.txt", sep = ";", header = TRUE, as.is = TRUE, 
                      colClasses = c(NA, rep("NULL", nc - 1)))
DF.Date <- as.Date(DF.Date[, 1], "%d/%m/%Y")
n1 <- which.max(DF.Date >= "2007-02-01")
n2 <- which.max(DF.Date > "2007-02-02")

DF3 <- read.table("../exdata-data-household_power_consumption/household_power_consumption.txt", col.names = names(DF.row1), sep =";", skip = n1, nrows = (n2 - n1), as.is = TRUE)

DF3[ , 1] <- as.Date(DF3$Date, "%d/%m/%Y")
DF3$Time <- strptime(paste0(DF3$Date, ' ', DF3$Time), '%Y-%m-%d %H:%M:%S')
par(mfrow = c(2,2))
with(DF3, {
        plot(Time, Global_active_power, type = "n",ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Time, Global_active_power)
        plot(Time, Voltage, type = "n",ylab = "Voltage", xlab = "datetime")
        lines(Time,Voltage)
        plot(Time, Sub_metering_1, type = "n",ylab = "Energy sub metering", xlab = "")
        lines(Time, Sub_metering_1)
        lines(Time, Sub_metering_2, col="red")
        lines(Time, Sub_metering_3, col="blue")
        legend("topright" , col = c("black", "blue", "red"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty  = 3)
        plot(Time, Global_reactive_power, type = "n",ylab = "Global_reactive_power", xlab = "datetime")
        lines(Time,Global_reactive_power)
})
dev.copy(png, "plot4.png")
dev.off()