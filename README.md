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
📁 Stock-Market-Sentiment-Analyzer/
│
├── 📄 README.md                       # Project overview, setup, and usage guide
├── 📄 company_tickers.txt            # List of tickers to analyze
│
├── 📁 notebooks/                     # Interactive notebooks for analysis and prototyping
│   ├── Sentiment Analyzer.ipynb      # News sentiment & price tracking (main notebook)
│   └── Tickers Analyzer.ipynb        # Ticker-wise article extraction and metadata parsing
│
├── 📁 reports/                       # Final outputs and summaries
│   ├── Acculumated Meeting Log.docx  # Compiled meeting logs
│   ├── Acculumated Weekly Log.docx   # Compiled weekly activity logs
│   └── (future) Company_Report_.docx # Output summaries by week (auto-generated)

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

1) **Upload the "Tickers Analyzer.ipynb" to Google Colab**

The screen should look like this:
<img width="1468" height="729" alt="Screenshot 2025-08-04 at 9 26 54 AM" src="https://github.com/user-attachments/assets/1b00ad85-3015-414b-9a10-60b4e5d84813" />


After you run the environment setup, the screen should look like this:
<img width="1465" height="739" alt="Screenshot 2025-08-04 at 9 27 53 AM" src="https://github.com/user-attachments/assets/4fb04490-2f17-49b0-b518-da05ec7a3b4c" />

2)**Upload the "company_tickers.txt" in the files menu on Google Colab**

After you downloaded the company_tickers.txt file on your computer, you should upload the file in the files menu as shown below:
<img width="454" height="415" alt="Screenshot 2025-08-04 at 9 34 24 AM" src="https://github.com/user-attachments/assets/09faafe2-36ec-43aa-b7ae-9855b4a493f3" />


Click the "upload to the session storage" button here:
<img width="571" height="436" alt="Screenshot 2025-08-04 at 9 36 15 AM" src="https://github.com/user-attachments/assets/6c66ae71-8b93-49d8-8d58-1eb28fbddc61" />


After you uploaded the txt file, you can run the sentiment analyzer:
<img width="1158" height="621" alt="Screenshot 2025-08-04 at 9 38 48 AM" src="https://github.com/user-attachments/assets/46b56fe5-3c92-4469-871a-f239be152573" />


While the file is running, you have to scroll down and see the "choose file" option on the output. You have to click the button and upload the same "company_tickers.txt" file here:
<img width="1171" height="429" alt="Screenshot 2025-08-04 at 9 39 49 AM" src="https://github.com/user-attachments/assets/896fabe7-d934-4947-b8fc-e7ec24775890" />


The final output for the code will show the statistics of the first 5 tickers like this:
<img width="1179" height="801" alt="Screenshot 2025-08-04 at 9 42 35 AM" src="https://github.com/user-attachments/assets/5a7f8cc4-89a3-4d65-8b94-07e7652f21ea" />


After you successfully run all the files, you have to run the final code which is the csv downloader here:
<img width="1118" height="501" alt="Screenshot 2025-08-04 at 9 44 12 AM" src="https://github.com/user-attachments/assets/529647f7-e7a8-450f-aa91-84b6eb5ccd53" />

2) **Download the "Sentiment Analyzer.ipynb" file and upload it in the new google colab notebook. The file should look like this when you uploaded it:**
<img width="1390" height="805" alt="Screenshot 2025-08-04 at 9 47 49 AM" src="https://github.com/user-attachments/assets/22165597-68be-48cb-a7dc-a0705a745870" />


1) **Upload the CSV file that you downloaded earlier using the "upload to session storage" button here:**
<img width="1077" height="709" alt="Screenshot 2025-08-04 at 9 53 46 AM" src="https://github.com/user-attachments/assets/27e098cc-647b-4832-8f42-cd95e546cc90" />


It should look like this when you uploaded it:
<img width="372" height="349" alt="Screenshot 2025-08-04 at 10 08 11 AM" src="https://github.com/user-attachments/assets/a6e62eb0-d29b-4f46-907b-6fe8dd730ebe" />



After you uploaded the CSV file, you can run both code blocks of the "Required Packages" part and it should look like this:
<img width="1456" height="801" alt="Screenshot 2025-08-04 at 9 58 19 AM" src="https://github.com/user-attachments/assets/0989033c-4024-4ce7-8e2f-28f6ec96fdd5" />


Run the "Download NLTK Resources" code and the head of the csv file should appear as this photo:
<img width="1469" height="798" alt="Screenshot 2025-08-04 at 10 00 47 AM" src="https://github.com/user-attachments/assets/55b40bb5-f4e3-4369-8eb8-0cdd3839bf6c" />


Run the "Keyword Based Company Snetiment..." code block here:
<img width="1108" height="800" alt="Screenshot 2025-08-04 at 10 03 32 AM" src="https://github.com/user-attachments/assets/cf0f4074-ccbb-4c15-84ee-fd9661a65624" />


Run the final code block to download the completed sentiment analysis of all the company tickers in the txt file:
<img width="767" height="264" alt="Screenshot 2025-08-04 at 10 10 10 AM" src="https://github.com/user-attachments/assets/1c1a014b-9f61-47ce-b619-57bcc324213f" />


The document file should look like this:
<img width="767" height="264" alt="Screenshot 2025-08-04 at 10 10 10 AM" src="https://github.com/user-attachments/assets/67b6f083-3323-485d-9143-0ac1d31151b6" />


3) Upload the "Stock Market Price Forecaster.ipynb" file and the file should like this when uploaded:
<img width="1448" height="774" alt="Screenshot 2025-08-07 at 10 11 48 PM" src="https://github.com/user-attachments/assets/70bf9fb6-32a1-46ae-a1a1-6ef52ee8b841" />


Run "CSV File Uploader" code block and upload the same CSV file that we downloaded using the Ticker analysis ipynb just now and the output of the code should look like this:
<img width="939" height="168" alt="Screenshot 2025-08-07 at 10 15 04 PM" src="https://github.com/user-attachments/assets/d540b213-0967-4620-a5ab-5674f3c803ff" />


Run the next code block and the output should show the amount of the ticker listed in the CSV file:
<img width="771" height="406" alt="Screenshot 2025-08-07 at 10 15 41 PM" src="https://github.com/user-attachments/assets/6d778e74-1a31-4316-8b34-32991610b968" />


Run the next 2 code blocks. The output of the second block should look like this:
<img width="1403" height="702" alt="Screenshot 2025-08-07 at 10 18 39 PM" src="https://github.com/user-attachments/assets/7e3a05d7-a96c-45f8-9dcd-6bb37732997e" />


Run the final code block to download the second CSV file which contains the forecasted stock market prices for all the company tickers for the next 3 days. The file should look like this:


<img width="1403" height="702" alt="Screenshot 2025-08-07 at 10 18 39 PM" src="https://github.com/user-attachments/assets/51df1806-e735-417a-b766-4cb89dc328e5" />


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
