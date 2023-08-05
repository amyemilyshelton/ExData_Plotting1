#Plot 2 R script
###############################
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



str(tidy_data)
##################################
#Step 3 - make the Plots
#Plot2 plots Global Active Powerto datetime
#Change Global_active_power to numeric
#Use lpot with labels
#label x with Thu, Fri, Sat
#save file as a png, close the connection 
#################################
#change variable Global_Active_power from chr to numeric
tidy_data$Global_active_power <- as.numeric(as.character(tidy_data$Global_active_power))

#Create the histogram with labels
plot(tidy_data$datetime, tidy_data$Global_active_power,type="l",xlab= "", ylab = "Global Active Power (kilowatts)")


#Save the graph to a png file 480x480 pixels
png(filename = "plot2.png", width=480, height=480)

dev.off()
plot.new()
