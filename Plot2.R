################################
# EDA course PROJECT 1
# Plot2.R - produces plot2.png
# Carlo FANARA. 05 august 2014
################################


######### Common part for all the scripts: copied in each script ##### START #########
# First, get the files in the right environment
if(!file.exists("./data")){dir.create("./data")}  # project location, for working and submitting
setwd("./data")   # get in there

# to ensure file exist, else download it
if(!file.exists("./household_power_consumption.txt")){
  download.file("https://class.coursera.org/exdata-005/human_grading/view/courses/972588/assessments/3/submissions", "./data/household_power_consumption.txt")
}

# size is around 20MB
# limits:
# dates 2007-02-01 and 2007-02-02 meanS yyy-mm-dd, so from 1st to 2nd of february 2007, twO days
# having a look at the data, 1 record per minute, there are:
# 45 days btw. the 2 dates, each made of 1440 records, so we read 2880 records
# we need to skip from the top (FIRST DATE) to row 66636 (31/01/2007 last datum, at 23:59;00
PowerComp <- read.csv("./household_power_consumption.txt", nrows=2880, skip=66636, dec=",",sep=";", stringsAsFactors=FALSE)
# we made sure of separators and no factors generation

head(PowerComp) # have a loook at top
tail(PowerComp) # have a loook at bottom



# note that the partial read eliminated the column names
# so we recreate these
names(PowerComp)<-c("Date","Time","Global_Active_Power","Global_Reactive_Power","Voltage",
                    "Global_Intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

######### Common part for all the scripts: copied in each script #####  END ############


###################### PLOT 2: Global Active Power as function of day of week
# between Thursday and saturday (line plot)
# to show day of week, need dates function to get day of week
#library(lubridate)

# because times repeat, they need to carry the date to distinguish the two groups, so use
# paste and strptime
x <- strptime(paste(PowerComp$Date, PowerComp$Time),"%d/%m/%Y %H:%M:%S")
y<-as.numeric(PowerComp$Global_Active_Power)

# first, in order to avoid distorsions, we direct outpu to file, setting the png
# it means we will not see, the plot on screen
png(filename = "./plot2.png",
    width = 480, height = 480, units = "px")
plot(x, y, type = "l",xlab="", ylab="Global Active Power (kilowatts)")

dev.off()


      
    
