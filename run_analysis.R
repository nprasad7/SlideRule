setwd('C:/Users/nandheesh.prasad/Documents/Foundations of Data Science')
library(dplyr)

#Load in test data documents
subject_test <- read.csv('UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = '')
x_test <- read.csv('UCI HAR Dataset/test/X_test.txt', header = FALSE, sep = '')
y_test <- read.csv('UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = '')

#Combine all test data
test <- data.frame(subject_test, y_test, x_test)

#remove other data sets
remove(subject_test, x_test, y_test)

#Load in train data documents
subject_train <- read.csv('UCI HAR Dataset/train/subject_train.txt', header = FALSE, sep = '')
x_train <- read.csv('UCI HAR Dataset/train/X_train.txt', header = FALSE, sep = '')
y_train <- read.csv('UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = '')

#Combine all train data
train <- data.frame(subject_train, y_train, x_train)

#remove other train data sets
remove(subject_train, x_train, y_train)

#combine train and test data sets
full_set <- rbind(train,test)

#read features.txt in to be column headers
features <- read.csv('UCI HAR Dataset/features.txt', header = FALSE, sep = '')

#create column names vector
col.names = as.vector(features[,2])

#apply column names
colnames(full_set) <- make.names(c("subject_id", "activity_labels", col.names), unique = TRUE)

#pull out mean and std
mean_and_std <- select(full_set, contains("subject"), contains("activity"), contains("mean"), contains("std"), -contains("freq"), -contains("angle"))

#load activity_labels document
activity_labels <- read.csv('UCI HAR Dataset/activity_labels.txt', header = FALSE, sep = '')

#Match activity labels in mean_and_std data set with actual labels
mean_and_std$activity_labels <-as.character(activity_labels[match(mean_and_std$activity_labels, activity_labels$V1), 'V2'])

#clean column names
colnames(mean_and_std) <- gsub("BodyBody", "Body", colnames(mean_and_std))
colnames(mean_and_std) <- gsub("-", "_", colnames(mean_and_std))
colnames(mean_and_std) <- gsub("\\.{2,}", ".", colnames(mean_and_std))

#summarize data by subject and activity
#and take mean of each column

mean_std_summary <- mean_and_std %>%
  group_by(subject_id, activity_labels) %>%
  summarise_each(funs(mean))

# write summary to a table

write.table(mean_std_summary, file = "mean_std_summary.txt", row.names = TRUE)

