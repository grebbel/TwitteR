setwd("~/Documents/workspace/R-project/TwitteR")

library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(tm)
library(wordcloud)
library(ROAuth)
library(wordcloud2)
library(RColorBrewer)
library(XML)
library(igraph)

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "jDupTiIoONjqjGQgZPd9JS4Ga"
consumerSecret <- "2zVIdlnu8IQdYjCZJJCsxAQW05C30rJEVaqhM1xmQBJ5DZp3rM"

accessToken = "367204636-Hk7jDGNWvCk6CWCsjOzkb32R4OqCAmV2KET1LBSb"
accessSecret = "sQf2jYwthMXgylJHxDjVludLkIC3uB0r5pFA5uGRTLvTm"


setup_twitter_oauth(consumerKey,
                    consumerSecret,
                    accessToken,
                    accessSecret)

twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)


twitCred$handshake()

setup_twitter_oauth(consumerKey, consumerSecret, access_token=NULL, access_secret=NULL)

## EDQM twitter cloud 
a <- searchTwitter("EDQM", n=1000)
tweets_df = twListToDF(a) #Convert to Dataframe

b=Corpus(VectorSource(tweets_df$text), readerControl = list(language = "eng"))
#b <- tm_map(b, tolower) #Changes case to lower case
b <- tm_map(b, stripWhitespace) #Strips White Space
b <- tm_map(b, removePunctuation) #Removes Punctuation
b <- tm_map(b, removeWords, stopwords("english")) #Removes English stopwords like 'the'
b <- tm_map(b, removeNumbers) #Removes numbers
inspect(b)


tdm <- TermDocumentMatrix(b) 
m1 <- as.matrix(tdm) 
v1 <- sort(rowSums(m1),decreasing=TRUE)
d4 <- data.frame(word = names(v1),freq=v1)
## remove from df words containing http
d6 <- d4[! grepl("^http",d5$word),]

wordcloud(d4$word,d4$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))



wordcloud(d4$word,d4$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
