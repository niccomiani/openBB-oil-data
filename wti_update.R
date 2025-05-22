install.packages("quantmod")
library(quantmod)

symbol <- "CL=F"
getSymbols(symbol, src = "yahoo", from = "2024-01-01", auto.assign = TRUE)

wti <- Cl(get(symbol))
wti_df <- data.frame(Date = index(wti), Close = coredata(wti))

write.csv(wti_df, "wti_prices.csv", row.names = FALSE)

html_code <- '<html>
  <head><title>WTI Prices</title></head>
  <body>
    <h1>Latest WTI Prices</h1>
    <p>This is a placeholder report for WTI prices.</p>
  </body>
</html>'

writeLines(html_code, "wti_prices.html")
