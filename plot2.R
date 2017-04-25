#Set locale to english so no Finnish date names
Sys.setlocale(category='LC_ALL', locale='english')
file <- file('./dataset/household_power_consumption.txt')

#Get only lines with '1/2/2007' or '2/2/2007' and set column names accordingly
df <- read.table(text = grep('^[1,2]/2/2007', readLines(file), value=TRUE), col.names=c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Kitchen', 'Laundry', 'Other'), header=TRUE, sep=';')

#Create a Datetime -column from formatted df$Date and df$Time -columns
df$Datetime <- as.POSIXct(paste(as.Date(df$Date, format='%d/%m/%Y'), df$Time))

#Plot the continuous df$Datetime against df$Global_active_power
with(df, plot(Datetime, Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)'))

#Copy the active plot from display to png-file and turn off the png-file -device
dev.copy(png, width=480, height=480, 'Plot2.png')
dev.off()