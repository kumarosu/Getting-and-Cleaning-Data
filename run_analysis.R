# Goal: Create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Data for this project is Downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
# Reference for the data : [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
# Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. 
# Any commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

# loading dplyr and ddply library
library(dplyr)
library(plyr)


# Deleting accelerometers directory if exists

unlink("./accelerometers", recursive = TRUE)

# Raw Data Readiness - Download and unzip the data from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

if(!file.exists("./accelerometers")){dir.create("./accelerometers")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./accelerometers/Samsung_accelerometers.zip")){download.file(fileUrl,destfile="./accelerometers/Samsung_accelerometers.zip",method="curl")}
unzip ("./accelerometers/Samsung_accelerometers.zip", exdir = "./accelerometers") 

# Load and rename the Activity Labels for the Dataset 

activity_labels<-read.table("./accelerometers/UCI HAR Dataset/activity_labels.txt", header=FALSE)
activity_labels<-dplyr::rename(activity_labels, activity_id = V1,activity_description = V2)
features<- read.table("./accelerometers/UCI HAR Dataset/features.txt", header=FALSE)

# Load the Training Dataset 

X_Train<-read.table("./accelerometers/UCI HAR Dataset/train/X_train.txt", header=FALSE)
Y_Train<-read.table("./accelerometers/UCI HAR Dataset/train/y_train.txt", header=FALSE)
Subject_Train<-read.table("./accelerometers/UCI HAR Dataset/train/subject_train.txt", header=FALSE)

# Load the Test Dataset 

X_Test<-read.table("./accelerometers/UCI HAR Dataset/test/X_test.txt", header=FALSE)
Y_Test<-read.table("./accelerometers/UCI HAR Dataset/test/Y_test.txt", header=FALSE)
Subject_Test<-read.table("./accelerometers/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

# Step 1 - Merges the training and the test sets to create one data set. This will have 3 datasets each for X, Y and Subject


Y_Train_Test_Row_Merge<-rbind(Y_Train,Y_Test,sort=F)
Subject_Train_Test_Row_Merge<-rbind(Subject_Train,Subject_Test,sort=F)

# Step 1 - Merges the training and the test sets to create one data set. This will have 3 datasets each for X, Y and Subject

X_Train_Test_Row_Merge<-rbind(X_Train,X_Test,sort=F)
Y_Train_Test_Row_Merge<-rbind(Y_Train,Y_Test,sort=F)
Subject_Train_Test_Row_Merge<-rbind(Subject_Train,Subject_Test,sort=F)

# Step 1 Contd - Rename the Column Header for Y Training and Subject Dataset 

Y_Train_Test_Row_Merge<-dplyr::rename(Y_Train_Test_Row_Merge, activity_id = V1) # Rename the column header to be descriptive
Subject_Train_Test_Row_Merge<-dplyr::rename(Subject_Train_Test_Row_Merge, subject_id=V1) # Rename the column header to be descriptive

# Step 1 completion - Consolidate all datasets to one final dataset 

X_Y_Subject_Col_Merge<-cbind(X_Train_Test_Row_Merge,Y_Train_Test_Row_Merge,Subject_Train_Test_Row_Merge) # Merges all into one final tidy dataset 

# Step 2 - From X_Y_Subject_Col_Merge, We extract only the mean and standard deviation for each mesurement along with activity and subject data. Measurements are listed below for reference
# 1 tBodyAcc-mean()-X 
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# 6 tBodyAcc-std()-Z
# 41 tGravityAcc-mean()-X
# 42 tGravityAcc-mean()-Y
# 43 tGravityAcc-mean()-Z
# 44 tGravityAcc-std()-X
# 45 tGravityAcc-std()-Y
# 46 tGravityAcc-std()-Z
# 81 tBodyAccJerk-mean()-X
# 82 tBodyAccJerk-mean()-Y
# 83 tBodyAccJerk-mean()-Z
# 84 tBodyAccJerk-std()-X
# 85 tBodyAccJerk-std()-Y
# 86 tBodyAccJerk-std()-Z
# 121 tBodyGyro-mean()-X
# 122 tBodyGyro-mean()-Y
# 123 tBodyGyro-mean()-Z
# 124 tBodyGyro-std()-X
# 125 tBodyGyro-std()-Y
# 126 tBodyGyro-std()-Z
# 161 tBodyGyroJerk-mean()-X
# 162 tBodyGyroJerk-mean()-Y
# 163 tBodyGyroJerk-mean()-Z
# 164 tBodyGyroJerk-std()-X
# 165 tBodyGyroJerk-std()-Y
# 166 tBodyGyroJerk-std()-Z
# 201 tBodyAccMag-mean()
# 202 tBodyAccMag-std()
# 214 tGravityAccMag-mean()
# 215 tGravityAccMag-std()
# 227 tBodyAccJerkMag-mean()
# 228 tBodyAccJerkMag-std()
# 240 tBodyGyroMag-mean()
# 241 tBodyGyroMag-std()
# 253 tBodyGyroJerkMag-mean()
# 254 tBodyGyroJerkMag-std()
# 266 fBodyAcc-mean()-X
# 267 fBodyAcc-mean()-Y
# 268 fBodyAcc-mean()-Z
# 269 fBodyAcc-std()-X
# 270 fBodyAcc-std()-Y
# 271 fBodyAcc-std()-Z
# 345 fBodyAccJerk-mean()-X
# 346 fBodyAccJerk-mean()-Y
# 347 fBodyAccJerk-mean()-Z
# 348 fBodyAccJerk-std()-X
# 349 fBodyAccJerk-std()-Y
# 350 fBodyAccJerk-std()-Z
# 424 fBodyGyro-mean()-X
# 425 fBodyGyro-mean()-Y
# 426 fBodyGyro-mean()-Z
# 427 fBodyGyro-std()-X
# 428 fBodyGyro-std()-Y
# 429 fBodyGyro-std()-Z
# 503 fBodyAccMag-mean()
# 504 fBodyAccMag-std()
# 516 fBodyBodyAccJerkMag-mean()
# 517 fBodyBodyAccJerkMag-std()
# 529 fBodyBodyGyroMag-mean()
# 530 fBodyBodyGyroMag-std()
# 542 fBodyBodyGyroJerkMag-mean()
# 543 fBodyBodyGyroJerkMag-std()


X_Y_Subject_Col_Merge_Subset<-select(X_Y_Subject_Col_Merge,activity_id,subject_id,V1:V6,V41:V46,V81:V86,V121:V126,V161:V166,V201:V202,V214:V215,V227:V228,V240:V241,V253:V254,V266:V271,V345:V350,V424:V429,V503:V504,V516:V517,V529:V530,V542:V543)

# Step 3 - Merges activity names to name the activities in the data set X_Y_Subject_Col_Merge_Subset

X_Y_Subject_Col_Merge_Subset_activty_Desc<-merge(X_Y_Subject_Col_Merge_Subset,activity_labels,by.x='activity_id',by.y='activity_id',all=TRUE)

X_Y_Subject_Col_Merge_Subset_activty_Desc<-filter(X_Y_Subject_Col_Merge_Subset_activty_Desc, activity_id>0) # Excluding all zero rows due to rbind operation

# Step 4 - Rename the variable name with descriptive name 


X_Y_Subject_with_Descriptive_Names <- dplyr::rename(X_Y_Subject_Col_Merge_Subset_activty_Desc, x_axis_tBodyAcc_mean=V1, y_axis_tBodyAcc_mean=V2, z_axis_tBodyAcc_mean=V3, x_axis_tBodyAcc_std=V4, y_axis_tBodyAcc_std=V5, z_axis_tBodyAcc_std=V6, 
                                             x_axis_tGravityAcc_mean=V41, y_axis_tGravityAcc_mean=V42, z_axis_tGravityAcc_mean=V43, x_axis_tGravityAcc_std=V44, y_axis_tGravityAcc_std=V45, z_axis_tGravityAcc_std=V46, x_axis_tBodyAccJerk_mean=V81, 
                                             y_axis_tBodyAccJerk_mean=V82, z_axis_tBodyAccJerk_mean=V83, x_axis_tBodyAccJerk_std=V84, y_axis_tBodyAccJerk_std=V85, z_axis_tBodyAccJerk_std=V86, x_axis_tBodyGyro_mean=V121, 
                                             y_axis_tBodyGyro_mean=V122, z_axis_tBodyGyro_mean=V123, x_axis_tBodyGyro_std=V124, y_axis_tBodyGyro_std=V125, z_axis_tBodyGyro_std=V126, x_axis_tBodyGyroJerk_mean=V161, 
                                             y_axis_tBodyGyroJerk_mean=V162, z_axis_tBodyGyroJerk_mean=V163, x_axis_tBodyGyroJerk_std=V164, y_axis_tBodyGyroJerk_std=V165, z_axis_tBodyGyroJerk_std=V166, tBodyAccMag_mean=V201, tBodyAccMag_std=V202,
                                             tGravityAccMag_mean=V214, tGravityAccMag_std=V215, tBodyAccJerkMag_mean=V227, tBodyAccJerkMag_std=V228,tBodyGyroMag_mean=V240, tBodyGyroMag_std=V241, tBodyGyroJerkMag_mean=V253, tBodyGyroJerkMag_std=V254, 
                                             x_axis_fBodyAcc_mean=V266, y_axis_fBodyAcc_mean=V267, z_axis_fBodyAcc_mean=V268, x_axis_fBodyAcc_std=V269, y_axis_fBodyAcc_std=V270, z_axis_fBodyAcc_std=V271,
                                             x_axis_fBodyAccJerk_mean=V345, y_axis_fBodyAccJerk_mean=V346, z_axis_fBodyAccJerk_mean=V347, x_axis_fBodyAccJerk_std=V348, y_axis_fBodyAccJerk_std=V349, z_axis_fBodyAccJerk_std=V350,
                                             x_axis_fBodyGyro_mean=V424, y_axis_fBodyGyro_mean=V425, z_axis_fBodyGyro_mean=V426, x_axis_fBodyGyro_std=V427, y_axis_fBodyGyro_std=V428, z_axis_fBodyGyro_std=V429,
                                             fBodyAccMag_mean=V503, fBodyAccMag_std=V504,fBodyBodyAccJerkMag_mean=V516, fBodyBodyAccJerkMag_std=V517,fBodyBodyGyroMag_mean=V529, fBodyBodyGyroMag_std=V530,fBodyBodyGyroJerkMag_mean=V542, 
                                             fBodyBodyGyroJerkMag_std=V543)

# Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
            
Mean_X_Y_Subject_with_Descriptive_Names <- ddply(X_Y_Subject_with_Descriptive_Names, .(activity_id,subject_id,activity_description), summarise, 
                                                x_axis_tBodyAcc_mean=mean(x_axis_tBodyAcc_mean), 
                                                y_axis_tBodyAcc_mean=mean(y_axis_tBodyAcc_mean), 
                                                z_axis_tBodyAcc_mean=mean(z_axis_tBodyAcc_mean), 
                                                x_axis_tBodyAcc_std=mean(x_axis_tBodyAcc_std), 
                                                y_axis_tBodyAcc_std=mean(y_axis_tBodyAcc_std), 
                                                z_axis_tBodyAcc_std=mean(z_axis_tBodyAcc_std), 
                                                x_axis_tGravityAcc_mean=mean(x_axis_tGravityAcc_mean), 
                                                y_axis_tGravityAcc_mean=mean(y_axis_tGravityAcc_mean), 
                                                z_axis_tGravityAcc_mean=mean(z_axis_tGravityAcc_mean), 
                                                x_axis_tGravityAcc_std=mean(x_axis_tGravityAcc_std),
                                                y_axis_tGravityAcc_std=mean(y_axis_tGravityAcc_std), 
                                                z_axis_tGravityAcc_std=mean(z_axis_tGravityAcc_std), 
                                                x_axis_tBodyAccJerk_mean=mean(x_axis_tBodyAccJerk_mean), 
                                                y_axis_tBodyAccJerk_mean=mean(y_axis_tBodyAccJerk_mean), 
                                                z_axis_tBodyAccJerk_mean=mean(z_axis_tBodyAccJerk_mean), 
                                                x_axis_tBodyAccJerk_std=mean(x_axis_tBodyAccJerk_std), 
                                                y_axis_tBodyAccJerk_std=mean(y_axis_tBodyAccJerk_std), 
                                                z_axis_tBodyAccJerk_std=mean(z_axis_tBodyAccJerk_std), 
                                                x_axis_tBodyGyro_mean=mean(x_axis_tBodyGyro_mean), 
                                                y_axis_tBodyGyro_mean=mean(y_axis_tBodyGyro_mean), 
                                                z_axis_tBodyGyro_mean=mean(x_axis_tBodyAccJerk_mean), 
                                                x_axis_tBodyGyro_std=mean(x_axis_tBodyGyro_std), 
                                                y_axis_tBodyGyro_std=mean(y_axis_tBodyGyro_std), 
                                                z_axis_tBodyGyro_std=mean(z_axis_tBodyGyro_std), 
                                                x_axis_tBodyGyroJerk_mean=mean(x_axis_tBodyGyroJerk_mean), 
                                                y_axis_tBodyGyroJerk_mean=mean(y_axis_tBodyGyroJerk_mean), 
                                                z_axis_tBodyGyroJerk_mean=mean(z_axis_tBodyGyroJerk_mean), 
                                                x_axis_tBodyGyroJerk_std=mean(x_axis_tBodyGyroJerk_std), 
                                                y_axis_tBodyGyroJerk_std=mean(y_axis_tBodyGyroJerk_std), 
                                                z_axis_tBodyGyroJerk_std=mean(z_axis_tBodyGyroJerk_std), 
                                                tBodyAccMag_mean=mean(tBodyAccMag_mean), 
                                                tBodyAccMag_std=mean(tBodyAccMag_std),
                                                tGravityAccMag_mean=mean(tGravityAccMag_mean), 
                                                tGravityAccMag_std=mean(tGravityAccMag_std), 
                                                tBodyAccJerkMag_mean=mean(tBodyAccJerkMag_mean), 
                                                tBodyAccJerkMag_std=mean(tBodyAccJerkMag_std),
                                                tBodyGyroMag_mean=mean(tBodyGyroMag_mean), 
                                                tBodyGyroMag_std=mean(tBodyGyroMag_std), 
                                                tBodyGyroJerkMag_mean=mean(tBodyGyroJerkMag_mean), 
                                                tBodyGyroJerkMag_std=mean(tBodyGyroJerkMag_std), 
                                                x_axis_fBodyAcc_mean=mean(x_axis_fBodyAcc_mean), 
                                                y_axis_fBodyAcc_mean=mean(y_axis_fBodyAcc_mean), 
                                                z_axis_fBodyAcc_mean=mean(z_axis_fBodyAcc_mean), 
                                                x_axis_fBodyAcc_std=mean(x_axis_fBodyAcc_std), 
                                                y_axis_fBodyAcc_std=mean(y_axis_fBodyAcc_std), 
                                                z_axis_fBodyAcc_std=mean(z_axis_fBodyAcc_std),
                                                x_axis_fBodyAccJerk_mean=mean(x_axis_fBodyAccJerk_mean), 
                                                y_axis_fBodyAccJerk_mean=mean(y_axis_fBodyAccJerk_mean), 
                                                z_axis_fBodyAccJerk_mean=mean(z_axis_fBodyAccJerk_mean), 
                                                x_axis_fBodyAccJerk_std=mean(x_axis_fBodyAccJerk_std), 
                                                y_axis_fBodyAccJerk_std=mean(y_axis_fBodyAccJerk_std), 
                                                z_axis_fBodyAccJerk_std=mean(z_axis_fBodyAccJerk_std),
                                                x_axis_fBodyGyro_mean=mean(x_axis_fBodyGyro_mean), 
                                                y_axis_fBodyGyro_mean=mean(y_axis_fBodyGyro_mean), 
                                                z_axis_fBodyGyro_mean=mean(z_axis_fBodyGyro_mean), 
                                                x_axis_fBodyGyro_std=mean(x_axis_fBodyGyro_std), 
                                                y_axis_fBodyGyro_std=mean(y_axis_fBodyGyro_std), 
                                                z_axis_fBodyGyro_std=mean(z_axis_fBodyGyro_std),
                                                fBodyAccMag_mean= mean(fBodyAccMag_mean), 
                                                fBodyAccMag_std=mean(fBodyAccMag_std),
                                                fBodyBodyAccJerkMag_mean=mean(fBodyBodyAccJerkMag_mean), 
                                                fBodyBodyAccJerkMag_std=mean(fBodyBodyAccJerkMag_std),
                                                fBodyBodyGyroMag_mean=mean(fBodyBodyGyroMag_mean), 
                                                fBodyBodyGyroMag_std=mean(fBodyBodyGyroMag_std),
                                                fBodyBodyGyroJerkMag_mean=mean(fBodyBodyGyroJerkMag_mean), 
                                                fBodyBodyGyroJerkMag_std=mean(fBodyBodyGyroJerkMag_std))

write.table(Mean_X_Y_Subject_with_Descriptive_Names, "./accelerometers/Tidy_Data_output.txt", sep="\t", row.name=FALSE)


