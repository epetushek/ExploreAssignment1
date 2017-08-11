#plot1.R

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

#Plotting and saving histogram
png(filename = "plot1",height=480, width=480)
hist(testdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
