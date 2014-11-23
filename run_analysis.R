
setwd("~/Documents/5 - Miscellaneous/3 - Coursera/Getting and Cleaning Data/data/UCI HAR Dataset")

## 1. Merge the training and test sets to create one data set

## Combine subject, activity and measurement training data into a single dataframe
subject_train <- read.table("./train/subject_train.txt", header=FALSE, sep="")
activity_train <- read.table("./train/y_train.txt", header=FALSE, sep="")
measurements_train <- read.table("./train/X_train.txt", header=FALSE, sep="")
data_train <- cbind(subject_train, activity_train, measurements_train)

## Combine subject, activity and measurement testing data into a single dataframe
subject_test <- read.table("./test/subject_test.txt", header=FALSE, sep="")
activity_test <- read.table("./test/y_test.txt", header=FALSE, sep="")
measurements_test <- read.table("./test/X_test.txt", header=FALSE, sep="")
data_test <- cbind(subject_test, activity_test, measurements_test)

## Combine training and testing data into a single data set
data_combined <- rbind(data_train, data_test)

## 2. Extract only the measurements on the mean and standard deviation for each measurement

## read features.txt into features dataframe
features <- read.table("./features.txt", sep="")
## get the feature numbers for all feature measurements with mean() or std() in the variable name
## and store them in the features_selected vector
features_selected <- features[(grepl("mean\\(\\)|std\\(\\)", features[,2])), 1]
## select subject(col 1), activity (col 2), and all the selected features (col # offset by 2 due to
## subject and activity columns) from data_combined dataframe and store in data_filtered dataframe
data_filtered <- data_combined[,c(1, 2, (features_selected + 2))]

## 3. Use descriptive activity names to name the activities in the data set

## read activity_labels.txt into activity_labels dataframe
activity_labels <- read.table("./activity_labels.txt", sep="")

## for each activity_label, replace the activity_number with the activity_name in the data_filtered
## dataframe (col 2) using subsetting
for (i in 1:nrow(activity_labels)) {
    act_num <- activity_labels[i,1]
    act_name <- as.character(activity_labels[i,2])
    data_filtered[(data_filtered[, 2] == act_num), 2] <- act_name
}

## convert activity column in data_filtered dataframe (col 2) to be a factor variable
data_filtered[, 2] <- factor(data_filtered[, 2])

## 4. Appropriately label the data set with descriptive variable names

## modify variable names in features dataframe (col 2) to be more user friendly
## replace 'mean()' with 'Mean' using gsub
## replace 'std()' with "Std' using gsub
## remove '-' from variable names
features[, 2] <- gsub("mean\\(\\)", "Mean", features[, 2])
features[, 2] <- gsub("std\\(\\)", "Std", features[, 2])
features[, 2] <- gsub("-", "", features[, 2])

## set column names of data_filtered dataframe to "subject", "activity" and the (user friendly)
## selected feature variable names from features dataframe
colnames(data_filtered) <- c("subject", "activity", features[features_selected, 2])

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

## load dplyr package using library()
library(dplyr)

## group data_filtered dataframe by subject and activity using dplyr group_by() function
## apply mean function to all feature measurements using dplyr summarise_each() function
## store result in data_sum dataframe
## using dplyr %>% operator to chain together multiple operations 
data_sum <-
    data_filtered %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

## write data_sum dataframe to 'tidy_data_set.txt' file using write.table() without row names
write.table(data_sum, file="./tidy_data_set.txt", row.names=FALSE)
