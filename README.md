Getting and Cleaning Data Project
=================================
### Files included in this project
* run_analysis.R: code that runs all the steps explained below
* codeBook.txt: code book that describes the all the vairables in the tidy data set that is the result in the final step
* READ.md: This file that explains all of the steps of the analysis

### Step 1
Download zipped data file and unzip into /data directory of project

### Step 2
Reads the feature names and activity labels from features.txt and activity_labels.txt

### Step 3
Reads subject_train.txt and subject_test.txt files and combines them to obtain subject ids
Reads X_train.tx and X_test.txt and combines them to obtain data set of feature values
Reads y_train.txt and y_test.txt and combines them to obtain data set of activity ids

Finally combines the previous three data sets to match up the measured data for each activty perfomed by each subject

### Step 4
Find all features that are the mean or standard deviation value
Create subset of data from Step 3 based on these features
Rename activity id number to associated activity name from activity_labels.txt

### Step 5
Reshape data to create the final data set where the average of each feature in question is given for each subject's activity

### Step 6
Rename feature names in columns
Write out tidy data set to filed named tidyData.txt

### Reading the output file
tidyData <- read.table("tidyData.txt", header = TRUE)