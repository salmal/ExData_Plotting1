# create a vector of the classes for the column to help it read faster
colclass <- c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')
#read the unzipped file
powcon <- read.table("household_power_consumption.txt", header = T, sep = ';',
                     numerals = 'allow.loss', na.strings = '?', colClasses = colclass)
#subset the dataframe to the required dates
powcon <- powcon[powcon$Date == '1/2/2007' | powcon$Date == '2/2/2007' ,]
#create a new column combining the date and the time columns into 1
powcon$datetime <- strptime(paste(powcon[,1], powcon[,2],sep=' '), '%d/%m/%Y %T')
# open the graphics device
png(filename = 'plot4.png')
#set the number of plots per row and column
par(mfrow = c(2,2))
# set margins to create more space
par(mar = c(4,4,1,1))
with(powcon,{
      plot(datetime, Global_active_power, type = 'l',
           xlab = '', ylab = 'Global Active Power (kilowatts)', cex.lab = .8)
      # plot the values for datetime and voltage
      plot(datetime, Voltage, type = 'l')
      # plot for submetering values
      plot(datetime, Sub_metering_1,type = "n", ylab = 'Energy sub metering',
           xlab='', cex.lab = .8)
      points(datetime, Sub_metering_1, type = 'l')
      points(datetime, Sub_metering_2, col = 'red', type = 'l')
      points(datetime, Sub_metering_3, col = 'blue', type = 'l')
      legend("topright",  lwd = 1, seg.len = 2, col = c('black',"blue", "red"),
             legend = c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'),
             cex = .6, bty = 'n')
      #plot for global reactive power
      plot(datetime, Global_reactive_power, type='l')
      
})
#close the device
dev.off()