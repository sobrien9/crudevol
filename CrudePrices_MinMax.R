#This tries to visualize Crude volatility over the past 160 years
library(dplyr)
library(lubridate)
library(dygraphs)
library(zoo)
library(xts)

price_file <- 'volatility_prices.csv'
stages_file <- 'volatility_stages.csv'

prices.frame <- read.csv(file=price_file, head = TRUE)
stages.frame <- read.csv(file=stages_file, head = TRUE)

stages.frame$COMBINED_DATE <- paste0("01-", stages.frame$COMBINED_DATE)
stages.frame$COMBINED_DATE <- dmy(stages.frame$COMBINED_DATE)


prices.frame$Date <- paste0(prices.frame$YEAR, "-1-", "1")
prices.frame$Date <- ymd(prices.frame$Date)
prices.frame <- prices.frame %>%
  select(Date, NOMINAL_MAX, NOMINAL_MIN)

xtdata <- xts(prices.frame, order.by = prices.frame$Date) 

dygraph(xtdata, main = "Crude Oil Max and Mins in Each Year") %>%
  #dyHighlight(highlightSeriesOpts = list(strokeWidth = 3)) %>%
  dyOptions(colors = c("red", "navy")) %>%
  dyLegend(width = 400) %>% 
  dyShading(from = "1859-1-1", to = "1880-1-1", color = "#FFE6E6") %>%
#  dyShading(from = "1880-1-1", to = "1911-1-1", color = "#CCEBD6") %>% 
  dyShading(from = "1911-1-1", to = "1933-1-1", color = "#FFE6E6") %>% 
#  dyShading(from = "1933-1-1", to = "1973-1-1", color = "#CCEBD6") %>% 
#  dyShading(from = "1973-1-1", to = "2007-1-1", color = "#FFE6E6") %>% 
  dyShading(from = "2007-1-1", to = "2016-1-1", color = "#FFE6E6") %>%   
  dyEvent("1880-1-1", "Boom Bust I", labelLoc = "bottom") %>%
  dyEvent("1933-1-1", "Boom Bust II", labelLoc = "bottom") %>%
  dyEvent("2016-1-1", "Boom Bust III", labelLoc = "bottom")

