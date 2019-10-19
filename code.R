
#importing libraries
library(fpp)
library(astsa)
library(DT)
library(dygraphs)

#importing dataset
beer <- read.csv("C:\\Users\\Sanjana Shekar\\Desktop\\SEM 5\\5. Data Analytics\\time series\\beer_production.csv")
head(beer)

#converting to time series model
beer.ts <- ts(beer, frequency = 12, start = c(1956,1), end = c(1994,12))

#analysing dataset:

#monthly
beer.ts.qtr <- aggregate(beer.ts, nfrequency=4)
beer.ts.yr <- aggregate(beer.ts, nfrequency=1)
plot.ts(beer.ts[,2], main = "Monthly Beer Production ", xlab = "Year", ylab = "ML")

#quarterly
plot.ts(beer.ts.qtr[,2], main = "Quarterly Beer Production ", xlab = "Year", ylab = "ML")

#annual
plot.ts(beer.ts.yr[,2], main = "Annual Beer Production", xlab = "Year", ylab = "ML")

#linear regression
beer.fit.lm <- tslm(beer.ts[,2] ~ trend)
f <- forecast(beer.fit.lm, h = 120, level = c(80,95))
plot.ts(beer.ts[,2], main = "Monthly Beer Production", xlab = "Year", ylab = "ML", xlim = c(1954,2004))
lines(f$fitted, col = "blue")
lines(f$mean, col = "blue")

#predicting production with linear regression model
nextYearSales <- forecast(beer.fit.lm, h=12)
#summary of model
summary(beer.fit.lm)

#since we need seasonality also in time series,adding seasonality we get summary as:
beer.fit.lm2 <- tslm(beer.ts[,2] ~ trend + season)
summary(beer.fit.lm2)

#forecasting using linear seasonality model
f <- forecast(beer.fit.lm2, h = 120, level = c(80,95))
plot.ts(beer.ts[,2], main = "Monthly Beer Production", xlab = "Year", ylab = "ML", xlim = c(1954,2004))
lines(f$mean, col = "blue")

#estimate
nextYearSales <- forecast(beer.fit.lm2, h=12)


#Holt-Winters Seasonality Model: Additive and multiplicative are used for constant
#and varying seasonality
beer.ts3 <- window(beer.ts, start = 1960, end = 1975)
beer.ts.qtr <- aggregate(beer.ts3, nfrequency=4)
beer.fit.hw1 <- hw(beer.ts.qtr[,2], h = 20, seasonal = "additive")
beer.fit.hw2 <- hw(beer.ts.qtr[,2], h = 20, seasonal = "multiplicative")

plot(beer.fit.hw1, type="o", fcol="white", main = "Quarterly Beer Production", xlab = "Year", ylab = "ML", plot.conf=FALSE)
lines(beer.fit.hw1$fitted, col = "blue", lty=2)
lines(beer.fit.hw2$fitted, col = "red", lty=2)
lines(beer.fit.hw1$mean, col = "blue", type="o")
lines(beer.fit.hw2$mean, col = "red", type="o")
legend("topleft", lty = 1, pch = 1, col = c("black", "blue", "red"),
       c("Data", "Holt Winters' Additive", "Holt Winters' Multiplicative"))


#visualising only additive:
beer.ts3 <- window(beer.ts, start = 1960, end = 1975)
beer.ts.qtr <- aggregate(beer.ts3, nfrequency=4)
beer.fit.hw1 <- hw(beer.ts.qtr[,2], h = 20, seasonal = "additive")


plot(beer.fit.hw1, type="o", fcol="white", main = "Quarterly Beer Production", xlab = "Year", ylab = "ML", plot.conf=FALSE)
lines(beer.fit.hw1$fitted, col = "blue", lty=2)

lines(beer.fit.hw1$mean, col = "blue", type="o")

legend("topleft", lty = 1, pch = 1, col = c("black", "blue"),
       c("Data", "Holt Winters' Additive"))

#estimating
nextYearSales <- forecast(beer.fit.hw1, h=12)
nextYearSales

#summary
summary(beer.fit.hw1)

