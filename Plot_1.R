
## 1 -  Download the household_power_consumption data set and Place in location on Computer
## Look at your current directory
## and set it to what you want it to be

getwd()
setwd("C:\\Users\\Michael\\Desktop\\Coursera\\Exploratory_Data_Analysis")
getwd()


path <- getwd()


##Create Library Refs and make sure all packages Loaded

library(dplyr)
library(data.table)
library(lubridate)
library(ggplot2)
library(reshape)
library(scales)

##Read in text file

dat1 <- tbl_df(read.table(file.path(path, "household_power_consumption.txt"),header = TRUE,sep = ';',colClasses = "character"))


dat1.3 <- transform(dat1,Date_chron = as.Date(as.character(Date),format = "%d/%m/%Y"))

dat2 <-
  dat1.3 %>%
  mutate(Global_active_power = as.numeric(Global_active_power)
         ,Global_reactive_power = as.numeric(Global_reactive_power)
         ,Voltage = as.numeric(Voltage)
         ,Sub_metering_1 = as.numeric(Sub_metering_1)
         ,Sub_metering_2 = as.numeric(Sub_metering_2)
         ,Sub_metering_3 = as.numeric(Sub_metering_3)
         ,Time = paste(dat1$Date,dat1$Time,sep = " ")
          )%>%
  filter(Date_chron =="2007-02-01"|Date_chron =="2007-02-02")


dat3 <- transform(dat2,"Time" = dmy_hms(as.character(Time))
                  ,"day" = wday(Date_chron,label = TRUE))          
  
dat4 <- dat3[complete.cases(dat3),]

## Plot 1 - Create Plot 1

Plot1 <- with(dat4,hist(Global_active_power,main = "Global Active Power"
        ,xlab="Gobal Active Power(Kilowatts)"
        ,col="red"))

## Copy to png file in set directory

dev.copy(png,file = "Plot1.png",width = 480, height = 480)
dev.off()


