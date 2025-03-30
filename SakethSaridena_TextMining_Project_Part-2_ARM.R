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

# Plot heatmap
ggplot(melted_lift, aes(x = consequents, y = antecedents, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient(name = "Lift", low = "lightblue", high = "darkgreen") +
  geom_text(aes(label = round(value, 2)), size = 3) +
  theme_minimal() +
  labs(title = "Grouped Matrix Plot of Rules (Lift Values)",
       x = "Consequents",
       y = "Antecedents") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.text.y = element_text(angle = 0))

# Plot network graph
top_rules <- rules_df %>%
  arrange(desc(lift)) %>%
  head(50)

# Create edge list
edges <- top_rules %>%
  select(antecedents, consequents, lift) %>%
  mutate(from = antecedents, to = consequents)

# Build graph and plot
graph <- tbl_graph(edges = edges, directed = TRUE)

ggraph(graph, layout = "fr") +
  geom_edge_link(aes(width = lift), arrow = arrow(length = unit(4, 'mm')),
                 end_cap = circle(4, 'mm'), alpha = 0.6) +
  geom_node_point(color = "lightblue", size = 5) +
  geom_node_text(aes(label = name), repel = TRUE, size = 4) +
  labs(title = "Network Graph of Association Rules (Top 50 by Lift)") +
  theme_void()
