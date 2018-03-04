twitteR in paRasitology: #plasmodium
========================================================

Text here


```r
setwd("~/Documents/workspace/R-project/TwitteR")

library(twitteR)
```

```
## Loading required package: ROAuth
## Loading required package: RCurl
## Loading required package: bitops
```

```
## Warning: package 'bitops' was built under R version 3.0.1
```

```
## Loading required package: digest
## Loading required package: rjson
```

```
## Warning: package 'rjson' was built under R version 3.0.1
```

```r
library(tm)
library(wordcloud)
```

```
## Loading required package: Rcpp
```

```
## Warning: package 'Rcpp' was built under R version 3.0.1
```

```
## Loading required package: RColorBrewer
```

```r
library(RColorBrewer)
library(XML)
library(igraph)
```

```
## Warning: package 'igraph' was built under R version 3.0.2
```




```r
## #malaria tiwtter cloud

a <- searchTwitter("#malaria", n = 1000)
```

```
## Error: OAuth authentication is required with Twitter's API v1.1
```

```r
tweets_df = twListToDF(a)  #Convert to Data Frame
```

```
## Error: object 'a' not found
```


You can also embed plots, for example:


```r
b = Corpus(VectorSource(tweets_df$text), readerControl = list(language = "eng"))
```

```
## Error: object 'tweets_df' not found
```

```r
b <- tm_map(b, tolower)  #Changes case to lower case 
```

```
## Error: object 'b' not found
```

```r
b <- tm_map(b, stripWhitespace)  #Strips White Space
```

```
## Error: object 'b' not found
```

```r
b <- tm_map(b, removePunctuation)  #Removes Punctuation
```

```
## Error: object 'b' not found
```

```r
b <- tm_map(b, removeWords, stopwords("english"))  #Removes English stopwords like 'the'
```

```
## Error: object 'b' not found
```

```r
b <- tm_map(b, removeNumbers)  #Removes numbers
```

```
## Error: object 'b' not found
```

```r
inspect(b)
```

```
## Error: object 'b' not found
```

```r
tdm <- TermDocumentMatrix(b)
```

```
## Error: object 'b' not found
```

```r
m1 <- as.matrix(tdm)
```

```
## Error: object 'tdm' not found
```

```r
v1 <- sort(rowSums(m1), decreasing = TRUE)
```

```
## Error: object 'm1' not found
```

```r
d4 <- data.frame(word = names(v1), freq = v1)
```

```
## Error: object 'v1' not found
```

```r
wordcloud(d4$word, d4$freq, random.order = FALSE, colors = brewer.pal(8, "Dark2"))
```

```
## Error: object 'd4' not found
```


Wheeha
