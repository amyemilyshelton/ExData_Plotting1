#Plot 4 R script
#Load the packages I will be using, tidyverse includes dplyr, lubridate
#Load janitor to change the 
library(tidyverse)
library(janitor)


#######################################
#Step 2 Read the data in, subset to use only 2007-02-01 and 2007-02-02
#Convert Date and Time to Date and Time classes: In the date file Date is
#formatted as dd/mm/yyyy and time is formatted as hh:mm:ss
#Use as.Date() and strptime(), make a datetime column
#######################################

#Read the data set in save as data, the delimiter is a semicolon
data <- read.table("household_power_consumption.txt", sep = ";") 

#Look at the first 6 rows of data and check the class of each column
head(data)

#Row 1 the column names are V1 - V9, row two contains Descriptive column names
#Make row two the column names (uses janitor package)
data2 <- row_to_names(data, row_number = "find_header", remove_rows_above = TRUE)

#subset the data by 2007-02-01 and 2007-02-02
tidy_data <- filter(data2, Date == "1/2/2007" | Date == "2/2/2007")


#Combine Date column and Time column into datetime column formatted as POSIXct
tidy_data$datetime <- with(tidy_data, as.POSIXct(paste(Date, Time), 
                                                 format = "%d/%m/%Y %H:%M:%S"))



##################################
#Step 3 - make the Plots
#Plot1 plots Golbal Avtive Power and frequency
#Change Global_active_power to numeric
#Change Global_reactive_power to numeric
#Change Sub_metering_1 to numeric
#Change Sub_metering_2 to numeric
#Change Sub_metering_3 to numeric
#Change Voltage to numeric
#Use plot with labels
#save file as a png, close the connection 
#################################
View(tidy_data)
#change variable Global_Active_power from chr to numeric
tidy_data$Global_active_power <- as.numeric(as.character(tidy_data$Global_active_power))
tidy_data$Sub_metering_1 <- as.numeric(as.character(tidy_data$Sub_metering_1))
tidy_data$Sub_metering_2 <- as.numeric(as.character(tidy_data$Sub_metering_2))
tidy_data$Sub_metering_3 <- as.numeric(as.character(tidy_data$Sub_metering_3))
tidy_data$Global_reactive_power <- as.numeric(as.character(tidy_data$Global_reactive_power))
tidy_data$Voltage <- as.numeric(as.character(tidy_data$Voltage))

tidy_data$datetime <- strptime(paste(tidy_data$Date,tidy_data$Time), "%d/%m/%Y %H:%M:%S")

str(tidy_data)

#Save the graph to a png file 480x480 pixels
png(filename = "plot4.png", width=480, height=480, units="px")

#Create the the 4 plots, plot 2 and plot 3 plus 2 new plots
#set up the screen to show 4 plots, change margins based on plots
par(mfrow=c(2,2), mar=c(2, 4, .5,0.5))

plot(tidy_data$datetime, tidy_data$Global_active_power,type="l", xaxt="n", xlab= "", ylab = "Global Active Power")

r <- as.POSIXct(round(range(tidy_data$datetime),"days"))
axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")

plot(tidy_data$datetime, tidy_data$Voltage, type="l", xaxt="n", xlab="datetime", ylab="Voltage")

r <- as.POSIXct(round(range(tidy_data$datetime),"days"))
axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")

plot(tidy_data$datetime, tidy_data$Sub_metering_1, type="l", xaxt="n", ylab="Energy Submetering", xlab="")
lines(tidy_data$datetime, tidy_data$Sub_metering_2, type="l", col="red")
lines(tidy_data$datetime, tidy_data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

r <- as.POSIXct(round(range(tidy_data$datetime),"days"))
axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")

plot(tidy_data$datetime, tidy_data$Global_reactive_power, type="l", xaxt="n", xlab="datetime", ylab="Golbal_reactive_power")

r <- as.POSIXct(round(range(tidy_data$datetime),"days"))
axis.POSIXct(1, at=seq(r[1],r[2],by="days"),format="%a")


dev.off()
