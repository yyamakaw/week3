Getting and Cleaning Data Course Project

a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Read following data.table from the data:
SubjTestDT <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
SubjTainDT <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
XTestDT <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
YTestDT <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
XTrainDT <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
YTrainDT <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

Merge into:
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


##Appropriately labels the data set with descriptive variable names. 
names(AllSubjectDT) <- "Subject"
AllDT <- cbind(AllXDT, AllYDT, AllSubjectDT)
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
