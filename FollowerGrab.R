#Grab follower information.
##Reference: https://www.r-bloggers.com/mapping-twitter-followers-in-r/

#Load the packages
require(twitteR)
require(RCurl)
require(ROAuth)
require(data.table)

#Call the Twitter API keys (Generate own set of keys via apps.twitter.com)
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

#Download the Followers of a Given Twitter Account 

###First, getUser extract every information about the user. 
user <- getUser("userhandle")

### test for location
location(user)

### Second, among the information, get the followers
####To prevent the API limit, use "retryOnRateLimit"
user_follower_IDs<-user$getFollowers(retryOnRateLimit=180)

####Double-check that you successfully pulled data on every follower of the account, 
####by ensuring that the length of this new list you just generated is the same as the number of followers you know that the account has.
length(lucaspuente_follower_IDs)

##Organize the data in the form of data frame, by using lappy and rbindlist
user_followers_df = rbindlist(lapply(user_follower_IDs,as.data.frame))

###Check out 10 first in the list
head(user_followers_df$location, 10)

###If you want to remove certain followers, for example those who lef blank in location field
user_followers_df_rm <-subset(user_followers_df, location!="")
