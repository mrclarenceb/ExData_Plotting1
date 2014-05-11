house <- read.table("household_power_consumption.txt", 
                    sep=";",  
                    strip.white=TRUE,
                    header = TRUE,
                    na.strings = c("?","")) ##na.strings used to replace ? (and empty space) with NA


#house[house == "?"] <- NA  ##na.strings takes care of this

#house$DateTime is a column added that concatenates the Date and Time variables
house$DateTime <- paste(house$Date, house$Time)

house$DateTime <- strptime(house$DateTime, format = "%d/%m/%Y %H:%M:%S")

house$Date <- as.Date(house$Date, format = "%d/%m/%Y")

house$Time <- format(house$Time, format = "%H:%M:%S")

house <- house[house$Date == "2007-02-01" | house$Date == "2007-02-02",]

dt <- sort(house$DateTime)

with(house,plot(dt,house$Sub_metering_1, type="l",
                axes=TRUE, xlab="", 
                cex.lab=.7,
                cex.axis = .7,
                ylab = "Energy sub metering"))


lines(dt,house$Sub_metering_2, type="l",col="red")


lines(dt,house$Sub_metering_3, type="l",col="blue")

legend("topright",  
       
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       
       lty=c(1,1,1),
       
       #lwd=c(1.5,1.5,1.5),
       
       col=c("black","red","blue"),
       
       cex = .7,
       
       text.font = .7, xjust = 0, yjust=0 #, bty="n"
) 

xmin <- which(min(house$DateTime) == house$DateTime) #range(house$DateTime)[1]

xmax <- which(max(house$DateTime) == house$DateTime) #range(house$DateTime)[2]

xmid <- median(order(house$DateTime))

axis(1, at=c(xmin,xmid,xmax), lab=c("Thu","Fri","Sat"))


dev.copy(png,"plot3.png", width=480, height=480)

dev.off()