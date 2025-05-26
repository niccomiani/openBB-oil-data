# Installa i pacchetti (solo la prima volta)
if (!require("quantmod")) install.packages("quantmod")
if (!require("ggplot2")) install.packages("ggplot2")

# Carica i pacchetti
library(quantmod)
library(ggplot2)

# Estrai i dati del WTI da Yahoo Finance
# Estrai i dati del WTI da Yahoo Finance
symbol <- "CL=F"
getSymbols(symbol, src = "yahoo", from = "2024-01-01", auto.assign = TRUE)
wti <- get(symbol)
wti_df <- data.frame(Date = index(wti), Close = as.numeric(Cl(wti)))


# Percorso del Desktop
desktop_path <- file.path(Sys.getenv("HOME"), "Desktop")

# Salva i dati in formato CSV sul Desktop
write.csv(wti_df, file.path(desktop_path, "wti_prices.csv"), row.names = FALSE)

# Crea e salva il grafico PNG sul Desktop
png(file.path(desktop_path, "wti_chart.png"), width = 800, height = 600)
ggplot(wti_df, aes(x = Date, y = Close)) +
  geom_line(linewidth = 1, color = "steelblue") +
  theme_minimal() +
  labs(title = "WTI Crude Oil Prices", x = "Date", y = "Price (USD)")
dev.off()

# Crea HTML che include l'immagine
html_code <- paste0(
  '<html>
  <head><title>WTI Prices</title></head>
  <body>
    <h1>Latest WTI Prices</h1>
    <img src="wti_chart.png" alt="WTI chart" width="800">
  </body>
</html>'
)

# Salva l'HTML sul Desktop
writeLines(html_code, file.path(desktop_path, "index.html"))

