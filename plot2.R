## Load Data from Workspace ##


library(data.table)
library(dplyr)

rawdata <- data.table(read.table(file="household_power_consumption.txt", sep=";", header=TRUE))

febdata <- rawdata %>% 
  mutate(Date2=as.Date(Date, format = "%d/%m/%Y")) %>%
  filter(Date2=="2007-02-01" | Date2=="2007-02-02") %>%
  mutate(Date3=paste(Date2,Time))

febdata$Datetime <- strptime(febdata$Date3, format="%Y-%m-%d %H:%M:%S")




## Plot 2 ##
png("plot2.png",width = 480, height = 480)
plot(febdata$Datetime, as.numeric(as.character(febdata$Global_active_power)), type="l",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
