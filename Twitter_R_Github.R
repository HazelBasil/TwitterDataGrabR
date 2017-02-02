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
tweet <- searchTwitter("SearchKeyword SpecificParameter", n=10000, lang = "en"  )

#Convert the list to dataframe
tweetdf <- twListToDF(tweet)

#Get user information by UserInfo function
user <- lookupUsers(tweetdf$screenName)
#If want to check the length of user names list
length(user)

#convert the list to dataframe
userdf <- twListToDF(user) 

#Merge by "column-bind" between tweet_df and user_info_df 
##Make sure that users are in the same order between the two files.
tweet_final <- cbind(tweetdf, userdf)

#Save it into csv format.
write.csv(tweet_final, file = '~/Desktop/tweet_final.csv', row.names = F)