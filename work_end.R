##For tracking how lazy I am

setwd('~/Dropbox')
rm(list = ls())

load("work_end.Rda")
today_end <- Sys.time()
today_end <- data.frame(today_end)
## First day: work_end<- today_end
## save(work_end,file="work_end.Rda")
work_end<- rbind(work_end, today_end)
save(work_end,file="work_end.Rda")