#plot4.R

library(data.table)

# Downloading Data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest_file <- "Dataset.zip"
download.file(url, destfile = dest_file, method = "curl")
d <- unzip(dest_file)

#Reading Data
data <- read.table(d[1], sep =";",header = TRUE, na.strings = "?")

#Converting date
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#Subsetting data
testdata <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

#Creating datetime varibale
datetime <- paste(as.Date(testdata$Date), testdata$Time)
testdata$Datetime <- as.POSIXct(datetime)

#Plotting and saving histogram
png(filename = "plot4",height=480, width=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(testdata, {plot(Global_active_power~Datetime, type="l", ylab="Global Active Power", xlab="")
  plot(Voltage~Datetime, type="l", ylab="Voltage", xlab=" datetime")
  plot(Sub_metering_1~Datetime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", ylab="Global_rective_power",xlab="datetime")
})
dev.off()
