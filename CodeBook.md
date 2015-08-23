# Getting and Cleaning Data - Course Project
## Code Book

Author: Joshua Crone

Date: August 22, 2015

The variables, in the order they appear in the data set, are shown below. The names have been changed from the originals (found in 'UCI HAR Dataset/features_info.txt') to improve their readability, thus satisfying the related requirement of tidy data. More detailed descriptions of these variables and their origins can be found in the 'UCI HAR Dataset/features_info.txt' and 'UCI HAR Dataset/README.txt' files. Explicit description of each variable is not required, because of the level of detail in the names.

The only remaining variables, as per the project instructions, are those pertaining to the mean and standard deviation (StandDev) of the variables. Measurements in both the time (TimeDomain) and frequency (FreqDomain) domain are reported. 

The acceleration due to gravity and body are in separate variables (labeled 'Body' and 'Grav', respectively). The derivative of acceleration, or jerk, is also shown.

All values, other than the 'subject' and 'activity' variables, are normalized (and therefore without units) and between -1 and 1.

Measurements in each of the individual cartesian directions (X, Y and Z), as well as the magnitude, are reported. In the below list, for the sake of brevity, 'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Variable Names

* subject : Integer value (1 - 30) uniquely identifying the particpants in the study

Time domain measurements

* TimeDomainBodyAccelerationMeanXYZ 
* TimeDomainBodyAccelerationStandDevXYZ
* TimeDomainGravityAccelerationMeanXYZ
* TimeDomainGravityAccelerationStandDevXYZ
* TimeDomainBodyAccelerationJerkMeanXYZ
* TimeDomainBodyAccelerationJerkStandDevXYZ
* TimeDomainBodyGyroMeanXYZ
* TimeDomainBodyGyroStandDevXYZ
* TimeDomainBodyGyroJerkMeanXYZ
* TimeDomainBodyGyroJerkStandDevXYZ
* TimeDomainBodyAccelerationMagnitudeMean
* TimeDomainBodyAccelerationMagnitudeStandDev
* TimeDomainGravityAccelerationMagnitudeMean
* TimeDomainGravityAccelerationMagnitudeStandDev
* TimeDomainBodyAccelerationJerkMagnitudeMean
* TimeDomainBodyAccelerationJerkMagnitudeStandDev
* TimeDomainBodyGyroMagnitudeMean
* TimeDomainBodyGyroMagnitudeStandDev
* TimeDomainBodyGyroJerkMagnitudeMean
* TimeDomainBodyGyroJerkMagnitudeStandDev

Frequency domain measurements

* FreqDomainBodyAccelerationMeanXYZ
* FreqDomainBodyAccelerationStandDevXYZ
* FreqDomainBodyAccelerationMeanFreqXYZ
* FreqDomainBodyAccelerationJerkMeanXYZ
* FreqDomainBodyAccelerationJerkStandDevXYZ
* FreqDomainBodyAccelerationJerkMeanFreqXYZ
* FreqDomainBodyGyroMeanXYZ
* FreqDomainBodyGyroStandDevXYZ
* FreqDomainBodyGyroMeanFreqXYZ
* FreqDomainBodyAccelerationMagnitudeMean
* FreqDomainBodyAccelerationMagnitudeStandDev
* FreqDomainBodyAccelerationMagnitudeMeanFreq
* FreqDomainBodyBodyAccelerationJerkMagnitudeMean
* FreqDomainBodyBodyAccelerationJerkMagnitudeStandDev
* FreqDomainBodyBodyAccelerationJerkMagnitudeMeanFreq
* FreqDomainBodyBodyGyroMagnitudeMean
* FreqDomainBodyBodyGyroMagnitudeStandDev
* FreqDomainBodyBodyGyroMagnitudeMeanFreq
* FreqDomainBodyBodyGyroJerkMagnitudeMean
* FreqDomainBodyBodyGyroJerkMagnitudeStandDev
* FreqDomainBodyBodyGyroJerkMagnitudeMeanFreq

* activity : Factor variable (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) describing the activity being performed while the measurements were being recorded.

