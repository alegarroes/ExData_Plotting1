# import library to read file
library(data.table)
library(lubridate)
library(dplyr)

# read data file
file <- file.path("data", "exdata_data_household_power_consumption")
file <- file.path(file, "household_power_consumption.txt")
data <- fread(file)

# subset data 
february_data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007"]

# paste Date and Time columns
february_data <- mutate(february_data, DateTime = paste(february_data$Date, february_data$Time))

# cast DateTime column as POSIXct format
february_data$DateTime <- dmy_hms(february_data$DateTime)
# Global_active_power as numeric
february_data$Global_active_power <- as.numeric(february_data$Global_active_power)
february_data$Global_reactive_power <- as.numeric(february_data$Global_reactive_power)
february_data$Voltage <- as.numeric(february_data$Voltage)
february_data$Sub_metering_1 <- as.numeric(february_data$Sub_metering_1)
february_data$Sub_metering_2 <- as.numeric(february_data$Sub_metering_2)
february_data$Sub_metering_3 <- as.numeric(february_data$Sub_metering_3)

# create line plot for Global Active Power and save it to a png file
png(filename = "plot2.png")
with(february_data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
