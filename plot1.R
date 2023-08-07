#Plot 1 R script
###############################
#Step 1: Calculate rough estimate of memory usage
#The website says the atributes are Real, so numeric, numeric data use 8 bytes 
#per cell. In researching the different data types, time uses 3-5 bytes, 
#dates use 4 bytes, so we will just use 8 bytes to estimate all of them
#for the rough estimate, since the website says all are numeric data.
#I will convert the date and times to date and time data later.
#Referenced a lecture from Data Scientists Toolbox

x <- 2075259*9*8  #calculate bytes
y <- x/2^20 #calculate MB
z <- y/2^10 #calculate GB
z*2  #gives R twice the GB for memory usage

#[1] 0.2783139
#I will need .2783139 GB of memory. My computer is fine, it can handle it.

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
#Use hist with labels
#save file as a png, close the connection 
#################################

#change variable Global_Active_power from chr to numeric
tidy_data$Global_active_power <- as.numeric(as.character(tidy_data$Global_active_power))



#Create the histogram with labels
hist(tidy_data$Global_active_power,col ="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

#Save the graph to a png file 480x480 pixels
png(filename = "plot1.png", width=480, height=480)

#Close the save connection
dev.off()
