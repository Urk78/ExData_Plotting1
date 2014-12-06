## In order to run this code you need to have the
## household_power_consumption.txt unzipped in your working directory.

library('data.table')

hpc <- fread('grep ^[12]/2/2007 household_power_consumption.txt',
             na.strings = '?')

setnames(hpc, names(fread('household_power_consumption.txt', header = T,
                          nrows = 0)))

library('dplyr')
hpc <- mutate(hpc, DateAndTime = paste(hpc$Date, hpc$Time, sep = ' '))
hpc$Date <- NULL
hpc$Time <- NULL

locale <- Sys.getlocale(category = "LC_TIME")
Sys.setlocale("LC_TIME", "C")

png('plot3.png', width = 480, height = 480, units = "px")

## After plotting the first plot add the other two with the lines command
with(hpc, {
    tmp <- strptime(hpc$DateAndTime, '%e/%m/%Y %H:%M:%S')
    plot(tmp, Sub_metering_1, type = 'l', xlab = '',
         ylab = 'Energy sub metering')
    lines(tmp, Sub_metering_2, type = 'l', col = 'red', xlab = '',
          ylab = 'Energy sub metering')
    lines(tmp, Sub_metering_3, type = 'l', col = 'blue', xlab = '',
          ylab = 'Energy sub metering')
})

## make the legend in the topright corner
legend("topright", lwd = 1, col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

Sys.setlocale("LC_TIME", locale)

dev.off()