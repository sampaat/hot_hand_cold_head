required_packages <- c("tidyverse", "slider", "readr")

missing <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if (length(missing) > 0) {
  message("Installing missing packages: ", paste(missing, collapse = ", "))
  install.packages(missing)
}

message("✔ Package check complete.")

library(tidyverse)
require(slider)
require(readr)

#download bitstamp market price history

exchrate <- readr::read_csv(url, show_col_types = FALSE) %>%
  mutate(datetime = as.POSIXct(timestamp, origin = "1970-01-01", tz = "UTC")) %>%
  subset(datetime >= as.POSIXct("2012-05-02", tz = "UTC") & datetime <  as.POSIXct("2013-10-02", tz = "UTC")) %>%
  rename(price = close)


#create table with daily weighted mean prices
dailyprices <- exchrate %>%
  mutate(daydate = as.Date(datetime)) %>%
  group_by(daydate) %>%
  summarize(dayprice = sum(price*volume)/sum(volume)) %>%
  ungroup() %>%
  rename(date = daydate)

#calculate 7 day rolling window stdev and mean prices and relative deviation (filter applied for dataset availability)
relSD_moving_21d <-  slider::slide_dfr(dailyprices, .before = 10, .after = 10, .complete = TRUE,
                                            .f = function(x){summarise(x, start = min(date), end = max(date), date = mean(date),  mean_price = mean(dayprice), sd_price = sd(dayprice))}) %>%
                            mutate(relSD = sd_price/mean_price) %>%
                            arrange(relSD) %>%
                            filter((start > "2012-04-21 19:10:01 CEST") & (end < "2014-12-28 21:59:16 CET"))
#plot relSD and pick a few ranges by hand 
ggplot(relSD_moving_21d, aes(x = start, y = relSD)) +
  geom_line()


ranges_selected <- tibble(
  start = as.Date(c("2012-05-02","2012-09-17","2012-12-17","2013-05-04","2013-09-11")),
  end = as.Date(c("2012-05-22","2012-10-07","2013-01-06","2013-05-24","2013-10-01"))) %>%
  mutate(dlist = map2(start, end, function(x,y)seq(x, y, by="days")))

higlight_range <- as.Date(unlist(ranges_selected$dlist), origin="1970-01-01")
  

relSD_moving_21d_toplot <- relSD_moving_21d %>%
  mutate(highlighted = date %in% higlight_range) %>%
  arrange(start) %>%
  left_join(dailyprices, by = "date") %>%
  mutate(logprice = log10(dayprice))

scale_range_rate <- 21

ggplot(relSD_moving_21d_toplot, aes(x = date)) +
  geom_line(aes(y = logprice, color = "red")) +
  geom_line(aes(y = relSD*scale_range_rate, color = "blue")) +
  scale_fill_manual(values = c(NA, "green")) +
  geom_tile(aes(
    x = date,
    y = 0,
    height = Inf,
    fill = highlighted
  ), alpha = .4) +
  scale_y_continuous(
    name = "Bitcoin price in USD",
    labels = function(b){10^b},
    sec.axis = sec_axis(~./scale_range_rate,name="Relative deviation of price")
  )

#the following is used in data_preaparation_bitcoin.R

ranges_selected_data <- ranges_selected %>%
  mutate(timestamp_start = as.numeric(as.POSIXct(start)),
         timestamp_end = as.numeric(as.POSIXct(end + 1))) #to include the whole ending day

#data in the following table is used to create Table 1.
ranges_selected %>%
  left_join(relSD_moving_21d %>%
              filter(end < as.Date("2014-04-21")) %>%
              mutate(totMeanRelSD = mean(relSD)),
            by = c("start","end")) %>%
    mutate(relSD_perc = 100*relSD) %>%
  select(start_date = start, mean_daily_price = mean_price, relative_daily_price_deviation_percent = relSD_perc)


  