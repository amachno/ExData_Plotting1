full.data<-read.table("household_power_consumption.txt", na.strings="?", sep=';', header=T)
data<-filter(full.data, Date=='1/2/2007'|Date=='2/2/2007')

data$time<- strptime(paste(as.character(data$Date), as.character(data$Time)), format="%d/%m/%Y %H:%M:%S")
data<-select(data,-(Date:Time))

hist(data$Global_active_power, main='Global Active Power', xlab="Global Active Power (kilowatts)", col='red')
dev.copy(png, file="plot1.png")
dev.off()