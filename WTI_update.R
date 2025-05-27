# Install packages (only first time)
if (!require("quantmod")) install.packages("quantmod")
if (!require("ggplot2")) install.packages("ggplot2")

# Load packages
library(quantmod)
library(ggplot2)

# Download WTI data from Yahoo Finance
symbol <- "CL=F"
getSymbols(symbol, src = "yahoo", from = "2024-01-01", auto.assign = TRUE)
wti <- get(symbol)
wti_df <- data.frame(Date = index(wti), Close = as.numeric(Cl(wti)))

# Set path to current directory (safe in GitHub Actions)
output_path <- "."

# Save as CSV
write.csv(wti_df, file.path(output_path, "wti_prices.csv"), row.names = FALSE)

# Create PNG chart
png(file.path(output_path, "wti_chart.png"), width = 800, height = 600)
ggplot(wti_df, aes(x = Date, y = Close)) +
  geom_line(linewidth = 1, color = "steelblue") +
  theme_minimal() +
  labs(title = "WTI Crude Oil Prices", x = "Date", y = "Price (USD)")
dev.off()

# Create HTML with chart
html_code <- paste0(
  '<html>
  <head><title>WTI Prices</title></head>
  <body>
    <h1>Latest WTI Prices</h1>
    <img src="wti_chart.png" alt="WTI chart" width="800">
  </body>
</html>'
)

writeLines(html_code, file.path(output_path, "index.html"))


