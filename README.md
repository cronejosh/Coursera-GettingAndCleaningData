# Getting and Cleaning Data - Course Project
## README

Author: Joshua Crone

Date: August 22, 2015

### Introduction

This file describes various aspects related to the writing and proper function of the run_analysis.R script, including discussion of the most significant decisions made during the process. For a discussion of the variables themselves, see the CodeBook.md file.

### File Structure Assumptions

The run_analysis.R script assumes that it is being run in a working directory that contains the UCI HAR Dataset downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Furthermore, that directory is assumed to contain the following files and directories:

* "./UCI HAR Dataset/activity_labels.txt"
* "./UCI HAR Dataset/features.txt"
* "./UCI HAR Dataset/train/subject_train.txt"
* "./UCI HAR Dataset/train/X_train.txt"
* "./UCI HAR Dataset/train/y_train.txt"
* "./UCI HAR Dataset/test/subject_test.txt"
* "./UCI HAR Dataset/test/X_test.txt"
* "./UCI HAR Dataset/test/y_test.txt"

### Analysis Procedure and Explanation of Variable Choices

The run_analysis.R is thoroughly commented to explain what is happening at each stage of the script. It is clearly broken down into the five steps required by the assignment definition 

>You should create one R script called run_analysis.R that does the following. 

>1. Merges the training and the test sets to create one data set.
>2. Extracts only the measurements on the mean and standard deviation for each measurement. 
>3. Uses descriptive activity names to name the activities in the data set
>4. Appropriately labels the data set with descriptive variable names. 
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It is worth noting here that some operations may have been easier to perform in a different order, but to heed the advice of TAs and avoid careless errors, the steps were performed in the order given. This means that some sections of code are not as elegant or clean (cf. indexing of columns containing 'std' and 'mean').

The process is briefly summarized here:

1. Each of the relevant files are loaded into their respective objects (activity labels, subject labels and feature vectors). Data frames are constructed by column-binding these three objects together, for both the training and testing datasets. These two data frames are then row-bound together, to form the total dataset. 
2. Next, the columns that do not relate to a mean or standard deviation are stripped out. This is done by searching the feature name strings for "mean" and "std". Only those containg these substrings are kept. This excludes a few features/variables that say mean, but these are all measurements of the angles of means (or std's), but not a mean (or std) themselves, such as "angle(tBodyAccMean,gravity)". The indices of elements containing the desired string are obtained and used to subset the dataset. 
3. Then the integer activity labels are replaced with desciptive character labels by converting that column into a factor vector.
4. In order to obtain descriptive variable names, one of the main requirements of tidy data, a function is defined ('cleanname') that takes a string as an arguement and applies a series of cleaning operations to it. These include stripping away any spaces or periods, and elaborating short forms, such as replacing 'Acc' with 'Acceleration'. 
5. Finally, the reduced, tidy dataset is produced by recasting the data into a wide format where each column contains a single variable and each row contains a single observation. Specifically, each row is for a single activity type (WALKING, LAYING, etc.), for a single subject. 