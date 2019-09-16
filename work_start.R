##For tracking how lazy I am

setwd('~/Dropbox')
rm(list = ls())

load("work_start.Rda")
today_start <- Sys.time()
today_start <- data.frame(today_start)
## First day: work_start<- today_start
## save(work_start,file="work_start.Rda")
work_start<- rbind(work_start, today_start)
save(work_start,file="work_start.Rda")

