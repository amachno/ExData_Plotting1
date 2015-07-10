full.data<-read.table("household_power_consumption.txt", na.strings="?", sep=';', header=T)
data<-filter(full.data, Date=='1/2/2007'|Date=='2/2/2007')

data$time<- strptime(paste(as.character(data$Date), as.character(data$Time)), format="%d/%m/%Y %H:%M:%S")
data<-select(data,-(Date:Time))

plot(data$Global_active_power, main=NULL, xlab=' ' ,ylab="Global Active Power (kilowatts)", type='l', xaxt='n')
lab1<-as.character(wday(data$time[1], label=T))
lab2<-as.character(wday(data$time[1]+24*3600, label=T))
lab3<-as.character(wday(data$time[1]+2*24*3600, label=T))
lab<-c(lab1,lab2,lab3)
axis(1, at=c(1, floor(length(data[,1])/2), length(data[,1])+1), labels=lab)
dev.copy(png, file="plot3.png")
dev.off()