##Location that the zip file was unpacked.
##
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##
tidy <- function () {
setwd("~/projects/coursera/tidy/UCI HAR Dataset")

## Load the test files
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")


## Load the train files
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

## Load the features
features <- read.table("features.txt") 

## Find the column names that have mean or std in them to extract
extract_cols <- grep("mean|std" , features$V2)
feature_names <- features$V2[extract_cols]

## Extract mean/std columns
X_test_extract <- X_test[, extract_cols]
X_train_extract <- X_train[, extract_cols]

## Change the names of the columns to values from features
colnames(X_test_extract) <- feature_names
colnames(X_train_extract) <- feature_names

## Change column names for subject and activities
colnames(y_train) <- c("activity")
colnames(y_test) <- c("activity")

colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")

##Prepare the dataframes for merging
df_train <- data.frame(subject_train$subject, y_train$activity, X_train_extract)
colnames(df_train) <- c(    "subject_id", "activity", as.character(feature_names))
df_test <- data.frame(subject_test$subject, y_test$activity, X_test_extract)
colnames(df_test) <- c(    "subject_id", "activity", as.character(feature_names))

##Merged dataframe of test and training data
df_merged <-  rbind(df_train, df_test)


##Convert activity id to factor
activity_table <- read.table("activity_labels.txt")
activities <- activity_table$V2
df_merged[,"activity"] <- data.frame(apply(df_merged["activity"],2,as.factor))
levels(df_merged$activity) <- activities

## Finally use dplyr to prepare a summary table group by the subject and activity
## showing means for each variable
library(dplyr)

merged2 <- tbl_df(df_merged)
g_merge <- group_by(merged2, subject_id, activity)
tidy_sum <- summarise_each(g_merge, funs(mean))

tidy_sum

}

tidy()
