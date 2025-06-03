png("wti_cross_plot.png", width = 1000, height = 600)
installed.packages("TTR", "quantmod")  ## install necessary packages
library(quantmod)
library(TTR)

# download historical WTI crude oil data
oil <- getSymbols("CL=F", src = "yahoo", from= "2000-01-01", auto.assign = FALSE)  # Continuous WTI futures prices from Yahoo
# we're telling what, from where, and from when to download oil prices
# FALSE is essential or it would assign a new variable 
## I switched from FRED to Yahoo due to ugly charting – Yahoo works better

# extract closing prices from oil series
close_prices <- na.omit(Cl(oil))  ## Cl extracts closing prices from OHLC series provided by Yahoo

# calculate moving averages
sma50 <- SMA(close_prices, 50)    ## 50-day simple moving average
sma200 <- SMA(close_prices, 200)  ## 200-day simple moving average

# merge all series: oil price and moving averages
oil_clean <- na.omit(merge(close_prices, sma50, sma200))  ## force R to omit NAs
colnames(oil_clean) <- c("Close", "SMA50", "SMA200")
## na.omit removes missing series, colnames used for readability

# prepare for SMA50 crossing SMA200 (golden cross and death cross)
golden_cross <- which(Lag(oil_clean$SMA50, k = 1) < Lag(oil_clean$SMA200, k = 1) & oil_clean$SMA50 > oil_clean$SMA200)  ## golden cross (bullish signal) when SMA50 > SMA200
death_cross  <- which(Lag(oil_clean$SMA50, k = 1) > Lag(oil_clean$SMA200, k = 1) & oil_clean$SMA50 < oil_clean$SMA200)  ## death cross (bearish signal) when SMA200 > SMA50
## +1 not needed because we already handle lagging manually

# convert series to numeric format to make plotting work
dates <- index(oil_clean)
close <- as.numeric(oil_clean$Close)
sma50 <- as.numeric(oil_clean$SMA50)
sma200 <- as.numeric(oil_clean$SMA200)

# move the legend outside the plot (top-right)
# use par(xpd=TRUE) so R allows drawing outside the plot area
par(xpd= TRUE, mar = c(5, 4, 4, 6))

# plot the main chart
plot(dates, close, type = "l", col = "black", lwd = 2,
     main = "Prezzo WTI con SMA50, SMA200, Golden & Death Cross",
     xlab = "Data", ylab = "Prezzo")

# overlay moving average lines (200-day line thicker because more relevant)
lines(dates, sma50, col="green", lwd=1)
lines(dates, sma200, col="orange", lwd=1.5)

# add cross points to the chart
points(dates[golden_cross], close[golden_cross], col = "blue", pch = 16, cex = 1)
points(dates[death_cross],  close[death_cross],  col = "red", pch = 17, cex = 1)

# legend anchor point (top-right corner)
x0 <- as.Date("2023-01-01")
y0 <- 140

# vertical spacing between legend lines
dy <- 5

# legend labels and symbols
labels <- c("Prezzo", "SMA50", "SMA200", "Golden", "Death")
colors <- c("black", "green", "orange", "blue", "red")
types <- c("line", "line", "line", "point", "point")

# loop to draw the legend, row by row
for (i in seq_along(labels)) {
  y <- y0 - (i - 1) * dy
  
  if (types[i] == "line") {
    segments(x0 - 100, y, x0 - 50, y, col = colors[i], lwd = ifelse(i == 3, 1.5, 1))
  } else {
    points(x0 - 75, y, col = colors[i], pch = ifelse(i == 4, 16, 17), cex = 0.8)
  }
  
  text(x0 - 40, y, labels[i], adj = 0, cex = 0.6)
}

dev.off()

# Git commit and push to GitHub
system("git add -A")
system("git commit -m 'Auto update cross plot'")
system("git push origin main")

