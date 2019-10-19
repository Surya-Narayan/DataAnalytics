


#MULTIVARIATE ANALYSIS

#Loading the dataset
df= read.csv("C:\\Users\\Sanjana Shekar\\Desktop\\SEM 5\\5. Data Analytics\\multivariate\\youtube.csv")
head(df)
#Getting the correlation matrix
correlation_matrix <- cor(df)
round(correlation_matrix,2)
library(corrplot)
corrplot(correlation_matrix,method="number")

mymod<- lm(cbind(estimated_partner_revenue,estimated_monetized_playbacks)~(watch_time_minutes
                                                                           +views+average_view_duration+
                                                                             playback_based_cpm),data=df)
summary(mymod)

fit <- manova(mymod)
summary(fit,test="Pillai")

#remove average_view_duration due to low pillai value
mymod<- lm(cbind(estimated_partner_revenue,estimated_monetized_playbacks)~(watch_time_minutes
                                                                           +views+
                                                                             playback_based_cpm),data=df)
summary(mymod)

fit <- manova(mymod)
summary(fit,test="Pillai")


#when we try to remove playback_based_cpm due to high p-value adjusted r square drops from 90% to 28%
mymod<- lm(cbind(estimated_partner_revenue,estimated_monetized_playbacks)~(watch_time_minutes
                                                                           +views),data=df)
summary(mymod)

fit <- manova(mymod)
summary(fit,test="Pillai")

#if we drop views, again adjusted r square decreases.
mymod<- lm(cbind(estimated_partner_revenue,estimated_monetized_playbacks)~(watch_time_minutes
                                                                           +
                                                                             playback_based_cpm),data=df)
summary(mymod)

fit <- manova(mymod)
summary(fit,test="Pillai")


#So we retain views
mymod<- lm(cbind(estimated_partner_revenue,estimated_monetized_playbacks)~(watch_time_minutes
                                                                           +views+
                                                                             playback_based_cpm),data=df)
summary(mymod)
fit <- manova(mymod)
summary(fit,test="Pillai")



#Testing

new_value <- data.frame(watch_time_minutes=1724.296,views=542,playback_based_cpm=7.321)
print(predict(mymod,new_value))


