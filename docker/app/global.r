#set data to iris data set
data <- iris

# Compute more values from x variable in a helper dataframe
data_helper <- NULL
data_helper$clust <- data[,-5]
data_helper$response <- data$Species
