run_analysis <- function(){
  ## load required packages
  library(dplyr)
  
  ## download file after checking if it or the directory already exist
  destfile <- "./UCIdata/UCIdata.zip"
  fileUrl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  if (!file.exists(destfile)) {
    if(!file.exists("UCIdata")){
      dir.create("UCIdata")
    }
    
    download.file(fileUrl, destfile)
  }

  unzip("./UCIdata/UCIdata.zip", exdir = "./UCIdata")
  
  ## load data into memory
  x_train <- read.table(file = "./UCIdata/UCI HAR Dataset/train/X_train.txt", sep = "", stringsAsFactors = FALSE)
  y_train <- read.table(file = "./UCIdata/UCI HAR Dataset/train/Y_train.txt", sep = "", stringsAsFactors = FALSE)
  subject_train <- read.table(file = "./UCIdata/UCI HAR Dataset/train/subject_train.txt", sep = "", stringsAsFactors = FALSE)
  
  x_test <- read.table(file = "./UCIdata/UCI HAR Dataset/test/X_test.txt", sep = "", stringsAsFactors = FALSE)
  y_test <- read.table(file = "./UCIdata/UCI HAR Dataset/test/Y_test.txt", sep = "", stringsAsFactors = FALSE)
  subject_test <- read.table(file = "./UCIdata/UCI HAR Dataset/test/subject_test.txt", sep = "", stringsAsFactors = FALSE)
  
  features<- read.table(file = "./UCIdata/UCI HAR Dataset/features.txt", sep = "", stringsAsFactors = FALSE)
  activity_labels<- read.table(file = "./UCIdata/UCI HAR Dataset/activity_labels.txt", sep = "", stringsAsFactors = FALSE)
  
  ## merge activity labels
  testData<-cbind(y_test,x_test)
  trainData<-cbind(y_train,x_train)
  
  ## merge subject labels
  testData <- cbind(subject_test, testData)
  trainData <- cbind(subject_train, trainData)
  
  ## merge the training and the test sets to create one data set
  mergedData<-rbind(testData,trainData)
  
  ## make feature names valid column names and label the data set with descriptive variable names
  valid_column_names <- make.names(names=features[,2], unique=TRUE, allow_ = TRUE)
  colnames(mergedData)<-c("Subject", "Activity", valid_column_names)
  
  ## extract only the measurements on the mean and standard deviation for each measurement
  selected_columns<- select(mergedData, Subject, Activity, contains(".mean."), contains("std"))
  
  ## apply descriptive activity names to name the activities in the data set
  selected_columns$Activity<-cut(selected_columns$Activity, breaks=0:6, labels=activity_labels$V2)
  
  ## calculate means for each variable for each activity and each subject
  summaryMeans <- selected_columns %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
  
  ## write tidy summary data set to text file for submission
  write.table(summaryMeans, file = "tidy_UCI_HAR_dataset_means_for_each_subject_and_activity.txt", row.name=FALSE)
}