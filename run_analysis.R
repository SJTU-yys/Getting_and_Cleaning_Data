UCIdata <- function(){
    library(dplyr)
    library(tidyr)
    ## Read the datasets in
    x_train <- read.table("./dataset/train/X_train.txt", )
    y_train <- read.table("./dataset/train/y_train.txt")
    subject_train <- read.table("./dataset/train/subject_train.txt")
    x_test <- read.table("./dataset/test/X_test.txt")
    y_test <- read.table("./dataset/test/y_test.txt")
    subject_test <- read.table("./dataset/test/subject_test.txt")
    
    ## merge data
    x <- rbind(x_train, x_test)
    y <- rbind(y_train, y_test)
    subject <- rbind(subject_train, subject_test)
    
    ## assign the names of dataframe
    features <- read.table("./dataset/features.txt")
    names(x) <- features[,2]
    names(y) <- c("activity")
    names(subject) <- c("subject")
    
    data <- cbind(x, subject, y)
    
    ## find the indices of the columns that contains "mean()" or "std()"
    #select(data, contains(c("std()","mean()"))
    sub <- c(grep("mean()", names(x), fixed=TRUE), grep("std()", names(x), fixed=TRUE))
    sub_data <- data[sub]
    
    ## use descriptive variable names
    for( i in 1:length(names(sub_data))){
        
        #remove the brackets
        names(sub_data)[i] <- sub(pattern = "\\()", replacement = "", names(sub_data)[i])
        
        #replace the "-" with "_"
        names(sub_data)[i] <- gsub(pattern = "-", replacement = "_", names(sub_data)[i])
    }
    
    sub_data <- cbind(sub_data, subject, y)
    
    
    ## use descriptive activity names
    activity <- sub_data$activity
    sub_data$activity[activity==1] <- "WALKING" 
    sub_data$activity[activity==2] <- "WALKING_UPSTAIRS"
    sub_data$activity[activity==3] <- "WALKING_DOWNSTAIRS"
    sub_data$activity[activity==4] <- "SITTING"
    sub_data$activity[activity==5] <- "STANDING"
    sub_data$activity[activity==6] <- "LAYING"
    
    # create independent tidy data set with the average of each variable for each activity and each subject
    sub_data <- group_by(sub_data, subject, activity)
    temp <- select(sub_data, subject, activity)
    temp <- unique(temp)
    group_average <- summarize(group_by(sub_data, subject, activity), mean(tBodyAcc_mean_X),
                                mean(tBodyAcc_mean_Y),
                                mean(tBodyAcc_mean_Z),
                                mean(tGravityAcc_mean_X),
                                mean(tGravityAcc_mean_Y),
                                mean(tGravityAcc_mean_Z),
                                mean(tBodyAccJerk_mean_X),
                                mean(tBodyAccJerk_mean_Y),
                                mean(tBodyAccJerk_mean_Z),
                                mean(tBodyGyro_mean_X),          
                                mean(tBodyGyro_mean_Y),          
                                mean(tBodyGyro_mean_Z),         
                                mean(tBodyGyroJerk_mean_X),
                                mean(tBodyGyroJerk_mean_Y),
                                mean(tBodyGyroJerk_mean_Z),
                                mean(tBodyAccMag_mean),
                                mean(tGravityAccMag_mean),  
                                mean(tBodyAccJerkMag_mean),
                                mean(tBodyGyroMag_mean),
                                mean(tBodyGyroJerkMag_mean),
                                mean(fBodyAcc_mean_X),
                                mean(fBodyAcc_mean_Y),
                                mean(fBodyAcc_mean_Z),
                                mean(fBodyAccJerk_mean_X),     
                                mean(fBodyAccJerk_mean_Y),      
                                mean(fBodyAccJerk_mean_Z), 
                                mean(fBodyGyro_mean_X),
                                mean(fBodyGyro_mean_Y),
                                mean(fBodyGyro_mean_Z),
                                mean(fBodyAccMag_mean),
                                mean(fBodyBodyAccJerkMag_mean),
                                mean(fBodyBodyGyroMag_mean),    
                                mean(fBodyBodyGyroJerkMag_mean),
                                mean(tBodyAcc_std_X),
                                mean(tBodyAcc_std_Y),
                                mean(tBodyAcc_std_Z),           
                                mean(tGravityAcc_std_X),
                                mean(tGravityAcc_std_Y),
                                mean(tGravityAcc_std_Z),
                                mean(tBodyAccJerk_std_X),
                                mean(tBodyAccJerk_std_Y),
                                mean(tBodyAccJerk_std_Z),
                                mean(tBodyGyro_std_X),
                                mean(tBodyGyro_std_Y),          
                                mean(tBodyGyro_std_Z),
                                mean(tBodyGyroJerk_std_X),
                                mean(tBodyGyroJerk_std_Y),
                                mean(tBodyGyroJerk_std_Z),      
                                mean(tBodyAccMag_std),
                                mean(tGravityAccMag_std),
                                mean(tBodyAccJerkMag_std),
                                mean(tBodyGyroMag_std),         
                                mean(tBodyGyroJerkMag_std),
                                mean(fBodyAcc_std_X),
                                mean(fBodyAcc_std_Y),
                                mean(fBodyAcc_std_Z),           
                                mean(fBodyAccJerk_std_X),
                                mean(fBodyAccJerk_std_Y),
                                mean(fBodyAccJerk_std_Z),
                                mean(fBodyGyro_std_X),          
                                mean(fBodyGyro_std_Y),
                                mean(fBodyGyro_std_Z),
                                mean(fBodyAccMag_std),
                                mean(fBodyBodyAccJerkMag_std),  
                                mean(fBodyBodyGyroMag_std),
                                mean(fBodyBodyGyroJerkMag_std))
                                
    
    #for (i in 1:length(names(sub_data))){
        #print(sub_data[,var])
    #    col_group_mean <- summarize(group_by(sub_data, subject, activity), mean(sub_data[,names(sub_data)[i]]))
    #    col_group_mean <- summarize(sub_data, mean(names(sub_data)[i]))
    #    print(col_group_mean)
    #    cbind(temp, col_group_mean[,3])
    #}
    sub_data
}