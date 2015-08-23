# Author: Joshua Crone
# Date: Aug 19, 2015
# Course: Coursera - Getting and Cleaning Data
# Title: Course Project

# =========================================================================
# Requirements set out in assignment
# =========================================================================

# You should create one R script called run_analysis.R that does the 
# following:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.

# =========================================================================
# Start of original code
# =========================================================================

# =========================================================================
# 1) Merges the training and the test sets to create one data set.
# =========================================================================

# Read in label files
filepath = "./UCI HAR Dataset/activity_labels.txt"
activity.labels = read.table(filepath, 
                             col.names = c("label", "activity_names"),
                             colClasses = c("integer","character")
)

filepath = "./UCI HAR Dataset/features.txt"
feature.labels = read.table(filepath, 
                            col.names = c("label", "feature_names"),
                            colClasses = c("integer","character")
)

# Read in files for training set
filepath = "./UCI HAR Dataset/train/subject_train.txt"
subject.train = read.table(filepath,
                           col.names = "subject",
                           colClasses = "integer"
)

# Label the features with the feature names
filepath = "./UCI HAR Dataset/train/X_train.txt"
dataset.train = read.table(filepath,
                           col.names = feature.labels$feature_names
)

filepath = "./UCI HAR Dataset/train/y_train.txt"
activity.train = read.table(filepath,
                            col.names = "activity",
                            colClasses = "integer"
)

# Combine the subject, feature and activity data frames
dataset.train = cbind(subject.train$subject, dataset.train, 
                      activity.train$activity)

# Rename columns. When using cbind, the two, single-column data frames
# that were added take on the name as it appears in the cbind command
# (ie. activity.train$activity).
names(dataset.train)[1] = "subject"
names(dataset.train)[ncol(dataset.train)] = "activity"

# Read in files for test set
filepath = "./UCI HAR Dataset/test/subject_test.txt"
subject.test = read.table(filepath,
                           col.names = "subject",
                           colClasses = "integer"
)

# Label the features with the feature names
filepath = "./UCI HAR Dataset/test/X_test.txt"
dataset.test = read.table(filepath,
                           col.names = feature.labels$feature_names
)

filepath = "./UCI HAR Dataset/test/y_test.txt"
activity.test = read.table(filepath,
                            col.names = "activity",
                            colClasses = "integer"
)

# Combine the subject, feature and activity data frames
dataset.test = cbind(subject.test$subject, dataset.test, 
                      activity.test$activity)

# Rename columns. When using cbind, the two, single-column data frames
# that were added take on the name as it appears in the cbind command
# (ie. activity.test$activity).
names(dataset.test)[1] = "subject"
names(dataset.test)[ncol(dataset.test)] = "activity"

# Combine the two datasets
dataset.all = rbind(dataset.test, dataset.train)

# =========================================================================
# 2) Extracts only the measurements on the mean and standard deviation 
# =========================================================================

# Find the feature names that have 'std' or 'mean' in them
# NOTE: '1' is added to each index, since the 
ind.std = grep("std", feature.labels$feature_names) + 1
ind.mean = grep("mean", feature.labels$feature_names) + 1

ind.all = unique(c(ind.std, ind.mean, 1, ncol(dataset.all)))

ind.all = ind.all[order(ind.all)]

dataset.all = dataset.all[,ind.all]

# =========================================================================
# 3) Uses descriptive activity names to name the activities in the data set
# =========================================================================

# Convert activity to a factor, where the levels are the names in the 
# activity_labels.txt file.
dataset.all$activity = factor(dataset.all$activity, 
                              labels = activity.labels$activity_names)

# =========================================================================
# 4) Appropriately labels the data set with descriptive variable names. 
# =========================================================================

# This function will perform all of the required operations to 
# programmatically transform a column name to a more readable format.
# At nearly every step, the function first checks to see if the text
# to be removed or changed is even in the string, since if it's not, the
# sub or gsub functions would return 'NA' instead of a cleaned string.
cleanname <- function (s){
        # Copy the input, dirty string to a local variable
        x = s
        
        # Strip away all spaces and periods
        if (grepl(" ", x)){
                x = gsub(" ", "", x)
        }
        if (grepl("\\.", x)){
                x = gsub("\\.", "", x)
        }
        
        # Replace the leading 't' and 'f', denoting time and frequency
        # domain measurements, with 'TimeDomain' and 'FreqDomain',
        # respectively.
        if (substr(x,1,1) == "t"){
                x = sub("t", "TimeDomain", x)
        }
        else if (substr(x,1,1) == "f"){
                x = sub("f", "FreqDomain", x)
        }
        
        # Replace 'mean' with 'Mean', and 'std' with 'StandDev'
        if (grepl("mean", x)){
                x = gsub("mean", "Mean", x)
        }
        if (grepl("std", x)){
                x = gsub("std", "StandDev", x)
        }
        
        # Replace 'Acc' with 'Acceleration'
        if (grepl("Acc", x)){
                x = gsub("Acc", "Acceleration", x)
        }
        
        # Replace 'Mag' with 'Magnitude'
        if (grepl("Mag", x)){
                x = gsub("Mag", "Magnitude", x)
        }
        
        # Return the cleaned string
        x
}

# Apply the cleanname function to all of the names for the dataset
names(dataset.all) = lapply(names(dataset.all), cleanname)

# =========================================================================
# 5) From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
# =========================================================================

melteddata = reshape2::melt(dataset.all, id = c("subject", "activity"))
tidydata = reshape2::dcast(melteddata, subject + activity ~ variable, mean)

write.table(tidydata, "./tidydata.txt", row.name=FALSE)
