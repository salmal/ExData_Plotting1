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
png(filename = 'plot3.png')
#reset the number of plots per row and column
par(mfrow = c(1,1))
# reset margins to default
par(mar = c(5,4,4,2))
# draw a plot for the submetering values
with(powcon, plot(datetime, Sub_metering_1,type = "n", ylab = 'Energy sub metering',
                  xlab=''))
with(powcon, points(datetime, Sub_metering_1, type = 'l'))
with(powcon, points(datetime, Sub_metering_2, col = 'red', type = 'l'))
with(powcon, points(datetime, Sub_metering_3, col = 'blue', type = 'l'))
legend("topright",  lwd = 1, seg.len = 2, col = c('black',"blue", "red"),
       legend = c('Sub_metering_1', 'Sub_metering_2','Sub_metering_3'),
       cex = .7)
#close the device
dev.off()