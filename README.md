coursera-project-03
===================

Course project for Coursera Getting and Cleaning Data class

## Inputs:
This script assumes the following input data files are in the current working directory (and 'test' and 'train' subdirectories of the current working directory):
- activity_labels.txt
- features.txt
- ./test/subject_test.txt
- ./test/X_test.txt
- ./test/y_test.txt
- ./train/subject_train.txt
- ./train/X_train.txt
- ./train/y_train.txt

## Outputs:

This script writes the resulting tidy data set to the current working directory in the following files:
- tidy_data_set.txt

## Process Steps to produce the resulting tidy data set:

### Step 1: Merges the training and the test sets to create one data set
- Combine subject, activity and measurement training data into a single dataframe
    + read subject_train.txt into subject_train dataframe using read.table()
    + read y_train.txt into activity_train dataframe using read.table()
    + read X_train.txt into measurements_train dataframe using read.table()
    + combine subject_train, activity_train, and measurements_train into data_train dataframe using cbind()

- Combine subject, activity and measurement testing data into a single dataframe
    + read subject_test.txt into subject_test dataframe using read.table()
    + read y_test.txt into activity_test dataframe using read.table()
    + read X_test.txt into measurements_test dataframe using read.table()
    + combine subject_test, activity_test, and measurements_test into data_test dataframe using cbind()

- Combine training and testing data into a single data set
    + combine data_train and data_test dataframes into data_combined dataframe using rbind()

### Step 2: Extract only the measurements on the mean and standard deviation for each measurement
- read features.txt into features dataframe using read.table()
- get the feature numbers for all feature measurements with 'mean()' or 'std()' in the variable name using grepl() and store them in features_selected vector (my interpretation of the assignment instructions was to exclude measurements with 'meanFreq()' in  the feature variable name because there was no corresponding Standard Deviation measurement (e.g. 'stdFreq()'))
- select subject(col 1), activity (col 2), and all the selected features (col # offset by 2 due to subject and activity columns) from data_combined dataframe using subsetting and store in data_filtered dataframe

### Step 3: Use descriptive activity names to name the activities in the data set
- read activity_labels.txt into activity_labels dataframe
- for each activity_label, replace the activity_number with the activity_name in the data_filtered dataframe (col 2) using subsetting
- convert activity column in data_filtered dataframe (col 2) to be a factor variable

### Step 4: Appropriately label the data set with descriptive variable names
- modify variable names in features dataframe (col 2) to be more user friendly
    + replace 'mean()' with 'Mean' using gsub
    + replace 'std()' with "Std' using gsub
    + remove '-' from variable names
- set column names of data_filtered dataframe to "subject", "activity" and the (user friendly) selected feature variable names from features dataframe

### Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
- group data_filtered dataframe by subject and activity using dplyr group_by() function
- apply mean function to all feature measurements using dplyr summarise_each() function
- store result in data_sum dataframe
- write data_sum dataframe to 'tidy_data_set.txt' file using write.table() without row names (using row.names=FALSE)
- this data set can be read using read.table() with default arguments
