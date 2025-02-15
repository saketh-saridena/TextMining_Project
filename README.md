# **SHOULD SOCIAL MEDIA COMPANIES BE HELD RESPONSIBLE FOR MISINFORMATION?**

## **📌 Project Overview**
Misinformation on social media has become a major concern, influencing elections, public health, and global events. This project explores whether social media companies should be held accountable for the spread of misinformation. Using **data science and natural language processing (NLP),** this project collects, processes, and analyzes news articles and social media posts to categorize their stance on misinformation regulation.

## **📂 Datasets**
The project includes multiple datasets processed through different NLP techniques:

1. **Raw Data Collection:**
   - News articles were collected from **NewsAPI** and **Mediastack API**.
   - Web scraping was performed using **Google RSS Feeds**.

2. **Preprocessed Datasets:**
   - **`stemmed_data.csv`** – Contains articles with words stemmed for normalization.
   - **`lemmatized_data.csv`** – Contains articles with words lemmatized for improved text processing.
   - **`countvectorized_data.csv`** – Text transformed into numerical features using **CountVectorizer**.
   - **`tfidf_data.csv`** – Text transformed using **TF-IDF Vectorization**.

3. **Labeled Data:**
   - Articles were labeled using a **BERT model** to classify them into:
     - **Pro-Regulation** (supports misinformation laws)
     - **Anti-Regulation** (opposes regulation, supports free speech)
     - **Neutral** (no clear stance)

## **🔬 Key Features**
✔ **Data Collection:** Extracts news and social media data from multiple sources.  
✔ **Text Processing:** Cleans and prepares data using stemming, lemmatization, and tokenization.  
✔ **Feature Engineering:** Applies NLP transformations (CountVectorizer, TF-IDF).  
✔ **Machine Learning:** Prepares labeled datasets for training models like Decision Trees (DT), Naïve Bayes (NB), Neural Networks (NN), and Support Vector Machines (SVM).  
✔ **Misinformation Trend Analysis:** Examines patterns in misinformation spread and regulatory discussions.  

## **📊 Next Steps**
- Train and evaluate **ML models** to classify misinformation stance.
- Analyze sentiment trends in news and social media discussions.
- Create visualizations to showcase findings.

## **📎 Repository Contents**
- **`data/`** – Contains all datasets used in the project.
- **`SakethSaridena_TextMining_Project`** – Jupyter Notebooks with preprocessing, labeling, and analysis.
- **`README.md`** – Project documentation.
