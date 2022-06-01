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

# create a 2x2 plot
par(mfrow = c(2,2), mar = c(4, 4, 2, 1))
# plot 1
with(february_data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# plot 2
with(february_data, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
# plot 3
with(february_data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(february_data, lines(DateTime, Sub_metering_1, col = "black"))
with(february_data, lines(DateTime, Sub_metering_2, col = "red"))
with(february_data, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot 4
with(february_data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
# copy to png file
dev.copy(png, file = "plot4.png")
dev.off()
