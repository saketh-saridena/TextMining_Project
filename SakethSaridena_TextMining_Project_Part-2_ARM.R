# Install Required Libraries 
install.packages("arules")
install.packages("arulesViz")
install.packages("tm")
install.packages("readr")

#  Load Libraries
library(readr)
library(tm)
library(stringr)
library(arules)
library(arulesViz)

#Load Lemmatized Data
df <- read_csv("lemmatized_data.csv")
texts <- na.omit(df$lemmatized_text)

#  Preprocess Text (equivalent to Python's preprocess_for_arm)
stop_words <- stopwords("en")
preprocess_for_arm <- function(text) {
  text <- gsub("[^a-zA-Z\\s]", "", text)           # Remove punctuation/numbers
  tokens <- unlist(strsplit(tolower(text), "\\s+"))# Tokenize
  tokens <- tokens[nchar(tokens) > 2 & !(tokens %in% stop_words)] # Remove short and stop words
  return(tokens)
}

# Apply preprocessing to all texts
transactions_list <- lapply(texts, preprocess_for_arm)

# Convert to transactions format
trans <- as(transactions_list, "transactions")

#  Mine Frequent Itemsets
frequent_itemsets <- apriori(trans, parameter = list(supp = 0.01, target = "frequent itemsets"))
inspect(head(frequent_itemsets, 10))

# Generate Association Rules
rules <- apriori(trans, parameter = list(supp = 0.01, conf = 0.5, target = "rules"))
inspect(head(rules, 10))

# Top 15 Rules by Support
top_support <- head(sort(rules, by = "support", decreasing = TRUE), 15)
cat("\nTop 15 Rules by Support:\n")
inspect(top_support)

# Top 15 Rules by Confidence
top_conf <- head(sort(rules, by = "confidence", decreasing = TRUE), 15)
cat("\nTop 15 Rules by Confidence:\n")
inspect(top_conf)

# Top 15 Rules by Lift
top_lift <- head(sort(rules, by = "lift", decreasing = TRUE), 15)
cat("\nTop 15 Rules by Lift:\n")
inspect(top_lift)

# Optional Visualization
plot(head(sort(rules, by = "lift", decreasing = TRUE), 10), method = "graph", engine = "htmlwidget")