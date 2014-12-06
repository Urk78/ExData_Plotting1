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

png('plot4.png', width = 480, height = 480, units = "px")

## use the par and mfcol command to get two plots in each row and column
par(mfcol = c(2,2))

## draw the plots in the right order and adjust them to fit the reference plot
with(hpc, {
    tmp <- strptime(hpc$DateAndTime, '%e/%m/%Y %H:%M:%S')
    plot(tmp, Global_active_power, type = 'l', xlab = '',
         ylab = 'Global Active Power')
    plot(tmp, Sub_metering_1, type = 'l', xlab = '',
         ylab = 'Energy sub metering')
    lines(tmp, Sub_metering_2, type = 'l', col = 'red', xlab = '',
          ylab = 'Energy sub metering')
    lines(tmp, Sub_metering_3, type = 'l', col = 'blue', xlab = '',
          ylab = 'Energy sub metering')
    legend("topright", lwd = 1, box.lwd = 0, cex=0.95,
           col = c('black', 'red', 'blue'),
           legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
    plot(tmp, Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')
    plot(tmp, Global_reactive_power, type = 'l', xlab = 'datetime',
         ylab = 'Global_reactive_power')
})

Sys.setlocale("LC_TIME", locale)

dev.off()