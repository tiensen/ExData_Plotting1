library(data.table)

# load data into data.table
powerconsumption <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE,
                              na.strings = "?", colClasses = c(rep("character", 2),rep("numeric", 7)))

# subsetting on relevant date through regular expression
powerconsumption <- powerconsumption[grep("^(1|2)/2/2007",powerconsumption[,1]),]

# open file device
png(filename = "./plot1.png")

# plot the graph
hist(powerconsumption[,3], main = "Global Active Power", xlab="Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")

# off device
dev <- dev.off()