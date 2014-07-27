## Eddie Kollar
## Getting and Cleaning Data Project
## run_analysis.R

## Step 1
## Download data
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile = 'Dataset.zip', method = 'curl')

## Unzips all data into one directory 'data'
unzip("Dataset.zip", junkpaths=TRUE, exdir = "data")

## Step 2

## Read features.txt to get labels for all the features
## Remove "( )" parenthesis characters from the feature names as well
featureNames = unlist(lapply(read.table("data/features.txt", stringsAsFactors = FALSE)[,2], function(x) gsub("[()]", "", x)))

## Read activity_labels.txt
activityLabels = read.table("data/activity_labels.txt", stringsAsFactors = FALSE)[,2]

## Read subject ids for train and test data sets
subjectIdsTrain = read.table("data/subject_train.txt", col.names = ("subjectId"))
subjectIdsTest = read.table("data/subject_test.txt", col.names = ("subjectId"))
subjectIds = rbind(subjectIdsTrain, subjectIdsTest)

## Clean up temporary data frames
rm(subjectIdsTrain, subjectIdsTest)

## Read train and test data
trainData = read.table("data/X_train.txt", col.names = featureNames)
testData = read.table("data/X_test.txt", col.names = featureNames)
activityData = rbind(trainData, testData)

## Clean up temporary data frames
rm(trainData, testData)

## Read train and test activity lables
activityIdsTrain = read.table("data/y_train.txt", col.names = ("activity"))
activityIdsTest = read.table("data/y_test.txt", col.names = ("activity"))
activityIds = rbind(activityIdsTrain, activityIdsTest)

allData = data.frame(cbind(subjectIds, activityData, activityIds))

## Cleanup temporary data frames
rm(activityIdsTrain, activityIdsTest, subjectIds, activityData, activityIds)

## Step 3

## Find all features that are the mean or standard deviation
## Returns a logical vector indicating if the column name includes strings "mean" or "std"
featuresLogical = sapply(featureNames, function(x){ grepl("mean", x) | grepl("std", x) })

## Also include subjectIds and activityIds that are the first and last columns in allData data frame
dataSubset = allData[,which(c(TRUE, featuresLogical, TRUE))]

rm(allData)

## Adds activty column to match activity
dataSubset$activity = activityLabels[dataSubset$activity]

## Step 4

## Generate tidy data set
library(reshape2)

## Melt data based on subject and activity
dataMelt = melt(dataSubset, id = c("subjectId", "activity"))

## Cast a data frame that gives the mean of each feature for a given subject performing each activity
tidyData = dcast(dataMelt, subjectId + activity ~ variable, mean)
rm(dataMelt)

## Step 5

## Write the tidy data into tidyData.txt excluding row names
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)