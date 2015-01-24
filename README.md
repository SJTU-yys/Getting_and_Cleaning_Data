# Getting_and_Cleaning_Data

## Getting data
Link for the experiment data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The steps for getting the tidy and clean data
### 1. Merge the training and test data
    The run_analysis R script should be in the same diretory as the dataset, the whole structure of
    the directory may be as follows:
    |-- root directory
       |-- run_analysis.R
       |-- UCI HAR dataset
          |-- test
          |-- train
          |-- activity_labels.txt
          |-- features.txt
          |-- features_info.txt
          |-- README.txt
    After reading the necessary data in, use rbind to get the whole dataset of x, y and subject. and then use cbind to
    combine the x, subject and y data. 
### 2. Extract only the measurements on the mean and standard deviation for each measurement
    The next step is to extract the measurements on the mean and standard deviation, use grep to find the columns which 
    contains "means()" or "std()" and extract the subset
### 3. Uses descriptive activity names to name the activities in the data set
    The next step is to use discriptive activity names, the origin values of activities are numbers adn we need to replace
    them with discriptive names, the correspondence between the numbers and names is as follows:
    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING
### 4. Label the data set with descriptive variable names
    The origin variable names are not so readable, use sub and gsub to remove the brackets and replace "-" because "-" would 
    cause choke on R functions
### 5 Create a new tidy data with the average of each variable for each activity and each subject
    The new tidy data contains the average value of each variable for each group, use group_by and summarize to get the grouped
    averages.
