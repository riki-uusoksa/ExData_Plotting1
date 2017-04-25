file <- file('./dataset/household_power_consumption.txt')

#Get only lines with '1/2/2007' or '2/2/2007' and set column names accordingly
df <- read.table(text = grep('^[1,2]/2/2007', readLines(file), value=TRUE), col.names=c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Kitchen', 'Laundry', 'Other'), header=TRUE, sep=';')

#Plot histogram with variables
with(df, hist(Global_active_power, col='red', xlab='Global Active Power (kilowatts)', main='Global Active Power'))

#Copy the active plot from display to png-file and turn off the png-file -device
dev.copy(png, width=480, height=480, 'Plot1.png')
dev.off()
