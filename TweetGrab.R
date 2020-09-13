


##This R script is the basic twitter data capture guidlines.

#Install twitterR, RCurl, ROAuth before starting. 
#Load the packages
require(twitteR)
require(RCurl)
require(ROAuth)

#Call the Twitter API keys (Generate own set of keys via apps.twitter.com)
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
# Will prompt the quesiton "
##Use a local file ('.httr-oauth'), to cache OAuth access credentials between R sessions?"
###up to you, but I simply said Yes (=1).

#get tweets by searchTwitter function
#Use "Advanced search function" (copy & paste) from Twitter if you want to specify more search parameters
tweetdata <- searchTwitter("search parameter", n= xxxx, lang = "en"  )

#Convert the list to dataframe
tweetdf <- twListToDF(tweetdata)

#Get user information by UserInfo function
userdata <- lookupUsers(tweetdf$screenName, includeNA = F)
##If want to check the length of user names list
length(userdata)
head(userdata)
###create user info dataframe
userdf <- twListToDF(userdata) 

#If userlist is too long
userdata1 <- lookupUsers(tweetdf$screenName[1:xxxx], includeNA=F)
userdata2 <- lookupUsers(tweetdf$screenName[xxx1:xxxx], includeNA=F)
##and go on until you get all the rows of users in tweetdf
###Then, convert them into dataframes
userdf1 <- twListToDF(userdata1)
userdf2 <- twListToDF(userdata2)
....
####comined the user dataframes
userdf <- rbind(userdf1, userdf2, ...)


#Merge the two by joining 
Final <- merge(tweetdf, userdf, by = "screenName")

#Save it into csv format.
#MAC
write.csv(Final, "/path/name.csv", row.names = F)
#PC
write.csv(Final, "path\name.csv", row.names = F)
