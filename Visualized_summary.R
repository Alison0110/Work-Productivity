#Trend Summary
setwd('~/Dropbox')
rm(list = ls())
library("ggplot2")
library("dplyr")
library("scales")
library("lubridate")

load("work_start.Rda")
load("work_end.Rda")
names(work_start) <- c("time")
names(work_end) <- c("time")
work_start$mark <- 1
work_end$mark <- 2
summary <- bind_rows(work_start, work_end)
summary <- summary %>% 
  mutate(hour = hms::hms(second(time), minute(time), hour(time)),
         date = format(time, format="%Y-%m-%d"))
ylabel <- c("0:00", "6:00", "12:00", "18:00", "24:00")
theme_update(plot.title = element_text(hjust = 0.5))
ggplot(data=summary, aes(x = summary$date,y = summary$hour,colour = summary$mark, group = summary$mark)) + 
  geom_line() +
  geom_point() +
  coord_cartesian(ylim = c(0, 86400)) +
  scale_y_continuous(breaks = seq(0, 86400, by = 21600), labels = ylabel) +
  labs(y = "Hour", x = "Date") +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.5), legend.title=element_blank()) + 
  ggtitle("For Tracking How Lazy I Am")


#============================================================================
#RUN FROM HERE TO CHECK MY WORK CALENDAR


#Monthly Summary
setwd('~/Dropbox')
rm(list = ls())
library("lattice")
library("grid")
library("chron")
library("lubridate")
library("dplyr")
source("https://raw.githubusercontent.com/iascchen/VisHealth/master/R/calendarHeat.R")

load("work_start.Rda")
load("work_end.Rda")
work_start$date <- as.POSIXct(strptime(work_start$today_start, format = "%Y-%m-%d"))
work_end$date <- as.POSIXct(strptime(work_end$today_end, format = "%Y-%m-%d"))
calendar <- merge(work_start, work_end, by=c("date"))
calendar$worktime <- difftime(calendar$today_end, calendar$today_start, units="hours")

#Plot the calendar
calendarHeat(dates = calendar$date,
             values = calendar$worktime,
             color = "g2r",
             varname = "Work Time")