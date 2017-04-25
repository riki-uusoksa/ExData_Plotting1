#Set locale to english so no Finnish date names
Sys.setlocale(category='LC_ALL', locale='english')
file <- file('./dataset/household_power_consumption.txt')

#Get only lines with '1/2/2007' or '2/2/2007' and set column names accordingly
df <- read.table(text = grep('^[1,2]/2/2007', readLines(file), value=TRUE), col.names=c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), header=TRUE, sep=';')

#Create a Datetime -column from formatted df$Date and df$Time -columns
df$Datetime <- as.POSIXct(paste(as.Date(df$Date, format='%d/%m/%Y'), df$Time))

#Set the current figure to have four plots
par(mfrow=c(2, 2))

#Plot the continuous df$Datetime against df$Global_active_power
with(df, {
  plot(Datetime, Global_active_power, type='l', xlab='', ylab='Global Active Power')
  plot(Datetime, Voltage, type='l', xlab='datetime', ylab='Voltage')
  plot(Sub_metering_1 ~ Datetime, col='black', type='l', xlab='', ylab='Energy sub metering')
  lines(Sub_metering_2 ~ Datetime, col='red')
  lines(Sub_metering_3 ~ Datetime, col='blue')
  legend('topright', col=c('black', 'red', 'blue'), bty='n', lty=1, legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), pt.cex=1, cex=0.8)
  plot(Datetime, Global_reactive_power, type='l', xlab='datetime')
})

#Copy the active plot from display to png-file and turn off the png-file -device
dev.copy(png, width=680, height=480, 'Plot4.png')
dev.off()