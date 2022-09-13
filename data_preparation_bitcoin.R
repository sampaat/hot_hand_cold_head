require(groundhog)
groundhog.day="2021-03-01"
pkgs=c('tidyverse','sqldf')
groundhog.library(pkgs, groundhog.day)

# gametable mined from https://web.archive.org/web/20130403062213/http://www.satoshidice.com/
# rip after 2014 https://www.sec.gov/news/press-release/2014-111

gamesTable <- c(
  "lessthan","64000","1dice9wVtrKZTBbAZqz1XiTmboYyvpD3t","97.6563","1.004","1.900","98.100","0.0010","250.0000",
  "lessthan","60000","1diceDCd27Cc22HV3qPNZKwGnZ8QwhLTc","91.5527","1.071","1.900","98.100","0.0010","250.0000",
  "lessthan","56000","1dicegEArYHgbwQZhvr5G9Ah2s7SFuW1y","85.4492","1.147","1.900","98.100","0.0010","250.0000",
  "lessthan","52000","1dicec9k7KpmQaA8Uc8aCCxfWnwEWzpXE","79.3457","1.235","1.900","98.100","0.0010","250.0000",
  "lessthan","48000","1dice9wcMu5hLF4g81u8nioL5mmSHTApw","73.2422","1.338","1.900","98.100","0.0010","250.0000",
  "lessthan","32768","1dice97ECuByXAvqXpaYzSaQuPVvrtmz6","50.0000","1.957","1.900","98.100","0.0010","250.0000",
  "lessthan","32000","1dice8EMZmqKvrGE4Qc9bUFf9PX3xaYDp","48.8281","2.004","1.900","98.100","0.0010","250.0000",
  "lessthan","24000","1dice7W2AicHosf5EL3GFDUVga7TgtPFn","36.6211","2.670","1.900","98.100","0.0010","250.0000",
  "lessthan","16000","1dice7fUkz5h4z2wPc1wLMPWgB5mDwKDx","24.4141","4.003","1.900","98.100","0.0010","219.6353",
  "lessthan","12000","1dice7EYzJag7SxkdKXLr8Jn14WUb3Cf1","18.3105","5.335","1.900","98.100","0.0010","152.1241",
  "lessthan","8000","1dice6YgEVBf88erBFra9BHf6ZMoyvG88","12.2070","8.000","1.900","98.100","0.0010","120.9568",
  "lessthan","6000","1dice6wBxymYi3t94heUAG6MpG5eceLG1","9.1553","10.666","1.900","98.100","0.0010","120.9090",
  "lessthan","4000","1dice6GV5Rz2iaifPvX7RMjfhaNPC8SXH","6.1035","15.996","1.900","98.100","0.0010","77.9318",
  "lessthan","3000","1dice6gJgPDYz8PLQyJb8cgPBnmWqCSuF","4.5776","21.326","1.900","98.100","0.0010","57.4951",
  "lessthan","2000","1dice6DPtUMBpWgv8i4pG8HMjXv9qDJWN","3.0518","31.987","1.900","98.100","0.0010","59.3926",
  "lessthan","1500","1dice61SNWEKWdA8LN6G44ewsiQfuCvge","2.2888","42.647","1.900","98.100","0.0010","44.1897",
  "lessthan","1000","1dice5wwEZT2u6ESAdUGG6MHgCpbQqZiy","1.5259","63.968","1.900","98.100","0.0010","29.2270",
  "lessthan","512","1dice4J1mFEvVuFqD14HzdViHFGi9h4Pp","0.7813","124.933","1.900","98.100","0.0010","14.8497",
  "lessthan","256","1dice3jkpTvevsohA4Np1yP4uKzG1SRLv","0.3906","249.861","1.900","98.100","0.0010","7.3951",
  "lessthan","128","1dice37EemX64oHssTreXEFT3DXtZxVXK","0.1953","499.717","1.900","98.100","0.0010","3.6902",
  "lessthan","64","1dice2zdoxQHpGRNaAWiqbK82FQhr4fb5","0.0977","999.429","1.900","98.100","0.0010","3.2050",
  "lessthan","32","1dice2xkjAAiphomEJA5NoowpuJ18HT1s","0.0488","1998.853","1.900","98.100","0.0010","1.6017",
  "lessthan","16","1dice2WmRTLf1dEk4HH3Xs8LDuXzaHEQU","0.0244","3997.701","1.900","98.100","0.0010","0.8006",
  "lessthan","8","1dice2vQoUkQwDMbfDACM1xz6svEXdhYb","0.0122","7995.397","1.900","98.100","0.0010","0.4002",
  "lessthan","4","1dice2pxmRZrtqBVzixvWnxsMa7wN2GCK","0.0061","15990.789","1.900","98.100","0.0010","0.2001",
  "lessthan","2","1dice1Qf4Br5EYjj9rnHWqgMVYnQWehYG","0.0031","31981.573","1.900","98.100","0.0010","0.1000",
  "lessthan","1","1dice1e6pdhLzzWQq7yMidf6j8eAg7pkY","0.0015","64000.000","1.844","98.156","0.0010","0.0500") %>%
  matrix(ncol = 9, byrow = T, dimnames = list(NULL,c("Name","Bet","Address","WinOdds","PriceMultiplier","HousePercent","ExpectedReturn","MinBet","MaxBet"))) %>%
  as_tibble() %>%
  mutate(Bet = as.integer(Bet)) %>%
  mutate(WinOdds = as.numeric(WinOdds)) %>%
  mutate(PriceMultiplier = as.numeric(PriceMultiplier)) %>%
  mutate(HousePercent = as.numeric(HousePercent)) %>%
  mutate(ExpectedReturn = as.numeric(ExpectedReturn)) %>%
  mutate(MinBet = as.numeric(MinBet)*10^8) %>% #we work in satoshis, not coins
  mutate(MaxBet = as.numeric(MaxBet)*10^8)

# input datasets are from Kondor et. al. Do the Rich Get Richer?... https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0086197
# dataset available online at https://datadryad.org/stash/dataset/doi:10.5061/dryad.qz612jmcf
# the datasets used below first need to be downloaded manually, you need the 2013 versions
# eol characters may have to be changed dependent on windows/unix systems used

#get addrIDs connected to the adresses in the game table
#use bitcoin_2013_addresses.csv.gz
satoshi_addrIDs <- read.csv.sql(file = "rawdata/kondor_to_14/addresses.txt",
                                header = F,
                                eol = "\n",
                                sep = "\t",
                                sql = "select * from gamesTable
                                          left join file on gamesTable.Address = file.v2"
) %>%
  select(V1,V2) %>%
  rename(addrID = V1, Address = V2)

##########################
#bets placed with timestamps

#get bets placed on the game adresses
#use bitcoin_2013_txout.csv.xz
bet_placed_tx <- read.csv.sql(file = "rawdata/kondor_to_14/txout.txt",
                              header = F,
                              eol = "\n",
                              sep = "\t",
                              sql = "select * from satoshi_addrIDs
                              inner join file on satoshi_addrIDs.AddrID = file.v2"
) %>%
  select(V1, V2, V3) %>%
  rename(txID = V1, addrID = V2, value = V3)

#adding timestamps
bet_placed_timed_tx <- read.csv.sql("rawdata/kondor_to_14/txtime.txt",
                                    header = F,
                                    eol = "\n",
                                    sep = "\t",
                                    sql = "select * from bet_placed_tx
                                         inner join file on bet_placed_tx.txID = file.v1"
) %>%
  rename(time = V2) %>%
  select(-V1)


# delete big variables of intermittent steps
rm(bet_placed_tx)
gc()

##########################
#bets answers by satoshidce with timestamps

#get answers sent by game addresses
bet_answered_tx <- read.csv.sql("rawdata/kondor_to_14/txin.txt",
                                header = F, 
                                eol = "\n",
                                sep = "\t", 
                                sql = "select * from satoshi_addrIDs
                              inner join file on satoshi_addrIDs.AddrID = file.v2"
) %>% 
  select(V1, V2, V3) %>% 
  rename(txID = V1, addrID = V2, value = V3)
#adding transaction time
bet_answered_timed_tx <- read.csv.sql("rawdata/kondor_to_14/txtime.txt",
                                      header = F, 
                                      eol = "\n",
                                      sep = "\t", 
                                      sql = "select * from bet_answered_tx
                                         inner join file on bet_answered_tx.txID = file.v1"
) %>% 
  rename(time = V2) %>%
  select(-V1)

# delete big variables of intermittent steps
rm(bet_answered_tx)
gc()

##########################
#combining bets and answers

#these should not overlap
bet_placed_timed_tx %>% 
  pull(txID) %>%
  unique() %in%
  {bet_answered_timed_tx %>% 
      pull(txID) %>%
      unique()} %>%
  sum()

#no overlap, we can continue

#the file sourced below gives a brief explanation on why the 5 time windows have been calculated as such
#it also produces the table where we get the timestamps for filtering the transaction files above further
source("bitcoin_pricehistory_lowvar.R")

#the calculation below is quite memory intensive, its suggested to do 1 at a time and then increase the WINDOW variable between on c(1,2,3,4,5)
WINDOW <- 5

#filter for the sample timeframe
bet_placed_timed_tx_win1 <- bet_placed_timed_tx %>%
  filter((time > ranges_selected_data$timestamp_start[[WINDOW]])&(time < ranges_selected_data$timestamp_end[[WINDOW]]))
bet_answered_timed_tx_win1 <- bet_answered_timed_tx %>%
  filter((time > ranges_selected_data$timestamp_start[[WINDOW]])&(time < ranges_selected_data$timestamp_end[[WINDOW]]))

#adding incoming transaction of bets
bet_placed_timed_tx_win1_in <- read.csv.sql("rawdata/kondor_to_14/txin.txt",
                                            header = F, 
                                            eol = "\n",
                                            sep = "\t", 
                                            sql = "select * from bet_placed_timed_tx_win1
                                   left join file on bet_placed_timed_tx_win1.txID = file.v1"
) %>% 
  rename(addrID_in = V2) %>%
  select(-V1) %>%
  select(-V3)

#adding target addresses of answers
bet_answered_timed_tx_win1_out <- read.csv.sql("rawdata/kondor_to_14/txout.txt",
                                               header = F, 
                                               eol = "\n",
                                               sep = "\t", 
                                               sql = "select * from bet_answered_timed_tx_win1
                              left join file on bet_answered_timed_tx_win1.txID = file.v1"
) %>% 
  rename(addrID_out = V2, value_out = V3) %>%
  select(-V1)

#we are pairing up all bets with all possible answer transactions
bet_match_win1 <- bet_placed_timed_tx_win1_in %>% 
  left_join(bet_answered_timed_tx_win1_out, by = c("addrID_in" = "addrID_out", "addrID", "value"))

rm(bet_placed_timed_tx_win1, bet_answered_timed_tx_win1, bet_answered_timed_tx_win1_out)
gc()

#basic method with just selecting the match with the smallest positive time diff 
#this can produce false matches: bets made in close succession can be paired with the same answer, but we can test for duplications after

FEE = ifelse(WINDOW < 2,0,50000) #after 2012.oct 11 there is a transaction fee included

txy_used <- c()
pairReturnTransaction <- function(x,...){
#this function makes sure we dont use the same return transaction twice
  line_match <- x %>% 
    filter(!(txID.y %in% txy_used)) %>%
    top_n(n = 1, wt = desc(timediff))
    
    txy_used <<- c(txy_used,line_match$txID.y) 
    return(line_match)
}
bet_match_uniqued <- bet_match_win1 %>%
  drop_na() %>%
  mutate(timediff = time.y - time.x) %>%
  filter(timediff >= 0)  %>%
  arrange(time.x) %>%
  group_by(txID.x, addrID, value) %>%
  group_modify(pairReturnTransaction)
txy_used <- c()

bet_match_finallized <- bet_match_uniqued %>%
  select(txID.x, txID.y, time.x, timediff, addrID_in, addrID, value, value_out) %>%
  distinct() %>%
  left_join(win_odds, by = c("addrID" = "addrID_game")) %>%
  mutate(ratt = (value_out+FEE)/value) %>%
  mutate(status = ifelse(ratt > .9,"win","loss")) %>% #win/loss flag is calculated based on the return transaction amount
  mutate(status = ifelse(value == value_out, NA, status)) %>% #when the bet is above the maximum or below the minimum amount, the answer transaction is identical in amount
  arrange(txID.x, addrID, value)

#count bets where we couldn't decide the pairs (idiosyncratic answers)
#78 transactions found for WINDOW 1 (444-2/1241-3/4380-4/1344-5)
bet_match_finallized %>%
  group_by(txID.x, addrID, value) %>%
  filter(n()>1) %>%
  ungroup() %>%
  pull(txID.x) %>%
  unique() %>%
  length()
#lets also check if we have used any answer multiple times (should be zero)
bet_match_finallized %>%
  group_by(txID.y, addrID, value) %>%
  filter(n()>1) %>%
  ungroup() %>%
  pull(txID.y) %>%
  unique() %>%
  length()

#lets just add NA status to them
bet_match_finallized_idiosinc <- bet_match_finallized %>%
  group_by(txID.x, addrID, value) %>%
  filter(n()>1) %>%
  top_n(n = 1) %>%
  ungroup() %>%
  mutate(status = NA)

#and replace them in the dataset

bet_match_finallized <- bet_match_finallized %>%
  group_by(txID.x, addrID, value) %>%
  filter(n()==1) %>%
  ungroup() %>%
  bind_rows(bet_match_finallized_idiosinc)

#we can check how many bets we have been able to match return transactions to
#success rate really nice 95.77% for WINDOW 1 (94.59%-2/97.19%-3/94.65%-4/93.04%-5)
bet_match_finallized %>% 
  drop_na() %>%
  nrow() / {
    bet_placed_timed_tx_win1_in %>% 
      mutate(xxx = paste0(txID, addrID)) %>% 
      pull(xxx) %>% 
      unique() %>% 
      length()}

#check if the odds are about expected in the observations
pwin_checkup <- bet_match_finallized %>% 
  drop_na() %>%
  mutate(win = status=="win") %>%
  group_by(PriceMultiplier) %>%
  summarize(n = n(),
            win_rate = sum(win)/n()*100,
            .groups = "drop") %>%
  left_join(gamesTable %>% select(PriceMultiplier,WinOdds), by = "PriceMultiplier") %>%
  mutate(pwin_diff = win_rate-WinOdds)  
  
#add users
bet_match_finallized_usered <- read.csv.sql("rawdata/kondor_to_14/contraction2.csv",
                                            header = T, 
                                            eol = "\n",
                                            sep = ",", 
                                            sql = "select * from bet_match_finallized
                              left join file on bet_match_finallized.addrID_in = file.addrID"
)

#prepare and save the results
bet_match_finallized_merged_usered_tosave <- bet_match_finallized_usered[,-12] %>% 
  rename(txID_bet = txID.x, txID_answer = txID.y, time_bet = time.x, 
         addrID_player = addrID_in, addrID_game = addrID, bet_value = value, answer_value = value_out, odds = PriceMultiplier) %>%
  select(txID_bet, txID_answer, time_bet, timediff, addrID_player, addrID_game, bet_value, answer_value, odds, status, userID)


#be sure to change the save files between windows so you do not overwrite your previous files
write.csv(bet_match_finallized_merged_usered_tosave, file = paste("calcdata/satoshidice_bets_matched_",ranges_selected_data$start[[WINDOW]],"to",ranges_selected_data$end[[WINDOW]],"clean.csv",sep="_"))
