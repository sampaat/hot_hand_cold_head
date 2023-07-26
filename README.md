# Approaching the Hot Hand with a Cool Head
Data preparatory and analytical scripts of "Approaching the Hot Hand with a Cool Head" by Máté Csaba Sándor and Barna Bakó of Corvinus University of Budapest

This script set reproduces the results presented in (**1**)

To run the scripts use R version 4.0.0 (2020-04-24) and the package versions as specified using groundhog.

## Producing the gambling dataset

The gambling dataset was created using the transactional data extractable from the bitcoin ledger. To make things simpler we have been using a formated dataset from (**2**), available currently at (**3**). To replicate the dataset, use the script *data_preparation_bitcoin.R*. Do not run the script as it is, since first you need to download the appropriate datasets from above which takes considerable time. Also there are some variables that need manual adjustment, to avoid overwhelming most desktop computers.

## The prepared gambling dataset

The 5 samples that we have created are made available at (**4**). These contain bets placed at SatoshiDice, a bitcoin based gambling site that was the most popular of such between 2012 and 2014 and using the public information available in the ledger and the user contraction approximation of (**2**). A representative archive state of the game and the website is available at (**5**).

The columns featured in the dataset (names in the first row):

  * *txID_bet*  transaction ID of the bet transaction [integer]
  * *txID_answer* transaction ID of the answer transaction [integer]
  * *time_bet* unixtime of the bet transaction based on the block timestamp [integer]
  * *timediff* seconds between the timestamp of the bet transaction and the answer based on the block timestamps [integer]
  * *addrID_player* initiating address ID of the bet transaction, the ID gathered from the dataset, not resolved to true bitcoin IDs, in case of multiple addresses, the top address is used, since this is the one SatoshiDice uses for the return transaction by default [integer]
  * *addrID_game* reciving/initiating address ID of the bet/answer transaction, the ID gathered from the dataset, not resolved to true bitcoin IDs [integer]
  * *bet_value* bet ammount (or wager) measured in satoshis (1 satoshi = 1e-8 BTC) [integer]
  * *answer_value* answer ammount (or payout) measured in satoshis (1 satoshi = 1e-8 BTC), 1e5 satoshis [integer]
  * *PriceMultiplier* price multipliers (or odds) of the games the bets are put on, these are used to decide on status using bet and answer value, the multipliers are mined from (**5**) [double]
  * *status*  "win"/"loose" tags calculated using bet and answer value combined with odds [string]
  * *userID*  assigned based on addrID_player using the methods and dataset of (**2**) [integer]

**To acces the dataset, click here:** [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5600259.svg)](https://doi.org/10.5281/zenodo.5600259)

## Replicating research

Use the R workbook *hot_hand_cold_head.Rmd* to reproduce research results presented in (**1**).

With questions about the dataset or the process, contact Máté Sándor (sampaat at gmail dot com).

## References

  1. Sándor, M.C., Bakó, B (2021). Approaching the Hot Hand with a Cool Head (Working paper) https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3952051
  2. Kondor, D., Pósfai, M., Csabai, I., & Vattay, G. (2014). Do the rich get richer? An empirical analysis of the BitCoin transaction network. PLoS ONE, 9(2), e86197. https://doi.org/10.1371/journal.pone.0086197
  3. https://doi.org/10.5061/dryad.qz612jmcf
  4. [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5600259.svg)](https://doi.org/10.5281/zenodo.5600259)
  5. https://web.archive.org/web/20130403062213/http://www.satoshidice.com/
  

