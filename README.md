GetData009_Course_Project
=====================

This scrip completes the assigment for the Getting and Cleaning Data Course from the JHS

The scrip is self contained and completes all the steps required, specifically:
  - It downloads the raw data from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    The original data is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
  - It unzips the data
  - then, per the assignment instructions:
    1.  Merges the training and the test sets to create one data set.
    2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
    3.	Uses descriptive activity names to name the activities in the data set
    4.	Appropriately labels the data set with descriptive variable names. 
    5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output from steps 1-4 above is a comma-delimited file entiled "Tidy_Dataset.csv"

The output from step 5 is a comma-delimited file entitled "means_dataset.csv" The values in this file are 
the averages (or mean) of each of the variables in the "Tidy_Dataset.csv" file

To execute all of the above run the script entitled "Run_Analysis.R"

To see a description of all the variables please see the file entiled "Codebook.md" also included in this depository. 
The CodeBook file describes the steps in the scrip and describes the variables included in each of the datasets.



