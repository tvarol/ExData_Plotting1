# Only reading lines that start with specific dates. This way, avoiding to read the whole data
selected_data <- tbl_df(fread("grep \"^1/2/2007\\|^2/2/2007\" ../household_power_consumption.txt"))

# Define the column names
col_names <- c("Date", "Time", "Global Active Power", "Global Reactive Power", "Voltage",
               "Global Intensity", "SubMeter1", "SubMeter2", "SubMeter3")

# Assign the column names to the selected data
names(selected_data) <- col_names

# If there are any ? in data, first replace them by NAs and then remove the missing values
GAP <- selected_data$`Global Active Power`
sub('?', NA, GAP)
subGlobalActivePower <- GAP[!is.na(GAP)]

# Specify the name of the file, width and height of the canvas
png("plot1.png", width=480, height=480)

# Plot the histogram
hist(subGlobalActivePower, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')

# Save and quit
dev.off()

