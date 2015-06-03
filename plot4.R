library(lubridate)
library(data.table)

# load data into data.table
powerconsumption <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE,
                               na.strings = "?", colClasses = c(rep("character", 2),rep("numeric", 7)))

# subsetting on relevant date through regular expression
powerconsumption <- powerconsumption[grep("^(1|2)/2/2007",powerconsumption[,1]),]

# convert & add date/time field to data.table
powerconsumption[,10] <- dmy(powerconsumption[,1]) + hms(powerconsumption[,2])

# open file device
png(filename = "./plot4.png")

# canvas for 4 graphs
par(mfcol = c(2,2))

# plot the graph on top left
plot(powerconsumption[,10], powerconsumption[,3], type = "l", xlab = "", ylab = "Global Active Power")

# plot the graph on bottom left
plot(powerconsumption[,10], powerconsumption[,7], type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
lines(powerconsumption[,10], powerconsumption[,8], col = "red")
lines(powerconsumption[,10], powerconsumption[,9], col = "blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),lty = "solid")

# plot the graph on top right
plot(powerconsumption[,10], powerconsumption[,5], type = "l", xlab = "datetime", ylab = "Voltage")

# plot the graph on bottom right
plot(powerconsumption[,10], powerconsumption[,4], type = "l", xlab = 'datetime', ylab = 'Global_reactive_power')

# off device
dev <- dev.off()