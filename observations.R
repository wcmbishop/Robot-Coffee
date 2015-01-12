# observations.R
#
# scripts for analyzing coffee shop observations
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Packages
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library(dplyr)
library(RSQLite)
library(magrittr)
library(ggplot2)
theme_set(theme_grey(20))

# Scripts
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# Functions
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sandbox <- function() {
  
  # connect to SQLite
  db <- src_sqlite(path = file.path('data', 'observations.db'), create = FALSE)
  # connect to tables
  orders <- tbl(db, "orders")
  items <- tbl(db, "items")
  # join tables
  obs <- inner_join(orders, items, by='item')

  obs_df <- collect(obs)
  obs_df$start_time <- as.POSIXct(obs_df$start_time)
  obs_df$end_time <- as.POSIXct(obs_df$end_time)
  obs_df
  g <- ggplot(obs_df, aes(as.factor(start_time)))
  g + geom_bar(aes(fill=type, weight=cost*count)) +
    labs(x='Time', y='Cost [$]')
  #
}

