# 📊 Yelp Business Reviews Analysis (SQL + Python + Snowflake + Amazon S3)

This project analyzes Yelp's business and review data using a full data pipeline. It includes data preprocessing in Python, cloud storage via AWS S3, loading into Snowflake and performing SQL analytics and sentiment analysis to extract meaningful business insights.

---

## 📁 Project Workflow

1. **Data Preprocessing (Python):**
   - Parsed and split the large Yelp JSON files into smaller chunks.
   - Cleaned and structured the data for better ingestion.

2. **Data Upload (AWS S3):**
   - Uploaded processed files to Amazon S3 for scalable cloud storage.

3. **Data Warehousing (Snowflake):**
   - Ingested data from S3 into Snowflake.
   - Created Snowflake tables.

4. **Analytics (SQL):**
   - Wrote complex SQL queries to analyze the data and extract business insights.

5. **Sentiment Analysis (Python):**
   - Applied basic sentiment analysis on review texts.
   - Classified reviews as positive, negative, or neutral.
   - Joined sentiment results back with Snowflake data for deeper insights.

---

## 🧠 Skills Demonstrated

- Python (JSON parsing, sentiment analysis)
- AWS S3 (data storage)
- Snowflake (SQL, data modeling, staging)
- SQL analytics
- End-to-end project workflow

---

## 📦 Files Included

`split_yelp_json.py` - Preprocesses the large Yelp review dataset by splitting it into smaller JSON chunks to speed up ingestion into AWS S3 and Snowflake.

