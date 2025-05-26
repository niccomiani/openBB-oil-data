# 📈 WTI Crude Oil Auto-Updating Dashboard

This repository contains an automated pipeline to download, visualize and publish daily updates of **WTI Crude Oil** prices using R and GitHub Actions.

## 🔧 What It Does

- Fetches daily WTI data from Yahoo Finance (`CL=F`)
- Saves the data to a CSV file
- Creates a time series chart using `ggplot2`
- Generates an HTML dashboard (`index.html`) embedding the chart
- Pushes the updates automatically to GitHub
- Deploys the dashboard to Netlify
- Embeds the live dashboard in [OpenBB Workspace](https://pro.openbb.co)

## 🔁 Automation Flow

| Step | Tool | Description |
|------|------|-------------|
| 📥 Fetch data | `R + quantmod` | Gets latest WTI prices |
| 📊 Visualize | `R + ggplot2` | Creates updated line chart |
| 💾 Save | `R` | Outputs CSV, PNG and HTML |
| ⚙️ GitHub Actions | Scheduler | Runs every morning |
| 🚀 Netlify | Deployment | Serves live updated site |
| 🌐 OpenBB | Widget | Displays live chart via iframe |

## 🌍 Live Dashboard

🔗 **[Visit the live dashboard on Netlify](https://playful-gingersnap-c3cfe4.netlify.app/)**

You can also explore it directly in [OpenBB Workspace](https://pro.openbb.co) under the "Azure Crescent" dashboard.

## 👨‍🎓 Author

Niccolò Miani  
_MSc student in Finance, Università Cattolica del Sacro Cuore (23 y/o)_

GitHub: [@niccomiani](https://github.com/niccomiani)  
LinkedIn: [Profile](https://www.linkedin.com/in/niccol%C3%B2-miani-5a8613220/)

---

📌 *This project is part of my personal learning journey combining finance and data automation with R and OpenBB.*
