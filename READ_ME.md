# 📊 Stock Market Sentiment & Price Movement Analyzer

### Overview
This project is a **news-sentiment-driven stock market analysis tool** that extracts financial news, classifies sentiment into **positive** and **negative** keywords, and correlates them with stock **price changes** at different time intervals (1 hour, 4 hours, end-of-day, and weekly trends).

The system is built using **Python (Jupyter/Colab)** and integrates **Yahoo Finance & Finviz** data sources to help identify **market-moving events, company progress, and investor sentiment trends**.

---

## ✨ Features
✔ **Automated Ticker Analysis** – Processes hundreds of tickers (S&P 500 + extended lists) in batches  
✔ **Keyword Classification** – Uses predefined financial categories (earnings, mergers, acquisitions, lawsuits, FDA approvals, etc.)  
✔ **Sentiment Analysis** – Classifies news as positive or negative using **TextBlob & NLTK**  
✔ **Hourly & Daily Price Change Tracking** – Extracts stock price movement over 1hr, 4hr, daily, and 7-day intervals  
✔ **Company Progress Summaries** – Generates **.docx reports** tagging each ticker with categorized keywords  
✔ **Reduced "Other" Keywords** – Uses expanded financial terms & phrase-based matching for higher accuracy  
✔ **Batch Exports** – Outputs structured CSVs & Word reports for easy analysis and visualization  

---

## 🗂 Project Structure

```
📂 Stock-Market-Sentiment-Analyzer
│
├── 📄 README.md                # Project overview (this file)
├── 📄 requirements.txt         # Python library requirements
│
├── 📁 data/
│   ├── Company Ticker Progress 26th July.csv   # Processed ticker sentiment & price data
│
├── 📁 notebooks/
│   ├── Week 12 Codes.ipynb                    # Sentiment extraction & keyword classification logic
│   ├── Week 12 Company Analyzer.ipynb         # Ticker-level sentiment & price correlation
│
├── 📁 reports/
│   ├── Company Progress Summary Week 12.docx  # Final company-level keyword summary
│   ├── Company Progress Summary Week 11.docx
│
└── 📁 scripts/
    ├── auto_price_change_tracker.py           # Tracks price changes at 1hr, 4hr, daily intervals
    └── sentiment_keyword_extractor.py         # Handles sentiment & keyword classification
```

---

## ⚙️ Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/<your-username>/<repo-name>.git
   cd <repo-name>
   ```

2. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```
   **Key Libraries**:  
   - `yfinance` – Stock price & historical data  
   - `pandas` – Data manipulation  
   - `textblob`, `nltk` – Sentiment analysis & keyword tagging  
   - `python-docx` – Word document export  

3. **Run the Notebooks / Scripts**
   - **Jupyter / Colab**: Open `Week 12 Codes.ipynb` or `Week 12 Company Analyzer.ipynb`
   - **Python scripts** (optional):
     ```bash
     python scripts/sentiment_keyword_extractor.py
     python scripts/auto_price_change_tracker.py
     ```

---

## 📈 Sample Output

**Example (ABBV):**  
✅ **Positive Keywords:** earnings, technology  
❌ **Negative Keywords:** environment  

The output is saved in both **CSV** (raw data) and **.docx** (readable summaries) formats.

---

## 🚀 Roadmap
- ✅ Week 11: Initial keyword extraction & classification  
- ✅ Week 12: Reduced “Other” keyword frequency & added phrase-based matching  
- 🔄 **Next (Week 13):**
  - Further refine keyword categories
  - Visualize sentiment-price correlations (Matplotlib / Tableau)
  - Automate GitHub Actions for scheduled analysis updates

---

## 🤝 Contributions
Feel free to fork the repo, submit issues, or suggest new **keyword categories** to enhance classification accuracy.

---

## 📧 Contact
**Muhammad bin Hanifah Syukri**  
Email: mjh7412@psu.edu
