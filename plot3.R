# Only reading lines that start with specific dates. This way, avoiding to read the whole data
selected_data <- tbl_df(fread("grep \"^1/2/2007\\|^2/2/2007\" ../household_power_consumption.txt"))

# Define the column names
col_names <- c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage",
               "Global Intensity", "SubMeter1", "SubMeter2", "SubMeter3")

# Assign the column names to the selected data
names(selected_data) <- col_names

# If there are any ? in data, first replace them by NAs and then remove the missing values
sub('?', NA, selected_data)
selected_data <- selected_data[complete.cases(selected_data),]

# Combine date and time
selected_data$DateTime <- strptime(paste(selected_data$Date,selected_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Specify the name of the file, width and height of the canvas
png("plot3.png", width=480, height=480)

# Plot
with(selected_data, plot(selected_data$DateTime, selected_data$SubMeter1,
                         type='l', xlab='', ylab='Energy sub metering', col='black'))

lines(selected_data$DateTime, selected_data$SubMeter2,col="red")
lines(selected_data$DateTime, selected_data$SubMeter3,col="blue")
legend('topright', col=c('black', 'red', 'blue'), lty=1, bty='n',
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# Save and quit
dev.off()


