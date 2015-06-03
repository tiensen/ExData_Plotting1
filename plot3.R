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
png(filename = "./plot3.png")

# plot the graph
plot(powerconsumption[,10], powerconsumption[,7], type='l', col = "black", xlab = "", ylab = "Energy sub metering")
lines(powerconsumption[,10], powerconsumption[,8], col = "red")
lines(powerconsumption[,10], powerconsumption[,9], col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = "solid")

# off device
dev <- dev.off()