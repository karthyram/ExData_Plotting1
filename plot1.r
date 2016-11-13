### Code for reading data and plot1
library(dplyr)
library(pryr)
library(data.table)
library(tidyr)
library(lubridate)
# Download of data and keep under the directory-----------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- file.path(getwd(), "2Fhousehold_power_consumption.zip")
download.file(url, f)
unzip(f)
# Fetcing the power consumption data------------------------------------
pwrconsp <- read.table("household_power_consumption.txt",header = TRUE,sep = ";", stringsAsFactors = FALSE)
object_size(pwrconsp)
pwrconsp <- pwrconsp %>% mutate (Date_Time = as.POSIXct(dmy_hms(as.character(paste(Date,Time)))))
pwrconsp$Date <- dmy(pwrconsp$Date)
pwrconsp$Date <- as.Date(as.POSIXct(pwrconsp$Date, origin = "01-01-2000", tz = "GMT"))
#pwrconsp$Time <- hms(pwrconsp$Time)
pwrconsp$Global_active_power <- gsub("?","",pwrconsp$Global_active_power)
pwrconsp$Global_reactive_power <- gsub("?","",pwrconsp$Global_reactive_power)
pwrconsp$Global_intensity <- gsub("?","",pwrconsp$Global_intensity)
pwrconsp$Sub_metering_1 <- gsub("?","",pwrconsp$Sub_metering_1)
pwrconsp$Sub_metering_2 <- gsub("?","",pwrconsp$Sub_metering_2)
pwrconsp$Sub_metering_3 <- gsub("?","",pwrconsp$Sub_metering_3)
pwrconsp$Global_active_power <- as.numeric(pwrconsp$Global_active_power,na.rm = TRUE)
pwrconsp$Global_reactive_power <- as.numeric(pwrconsp$Global_reactive_power,na.rm = TRUE) 
pwrconsp$Global_intensity <- as.numeric(pwrconsp$Global_intensity,na.rm = TRUE)
pwrconsp$Sub_metering_1 <- as.numeric(pwrconsp$Sub_metering_1,na.rm = TRUE)
pwrconsp$Sub_metering_2 <- as.numeric(pwrconsp$Sub_metering_2,na.rm = TRUE)
pwrconsp$Sub_metering_3 <- as.numeric(pwrconsp$Sub_metering_3,na.rm = TRUE)
pwrconspsdate <- pwrconsp %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
# plotting plot1.png

png(filename = "plot1.png",width = 480, height = 480)
with(pwrconspsdate,hist(Global_active_power, col = 'red',xlab = "Global Active Power (kilowatts)"
                        ,main = "Global Active Power"))
dev.off()
