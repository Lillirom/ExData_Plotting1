## Load Data from Workspace ##


library(data.table)
library(dplyr)

rawdata <- data.table(read.table(file="household_power_consumption.txt", sep=";", header=TRUE))

febdata <- rawdata %>% 
  mutate(Date2=as.Date(Date, format = "%d/%m/%Y")) %>%
  filter(Date2=="2007-02-01" | Date2=="2007-02-02") %>%
  mutate(Date3=paste(Date2,Time))

febdata$Datetime <- strptime(febdata$Date3, format="%Y-%m-%d %H:%M:%S")




## Plot 4 #

png("plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

#1
plot(febdata$Datetime, as.numeric(as.character(febdata$Global_active_power)), type="l",
     xlab="", ylab="Global Active Power")

#2
plot(febdata$Datetime, as.numeric(as.character(febdata$Voltage)), type="l",
     xlab="datetime", ylab="voltage")

#3
plot(febdata$Datetime, as.numeric(as.character(febdata$Sub_metering_1)), type="l",
     xlab="", ylab="Energy sub metering", col="black")
lines(febdata$Datetime,as.numeric(as.character(febdata$Sub_metering_2)), type="l", col="red")
lines(febdata$Datetime,as.numeric(as.character(febdata$Sub_metering_3)), type="l", col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lwd=1)

#4
plot(febdata$Datetime, as.numeric(as.character(febdata$Global_reactive_power)), type="l",
     xlab="datetime",ylab="Global_reactive_power", col="black")

dev.off()