#Lesson 3
#Question 2

library(ggplot2)
data(diamonds)

qplot(x = price, data = diamonds)+
  scale_x_continuous(breaks = seq(0,20000,500), lim = c(0,20000))
ggsave('PriceHistogram_Q2.png')

#Question 3
#Answer:The center of the price distribution is around $500-1000 with a spike of about 15000 diamonds.  The median and mean for the data sets are $2401 and $3933 respectively.

#Question 5
qplot(x = price, data = diamonds, binwidth = 1000)+
  scale_x_continuous(breaks = seq(0,10000,1000), lim = c(0,10000))
ggsave('PriceHistogram_Q5.png')

#Question 6
qplot(x= price, data = diamonds) +
  facet_wrap(~cut, ncol = 5)
ggsave('PriceHistogram_Q6.png')

#Question 8
qplot(x= price, data = diamonds) +
  facet_wrap(~cut, ncol = 5, scales = "free_y")
ggsave('PriceHistogram_Q8.png')

#Question 9
qplot(x= log10(price/carat), data = diamonds, binwidth = 0.05) +
  facet_wrap(~cut, ncol = 5, scales = "free_y")
ggsave('PricePerCarattHistogram_Q9.png')

#Question 10
qplot(x = color, y = price, data = diamonds, geom = 'boxplot')
by(diamonds$price, diamonds$color, summary)
ggsave('ColorPriceBoxplot_Q10.png')

#Question 12
qplot(x = color, y = price/carat, data = diamonds, geom = 'boxplot')
by(diamonds$price/diamonds$carat, diamonds$color, summary)
ggsave('ColorPricePerCaratBoxPlot_Q12.png')

#Question 14
install.packages('tidyr')
library(tidyr)
library(dplyr)
unemployment <- read.csv('unemployment.csv',header = TRUE, check.names = FALSE)
colnames(unemployment) <- as.character(c('Country',1981:2005))
unemployment <- gather(unemployment, "year",'percent', 2:26)
unemployment <- select(unemployment, Country, year, percent)
qplot(x = year, y = percent, data = subset(unemployment, !is.na(percent))) +
  scale_x_discrete(breaks = seq(1980,2005,5)) +
  facet_wrap(~Country, ncol = 5)
ggsave('Unemployment_Q14.png')

#Question 15
birthdays <- read.csv('birthdays.csv',header = TRUE, check.names = FALSE)
birthdays <- separate(birthdays, 'Start Date', c("Start_Month", "Start_Day", "Start_Year"))
birthdays <- separate(birthdays, 'End Date', c("End_Month", "End_Day", "End_Year"))
birthdays[,2] <- as.numeric(birthdays[,2])
birthdays <- arrange(birthdays, Start_Month)
qplot(x= Start_Day, data = birthdays)+
  scale_x_discrete(breaks = seq(1,31,5))+
  facet_wrap(~Start_Month, ncol = 4)
ggsave('Birthdays_Q15.png')
