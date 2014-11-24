# CodeBook

## Overview
This codebook describes the variables, data and transformatios to create a tidy data set from data collected from the accelerometers of the Samsung Galaxy S smartphone downloaded from the course website. The data collected is a series of measurements from 30 subjects performing various activities, including laying, sitting, standing, walking, walking upstairs, and walking downstairs.

## Data
### Inputs
This script utilizes the following input data files:
- activity_labels.txt (mapping of activity-number to activity-name)
- features.txt (mapping of measurement-number to measurement-name)
- ./test/subject_test.txt (subject-number corresponding to each recorded measurement in X_test.txt)
- ./test/X_test.txt (test data - recorded measurements with each feature in a separate column)
- ./test/y_test.txt (activity-number corresponding to each recorded measurement in X_test.txt)
- ./train/subject_train.txt (subject-number corresponding to each recorded measurement in X_train.txt)
- ./train/X_train.txt (training data - recorded measurements with each feature in a separate column)
- ./train/y_train.txt (activity-number corresponding to each recorded measurement in X_train.txt)

### Outputs:
This script produces the following output files:
- tidy_data_set.txt

## Variables
- subject : int (1:30 representing subject ID)
- activity : factor w/ 6 levels ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
- tBodyAccMeanX : numeric
- tBodyAccMeanY
- tBodyAccMeanZ
- tBodyAccStdX
- tBodyAccStdY
- tBodyAccStdZ
- tGravityAccMeanX
- tGravityAccMeanY
- tGravityAccMeanZ
- tGravityAccStdX
- tGravityAccStdY
- tGravityAccStdZ
- tBodyAccJerkMeanX
- tBodyAccJerkMeanY
- tBodyAccJerkMeanZ
- tBodyAccJerkStdX
- tBodyAccJerkStdY
- tBodyAccJerkStdZ
- tBodyGyroMeanX
- tBodyGyroMeanY
- tBodyGyroMeanZ
- tBodyGyroStdX
- tBodyGyroStdY
- tBodyGyroStdZ
- tBodyGyroJerkMeanX
- tBodyGyroJerkMeanY
- tBodyGyroJerkMeanZ
- tBodyGyroJerkStdX
- tBodyGyroJerkStdY
- tBodyGyroJerkStdZ
- tBodyAccMagMean
- tBodyAccMagStd
- tGravityAccMagMean
- tGravityAccMagStd
- tBodyAccJerkMagMean
- tBodyAccJerkMagStd
- tBodyGyroMagMean
- tBodyGyroMagStd
- tBodyGyroJerkMagMean
- tBodyGyroJerkMagStd
- fBodyAccMeanX
- fBodyAccMeanY
- fBodyAccMeanZ
- fBodyAccStdX
- fBodyAccStdY
- fBodyAccStdZ
- fBodyAccJerkMeanX
- fBodyAccJerkMeanY
- fBodyAccJerkMeanZ
- fBodyAccJerkStdX
- fBodyAccJerkStdY
- fBodyAccJerkStdZ
- fBodyGyroMeanX
- fBodyGyroMeanY
- fBodyGyroMeanZ
- fBodyGyroStdX
- fBodyGyroStdY
- fBodyGyroStdZ
- fBodyAccMagMean
- fBodyAccMagStd
- fBodyBodyAccJerkMagMean
- fBodyBodyAccJerkMagStd
- fBodyBodyGyroMagMean
- fBodyBodyGyroMagStd
- fBodyBodyGyroJerkMagMean
- fBodyBodyGyroJerkMagStd

## Transformations

### Step 1: Merges the training and the test sets to create one data set
- Combine subject, activity and measurement training data into a single dataframe
- Combine subject, activity and measurement testing data into a single dataframe
- Combine training and testing data into a single data set

### Step 2: Extract only the measurements on the mean and standard deviation for each measurement
- get the feature numbers for all feature measurements with 'mean()' or 'std()' in the variable name using grepl()
    + my interpretation of the assignment instructions was to exclude measurements with 'meanFreq()' in  the feature variable name because there was no corresponding Standard Deviation measurement (e.g. 'stdFreq()')
- select subject, activity, and all the selected features combined data set

### Step 3: Use descriptive activity names to name the activities in the data set
- for each activity_label, replace the activity-number with the activity-name in the data set from Step 2
- convert activity column in resulting data set to be a factor variable

### Step 4: Appropriately label the data set with descriptive variable names
- modify variable names in features dataframe (col 2) to be more user friendly
    + replace 'mean()' with 'Mean' using gsub
    + replace 'std()' with "Std' using gsub
    + remove '-' from variable names
- set column names of data set to "subject", "activity" and the (user friendly) selected feature variable names

### Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
- group data set by subject and activity
- apply mean function to all feature measurements
- write data set to 'tidy_data_set.txt' file


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are (where Mean represents Mean value and Std represents Standard deviation): 


Transformations
