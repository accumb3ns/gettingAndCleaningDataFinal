#Getting and Cleaning Data Course Project Codebook

This project is based on the data downloaded from the "Human Activity Recognition Using Smartphones Data Set" 
by Reyes-Ortiz et al. They state in their features_info file that the data and variables are as follows:

  "The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
  These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
  Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to 
  remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ 
  and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

  Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ 
  and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm 
  (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

  Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, 
  fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

  These signals were used to estimate variables of the feature vector for each pattern:  
  '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

  The set of variables that were estimated from these signals are: 

    mean(): Mean value
    std(): Standard deviation
    ...."

Impressive! We also have a subject id variable (1-30), and an activity variable which can be one of the following for 
the activity performed at the time of measurement:
    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING

##Run_Analysis.R script transformations
run_analysis.R begins by downloading the zip file from the UCI repository (checking of course whether the file
and/or directory already exist!). This data is loaded into memory using read.table() and the data (x files) and numeric
activity labels (y files) are merged for each respective data set. The subject id labels are also merged.

Next, both training and test sets are merged per the instructions of the assignment, and the variable names are applied from 
the "features.txt" file. Note here that R doesn't like exact variable names in features.txt; this is a problem in the next
step where we use dplyr's "select" function, but I found an excellent workaround to this exact problem via Stack Overflow
thanks to user Lantana; we can use the make.names function from base R to fix the problem.

Next, we want to select ONLY the measurements on the mean and standard deviation for each measurement which is 
accomplished using the select function of dplyr.





##References
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset
  for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, 
  Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
  
"dplyr “Select” - Error: found duplicated column name" 
  Available: http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name
  
David Hood, "Getting and Cleaning the Assignment". Thoughtfulbloke blog.
  Available: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
