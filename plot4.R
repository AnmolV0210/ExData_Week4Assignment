##Loading libraries
library(data.table)
library(dplyr)
library("ggplot2")

#if(!file.exists("Source_Classification_Code.rds") | !file.exists("summarySCC_PM25.rds"))
#    unzip("exdata_data_NEI_data.zip")

##Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI %>% mutate(SCC = as.factor(SCC))
 
##Merging datasets
data <- merge(NEI,SCC,by = "SCC")

##Subsetting Fuel combustion due to coal and calculating emissions for each year
sub <- subset(data, data$EI.Sector == "Fuel Comb - Electric Generation - Coal" | data$EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal ")
sub <- aggregate(x = sub$Emissions, by = list(sub$year), sum)
names(sub) <- c("year","Coal")

##Plotting usnig png device
png("plot4.png")

print({ggplot(data = sub, aes(year,Coal, colour = year)) + geom_line(alpha = 1/2, lwd = 1) + 
    labs(title = "Coal Emissions over the Years", y = "Coal - Emissions", x = "Years")})

dev.off()