library(lubridate)
library(dplyr)
library(data.table)

full.data<-read.table("household_power_consumption.txt", na.strings="?", sep=';', header=T)
data<-filter(full.data, Date=='1/2/2007'|Date=='2/2/2007')

data$time<- strptime(paste(as.character(data$Date), as.character(data$Time)), format="%d/%m/%Y %H:%M:%S")
data<-select(data,-(Date:Time))

par(mfcol=c(2,2))

plot(data$Global_active_power, main=NULL, xlab=' ' ,ylab="Global Active Power", type='l', xaxt='n')
lab1<-as.character(lubridate::wday(data$time[1], label=T))
lab2<-as.character(lubridate::wday(data$time[1]+24*3600, label=T))
lab3<-as.character(lubridate::wday(data$time[1]+2*24*3600, label=T))
lab<-c(lab1,lab2,lab3)
axis(1, at=c(1, floor(length(data[,1])/2), length(data[,1])+1), labels=lab)


plot(data$Sub_metering_1, main=NULL, xlab=' ' ,ylab="Energu sub metering", type='l', xaxt='n')
lines(data$Sub_metering_2, col='red')
lines(data$Sub_metering_3, col='blue')
legend('topright', lty=1, col=c('black','red','blue'), legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), bty='n')
axis(1, at=c(1, floor(length(data[,1])/2), length(data[,1])+1), labels=lab)

plot(data$Voltage, main=NULL, xlab='datetime' ,ylab="Voltage", type='l', xaxt='n')
axis(1, at=c(1, floor(length(data[,1])/2), length(data[,1])+1), labels=lab)

plot(data$Global_reactive_power, main=NULL, xlab='datetime' ,ylab="Global_reactive_power", type='l', xaxt='n')
axis(1, at=c(1, floor(length(data[,1])/2), length(data[,1])+1), labels=lab)

dev.copy(png, file="plot4.png")
dev.off()
par(mfcol=c(1,1))