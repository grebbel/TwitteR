setwd("~/Documents/workspace/R-project/TwitteR")

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(XML)
library(igraph)


reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "http://api.twitter.com/oauth/access_token"
authURL <- "http://api.twitter.com/oauth/authorize"
consumerKey <- "CKm7HJWoDSH8xJKXoOxDQ"
consumerSecret <- "uK2NQ6oi1BlPMhdP9WG7DyLkRMWxddjNoyptmJGWuI"
twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake() #Pause here for the Handshake Pin Code

registerTwitterOAuth(twitCred)

#save(list="twitCred", file="twitteR_credentials")



## Malaria witter cloud 
a <- searchTwitter("leishmania", n=1000)
tweets_df = twListToDF(a) #Convert to Data Frame



b=Corpus(VectorSource(tweets_df$text), readerControl = list(language = "eng"))
b <- tm_map(b, tolower) #Changes case to lower case 
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

wordcloud(d6$word,d6$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))


## NOW for something new

## So twitter search
a <- searchTwitter("genomics AND genetics", n=1000)
tweets_df = twListToDF(a) #Convert to Data Frame

b=Corpus(VectorSource(tweets_df$text), readerControl = list(language = "eng"))
b <- tm_map(b, tolower) #Changes case to lower case 
b <- tm_map(b, stripWhitespace) #Strips White Space
b <- tm_map(b, removePunctuation) #Removes Punctuation
b <- tm_map(b, removeWords, stopwords("english")) #Removes English stopwords like 'the'
b <- tm_map(b, removeNumbers) #Removes numbers
inspect(b)
tdm <- TermDocumentMatrix(b) 
m1 <- as.matrix(tdm) 
v1 <- sort(rowSums(m1),decreasing=TRUE)
d5 <- data.frame(word = names(v1),freq=v1)

## remove from df words containing http
d6 <- d5[! grepl("^http",d5$word),]



# convert d6 to matrix
transform(d6, freq = as.numeric(freq))
m = as.matrix(d6[0-1])

## extract numbers from second column and convert it to numeric
# m2 <- m[! gregexpr(m[2],0-9+)]

# adjacency matrix
M = m %*% t(m)

# set zeroes in diagonal
diag(M) = 0

# graph
g = graph.adjacency(M, weighted=TRUE, mode="undirected",
                    add.rownames=TRUE)


# layout
glay = layout.fruchterman.reingold(g)

# let's superimpose a cluster structure with k-means clustering
kmg = kmeans(M, centers=8)
gk = kmg$cluster

# create nice colors for each cluster
gbrew = c("red", brewer.pal(8, "Dark2"))
gpal = rgb2hsv(col2rgb(gbrew))
gcols = rep("", length(gk))
for (k in 1:8) {
  gcols[gk == k] = hsv(gpal[1,k], gpal[2,k], gpal[3,k], alpha=0.5)
}

# prepare ingredients for plot
V(g)$size = 10
V(g)$label = V(g)$name
V(g)$degree = degree(g)
#V(g)$label.cex = 1.5 * log10(V(g)$degree)
V(g)$label.color = hsv(0, 0, 0.2, 0.55)
V(g)$frame.color = NA
V(g)$color = gcols
E(g)$color = hsv(0, 0, 0.7, 0.3)

# plot
plot(g, layout=glay)
title("\nGraph of tweets about billgatesfoundation and malaria",
      col.main="gray40", cex.main=1.5, family="serif")

