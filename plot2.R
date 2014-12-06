## In order to run this code you need to have the
## household_power_consumption.txt unzipped in your working directory.

library('data.table')

hpc <- fread('grep ^[12]/2/2007 household_power_consumption.txt',
             na.strings = '?')

setnames(hpc, names(fread('household_power_consumption.txt', header = T,
                          nrows = 0)))

library('dplyr')

## make a new variable with date and time, delete the old columns 
hpc <- mutate(hpc, DateAndTime = paste(hpc$Date, hpc$Time, sep = ' '))
hpc$Date <- NULL
hpc$Time <- NULL

## save the current locale and set the locale to 'C'
locale <- Sys.getlocale(category = "LC_TIME")
Sys.setlocale("LC_TIME", "C")

png('plot2.png', width = 480, height = 480, units = "px")

## convert the the DateAndTime entries to POSIXlt and make the plot
with(hpc, {
    tmp <- strptime(hpc$DateAndTime, '%e/%m/%Y %H:%M:%S')
    plot(tmp, Global_active_power, type = 'l', xlab = '',
         ylab = 'Global Active Power (kilowatts)')
})

## set the time locale back
Sys.setlocale("LC_TIME", locale)

dev.off()