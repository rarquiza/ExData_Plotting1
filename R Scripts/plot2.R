#
# plot2.R
#

# The electric consumption file is 133 MB and can be loaded in most 
# modern computers with several GB of memory.
# The assumption is the file is in the data folder of current 
# directory.
# 
power_consumption <- read.table("./data/household_power_consumption.txt",sep=";", header=TRUE, colClasses=c(rep("character",9)))

# Read in the dates to a POSIXlt format
date_power <- strptime(power_consumption$Date,"%d/%m/%Y")

# Set the range of dates to extract
date1 <- strptime("31/1/2007","%d/%m/%Y")
date1
date2 <- strptime("3/2/2007","%d/%m/%Y")
date2

# Extract a subset for 2/1/2007 - 2/2/2007
power_consumption_subset <- power_consumption[which(date_power>date1 & date_power<date2),]

# Change missing values with ? to NA and make them numeric for columns 3-9
cols <- c(3:9)
power_consumption_subset[,cols] <- apply(power_consumption_subset[,cols],2,function(x) gsub('?',NA,x,fixed=TRUE))
power_consumption_subset[,cols] <- apply(power_consumption_subset[,cols],2,function(x) as.numeric(x))

# Convert Date and Time fields to POSIXct timestamp
global_timestamp <- as.POSIXct(paste(power_consumption_subset$Date,power_consumption_subset$Time),format="%d/%m/%Y %H:%M:%S")

# Plot and save it as a PNG file
png("plot2.png", width=480, height=480)
plot(global_timestamp,power_consumption_subset$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
