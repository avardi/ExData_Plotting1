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
plot(DF3$Time, DF3$Global_active_power, type = "n",ylab = "Global Active Power (kilowatts)", xlab = "")
lines(DF3$Time, DF3$Global_active_power)
dev.copy(png, "plot2.png")
dev.off()