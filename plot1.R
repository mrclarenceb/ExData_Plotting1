house <- read.table("household_power_consumption.txt", 
                   sep=";",  
                   strip.white=TRUE,
                   header = TRUE,
                   na.strings = c("?","")) ##na.strings used to replace ? (and empty space) with NA


#house[house == "?"] <- NA

house$DateTime <- paste(house$Date, house$Time)

house$DateTime <- strptime(house$DateTime, format = "%d/%m/%Y %H:%M:%S")

house$Date <- as.Date(house$Date, format = "%d/%m/%Y")

house$Time <- format(house$Time, format = "%H:%M:%S")

house <- house[house$Date == "2007-02-01" | house$Date == "2007-02-02",]

with(house,hist(house$Global_active_power, col="red", ylim=c(0,1200), main="Global Active Power", xlab = "Global Active Power (kilowatts)")
)


dev.copy(png,"plot1.png", width=480, height=480)

dev.off()