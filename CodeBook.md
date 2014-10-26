CodeBook
========

This Code Book describes the data, variables and files used in run_analysis.R to obtain the required 'Tidy Data' 

This Code Book also assumes you have read the Project's README.md 

The Samsung Data 
================

'The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at 
a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Check the README.txt file for further details about this dataset'

Extracted from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files Used
==========

The required data can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Inside the file you will find the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- *'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- *'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- *'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

-*Not used in run_analysis.R

Variables (Extracted and edited from 'features_info.txt')
=========================================================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAccelerometer-XYZ and tGyroscope-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median
filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal 
was then separated into body and gravity acceleration signals (tBodyAccelerometer-XYZ and tGravityAccelerometer-XYZ) using another low pass Butterworth filter 
with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and 
tBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccelerometerMagnitude, 
tGravityAccelerometerMagnitude, tBodyAccelerometerJerkMagnitude, tBodyGyroscopeMagnitude, tBodyGyroscopeJerkMagnitude). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAccelerometer-XYZ, fBodyAccelerometerJerk-XYZ, fBodyGyroscope-XYZ, 
fBodyAccelerometerJerkMagnitude, fBodyGyroscopeMagnitude, fBodyGyroscopeJerkMagnitude. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAccelerometer-XYZ
- tGravityAccelerometer-XYZ
- tBodyAccelerometerJerk-XYZ
- tBodyGyroscope-XYZ
- tBodyGyroscopeJerk-XYZ
- tBodyAccelerometerMagnitude
- tGravityAccelerometerMagnitude
- tBodyAcceleromterJerkMagnitude
- tBodyGyroscopeMagnitude
- tBodyGyroscopeJerkMagnitude
- fBodyAccelerometer-XYZ
- fBodyAccelerometerJerk-XYZ
- fBodyGyroscope-XYZ
- fBodyAccelerometerMagnitude
- fBodyAccelerometerJerkMagnitude
- fBodyGyroscopeMagnitude
- fBodyGyroscopeJerkMagnitude

The set of variables that were estimated from these signals and included in 'tidy_data.txt' are: 

- Mean value
- Standard deviation

Transformations
===============

- Combined X_train and X_test data sets
- Combined previous result with subject_train and subject_test data sets
- Used recode (car package) to change all numbers codes in y_train and y_test data sets to the appropriate Activity labels and combined them as well
- Combined Activities with the Subject, X_train and X_test data set
- Replaced column names with the features data set, and added Subject and Activity as names for the last two columns
- Used grep to subset a data set with only means and standard deviations, then used -grep to remove frequency mean columns
- Used melt and dcast to create a data set that shows the mean of each varibale for each Subject and Activity
- Used gsub to remove invalid variable characters '()' and '-'
- Used gsub to expand some key word abreviations. 'Acc' to 'Accelerometer', 'Mag' to 'Magnitude', 'std' to 'StandardDeviation' and 'Gyro' to 'Gyroscope'
- Used write.table to save a text file of the final data set. 
- The result is the 'tidy_data' data set with the following format (first 6 rows):
  
  | Subject  |      variable              |Laying      |Sitting |Standing| Walking |Walking Downstairs| Walking Upstairs|
|--------|---------------------------|---------- |----------- |-----------|------|------------------|------------------|
|1       |tBodyAccelerometermeanX    |0.22159824 |0.261237565 |  0.27891763|0.27733076| 0.289188320|0.25546169|
|1       |tBodyAccelerometermeanY    |-0.04051395|-0.001308288| -0.01613759| -0.01738382|   -0.009918505|  -0.02395315|
|1       |tBodyAccelerometermeanZ    |-0.11320355|-0.104544182| -0.11060182| -0.11114810|  -0.107566191|       -0.09730200|
|1       |tGravityAccelerometermeanX |-0.24888180|0.831509933 | 0.94295200|  0.93522320| 0.931874419|        0.89335110|
|1       |tGravityAccelerometermeanY |0.70554977 |0.204411593 |-0.27298383| -0.28216502| -0.266610339|       -0.36215336|
|1       |tGravityAccelerometermeanZ |0.44581772 |0.332043703 | 0.01349058| -0.06810286| -0.062119959|       -0.07540294|
   
