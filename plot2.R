house <- read.table("household_power_consumption.txt", 
                    sep=";",  
                    strip.white=TRUE,
                    header = TRUE,
                    na.strings = c("?","")) ##na.strings used to replace ? (and empty space) with NA


#house[house == "?"] <- NA  ##na.strings takes care of this

#house$DateTime is an additional column that concatenates the Date and Time variables
house$DateTime <- paste(house$Date, house$Time)

house$DateTime <- strptime(house$DateTime, format = "%d/%m/%Y %H:%M:%S")

house$Date <- as.Date(house$Date, format = "%d/%m/%Y")

house$Time <- format(house$Time, format = "%H:%M:%S")

house <- house[house$Date == "2007-02-01" | house$Date == "2007-02-02",]

with(house,plot(sort(house$DateTime),house$Global_active_power, type="l",
                axes=TRUE, xlab="", 
                cex.lab=.7,
                cex.axis = .7,
                ylab = "Global Active Power (kilowatts)"))

xmin <- which(min(house$DateTime) == house$DateTime)

xmax <- which(max(house$DateTime) == house$DateTime)

xmid <- median(order(house$DateTime))

axis(1, at=c(xmin,xmid,xmax), lab=c("Thu","Fri","Sat"))


dev.copy(png,"plot2.png", width=480, height=480)

dev.off()