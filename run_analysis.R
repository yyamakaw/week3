
## Download file and unzip data
setwd("./R/")
fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/FUC_HAR_Dataset.zip")
unzip("./data/FUC_HAR_Dataset.zip", exdir="./data")

library(data.table)

## Read Test and Train data
SubjTestDT <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjTainDT <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
XTestDT <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
YTestDT <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
XTrainDT <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
YTrainDT <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## Merge the training and the test sets to create one data set.
AllXDT <- rbind(XTestDT, XTrainDT)
AllYDT <- rbind(YTestDT, YTrainDT)
AllSubjectDT <- rbind(SubjectTestDT, SubjectTrainDT)
HeaderDT <- cbind(AllSubjectDT, AllYDT)
AllDT <- cbind(AllXDT, HeaderDT)

## Extracts only the measurements on the mean and standard deviation for each measurement.
FeatureDT <- read.table("./data/UCI HAR Dataset/features.txt")
mean_std <- grep("mean\\(\\)|std\\(\\)", FeatureDT[, 2])
AllDT_mean_std <- AllDT[, mean_std]
names(AllDT_mean_std) <- FeatureDT[mean_std, 2]

## Uses descriptive actifity names to name the activities in the data set
ActivityDT <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
AllDT_mean_std_a <- ActivityDT[AllDT_mean_std[, 1], 2]
name(AllDT_mean_std_a) <- "activity"

##Appropriately labels the data set with descriptive variable names. 
names(AllSubjectDT) <- "Subject"
AllDT <- cbind(AllXDT, AllYDT, AllSubjectDT)
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
