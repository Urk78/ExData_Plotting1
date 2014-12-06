## In order to run this code you need to have the
## household_power_consumption.txt unzipped in your working directory.

library('data.table')

## read only the right dates from the file
hpc <- fread('grep ^[12]/2/2007 household_power_consumption.txt',
             na.strings = '?')

## set the columnnames
setnames(hpc, names(fread('household_power_consumption.txt', header = T,
                          nrows = 0)))

## open the png graphics device with the right properties 
png('plot1.png', width = 480, height = 480, units = "px")

## draw the histogram
hist(hpc$Global_active_power,col = 'red',
     xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')

## close the graphics device
dev.off()