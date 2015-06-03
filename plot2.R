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
png(filename = "./plot2.png")

# plot the graph
plot(powerconsumption[,10], powerconsumption[,3], type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# off device
dev <- dev.off()