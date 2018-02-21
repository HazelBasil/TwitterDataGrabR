##This R script is the basic twitter data capture guidlines.

#Install twitterR, RCurl, ROAuth before starting. 
#Load the packages
require(twitteR)
require(RCurl)
require(ROAuth)

#Call the Twitter API keys
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
# Will prompt the quesiton "
##Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?"
###up to you, but I simply said Yes (=1).

#get tweets by searchTwitter function
#Use Advanced search function from Twitter if you want to specify more search parameters
##The user -tweet merge can be easily done upto around 15000 tweets.
tweet <- searchTwitter("SearchKeyword SpecificParameter", n=15000, lang = "en"  )

#Convert the list to dataframe
tweetdf <- twListToDF(tweet)

#Get user information by UserInfo function
user <- lookupUsers(tweetdf$screenName)
#If want to check the length of user names list
length(user)

#convert the list to dataframe
userdf <- twListToDF(user) 

#Merge the two by joining
tweet_final <- merge(tweetdf, userdf, by = "screenName")

#Save it into csv format
##for MAC
write.csv(tweet_final, "path/tweet_final.csv", row.names = F)
##for PC
write.csv(tweet_final, "path\tweet_final.csv", row.names = F)
