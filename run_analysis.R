## Script to prepare a tidy data set from data collected from the accelerometers of the Samsung
## Galaxy S smartphone downloaded from the course website

## This script assumes the following input data files are in the current working directory
## (and 'test' and 'train' subdirectories of the current working directory):
##  activity_labels.txt
##  features.txt
##  ./test/subject_test.txt
##  ./test/X_test.txt
##  ./test/y_test.txt
##  ./train/subject_train.txt
##  ./train/X_train.txt
##  ./train/y_train.txt

## 1. Merge the training and test sets to create one data set

## read features.txt into features dataframe to get feature variable names
features <- read.table("./features.txt", sep="", header=FALSE, col.names=c("featureID", "featureName"), stringsAsFactors=FALSE)

## get the features with 'mean()' or 'std()' in the variable name and store them as features_selected
features_selected <- features[(grepl("mean\\(\\)|std\\(\\)", features$featureName)), ]

## remove special characters from feature variable names to be more user friendly
## replace 'mean()' with 'Mean' using gsub
## replace 'std()' with "Std' using gsub
## remove all other punctuation from variable names using gsub
features$featureName <- gsub("mean\\(\\)", "Mean", features$featureName)
features$featureName <- gsub("std\\(\\)", "Std", features$featureName)
features$featureName <- gsub("[[:punct:]]", "", features$featureName)
features_selected$featureName <- gsub("mean\\(\\)", "Mean", features_selected$featureName)
features_selected$featureName <- gsub("std\\(\\)", "Std", features_selected$featureName)
features_selected$featureName <- gsub("[[:punct:]]", "", features_selected$featureName)

## Combine subject, activity and measurement training data into a single dataframe
subject_train <- read.table("./train/subject_train.txt", header=FALSE, sep="", col.names="subject")
activity_train <- read.table("./train/y_train.txt", header=FALSE, sep="", col.names="activity")
measurements_train <- read.table("./train/X_train.txt", header=FALSE, sep="", col.names=features$featureName)
data_train <- cbind(subject_train, activity_train, measurements_train)

## Combine subject, activity and measurement testing data into a single dataframe
subject_test <- read.table("./test/subject_test.txt", header=FALSE, sep="", col.names="subject")
activity_test <- read.table("./test/y_test.txt", header=FALSE, sep="", col.names="activity")
measurements_test <- read.table("./test/X_test.txt", header=FALSE, sep="", col.names=features$featureName)
data_test <- cbind(subject_test, activity_test, measurements_test)

## Combine training and testing data into a single data set
data_all <- rbind(data_train, data_test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement

## select subject, activity, and all the selected features from data_all dataframe and
## store in data dataframe
data <- data_all[, c("subject", "activity", features_selected$featureName)]

## 3. Use descriptive activity names to name the activities in the data set

## read activity_labels.txt into activity_labels dataframe
activity_labels <- read.table("./activity_labels.txt", header=FALSE, sep="", col.names=c("activityID", "activityName"), 
                              stringsAsFactors=FALSE)

## for each activity_label, replace the activityID with the activityName in the data
for (i in seq_along(activity_labels$activityID)) {
    actID <- activity_labels$activityID[i]
    actName <- activity_labels$activityName[i]
    data[(data$activity == actID), 'activity'] <- actName
}

## convert activity column in data to be a factor variable (character variables should be factors when possible)
data$activity <- factor(data$activity)

## 4. Appropriately label the data set with descriptive variable names
## this step was done earlier (Step 1) in order to refer to columns by name instead of position

## 5. Create a second, independent tidy data set with the average of each variable for each activity
##    and each subject

## load dplyr package using library()
library(dplyr)

## group data by subject and activity using dplyr group_by() function
## apply mean function to all feature measurements using dplyr summarise_each() function
## store result in data_summary dataframe
## using dplyr %>% operator to chain together multiple operations 
data_summary <-
    data %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

## write data_summary dataframe to 'tidy_data_set.txt' file using write.table() with col names but
## without row names
write.table(data_summary, file="./tidy_data_set.txt", row.names=FALSE, col.names=TRUE)
