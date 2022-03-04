library(syuzhet)
library(tm)
library(ggplot2)

options(max.print=20000)

data <- read.csv("GitterComR.csv")

msgs <- data[["message"]]

#nrc_sentiments <- get_sentiment(msgs, method = "nrc")
#syuzhet_sentiments <- get_sentiment(msgs, method = "syuzhet")

emotions <- get_nrc_sentiment(msgs, language = "english")

#THIS IS TO GET THE GRAPH
graphDATA <- get_nrc_sentiment(as.character(msgs))
transposedDATA <- data.frame(t(graphDATA))
new_result <- data.frame(rowSums(transposedDATA))

names(new_result)[1] <- "count"
new_result <- cbind("sentiment" = rownames(new_result), new_result)
rownames(new_result) <- NULL

qplot(sentiment, data=new_result[1:8,], weight=count, geom="bar",fill=sentiment)+ggtitle("GitterCom Sentiments")
qplot(sentiment, data=new_result[9:10,], weight=count, geom="bar",fill=sentiment)+ggtitle("GitterCom Sentiments")

anger <- emotions[["anger"]]
anticipation <- emotions[["anticipation"]]
disgust <- emotions[["disgust"]]
fear <- emotions[["fear"]]
joy <- emotions[["joy"]]
sadness <- emotions[["sadness"]]
surprise <- emotions[["surprise"]]
trust <- emotions[["trust"]]
positive <- emotions[["positive"]]
negative <- emotions[["negative"]]

angerCOL <- data.frame(instances=character())
anticipationCOL <- data.frame(instances=character())
disgustCOL <- data.frame(instances=character())
fearCOL <- data.frame(instances=character())
joyCOL <- data.frame(instances=character())
sadCOL <- data.frame(instances=character())
surpriseCOL <- data.frame(instances=character())
trustCOL <- data.frame(instances=character())
posCOL <- data.frame(instances=character())
negCOL <- data.frame(instances=character())

for (val in anger){
  if(val > 0) angerCOL[nrow(angerCOL) + 1,] = c("anger")
  else angerCOL[nrow(angerCOL) + 1,] = c(" ")
}

for (val in anticipation){
  if(val > 0) anticipationCOL[nrow(anticipationCOL) + 1,] = c("anticipation")
  else anticipationCOL[nrow(anticipationCOL) + 1,] = c(" ")
}

for (val in disgust){
  if(val > 0) disgustCOL[nrow(disgustCOL) + 1,] = c("disgust")
  else disgustCOL[nrow(disgustCOL) + 1,] = c(" ")
}

for (val in fear){
  if(val > 0) fearCOL[nrow(fearCOL) + 1,] = c("fear")
  else fearCOL[nrow(fearCOL) + 1,] = c(" ")
}

for (val in joy){
  if(val > 0) joyCOL[nrow(joyCOL) + 1,] = c("joy")
  else joyCOL[nrow(joyCOL) + 1,] = c(" ")
}

for (val in sadness){
  if(val > 0) sadCOL[nrow(sadCOL) + 1,] = c("sadness")
  else sadCOL[nrow(sadCOL) + 1,] = c(" ")
}

for (val in surprise){
  if(val > 0) surpriseCOL[nrow(surpriseCOL) + 1,] = c("surprise")
  else surpriseCOL[nrow(surpriseCOL) + 1,] = c(" ")
}

for (val in trust){
  if(val > 0) trustCOL[nrow(trustCOL) + 1,] = c("trust")
  else trustCOL[nrow(trustCOL) + 1,] = c(" ")
}

for (val in positive){
  if(val > 0) posCOL[nrow(posCOL) + 1,] = c("positive")
  else posCOL[nrow(posCOL) + 1,] = c(" ")
}

for (val in negative){
  if(val > 0) negCOL[nrow(negCOL) + 1,] = c("negative")
  else negCOL[nrow(negCOL) + 1,] = c(" ")
}

df1 <- data.frame(angerCOL, anticipationCOL, disgustCOL, fearCOL, joyCOL, sadCOL, surpriseCOL, trustCOL, negCOL, posCOL)
df1$Combined <- paste(df1$instances, df1$instances.1, df1$instances.2, df1$instances.3, df1$instances.4, df1$instances.5, df1$instances.6, df1$instances.7, df1$instances.8, df1$instances.9, sep=" ")

NRTEmotions <- df1[["Combined"]]

newtable <- data.frame(df1, emotions)

write.csv(newtable, "C:\\Users\\notho\\OneDrive\\Desktop\\TEST\\INSTANCES.csv", row.names = FALSE)