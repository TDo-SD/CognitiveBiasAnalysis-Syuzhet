library(syuzhet)

options(max.print=1000000)

data <- read.csv("GitterComR.csv")

msgs <- data[["message"]]

nrc_sentiments <- get_sentiment(msgs, method = "nrc")
syuzhet_sentiments <- get_sentiment(msgs, method = "syuzhet")

emotions <- get_nrc_sentiment(msgs, language = "english")