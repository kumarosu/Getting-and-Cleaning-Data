# Getting-and-Cleaning-Data

Below is what the run_analysis.R script does 

1. Loads the  R Library dplyr and ddply. These libraries will be used for data manipulation in the script

2. As a part of this script, 'accelerometers' directory needs to be created. This script has automated the 
Director creation process which will hold the raw source data  

3. Script Points a variable to the URL from where the raw data file will be downloaded

4. The source data file will be Downloaded automatically as a part of this step 

5. The script Unzips the downloaded zip data file 

6. The Script first Load the Activity Labels and features file and rename the file column names to descriptive 
names

7. The Script then Loads the following Training Dataset - X_train.txt, y_train.txt and subject_train.txt

8. The Script then Loads the following Test Dataset - X_test.txt, y_test.txt and subject_test.txt

9.  The training and test sets are being merged as a part of this step resulting in 3 separate data files 1.x 2.y and 3.Subject

10. Y and Subject data sets column names is being renames to descriptive column names

11. The script then merges all files into one Tidy Data Set 

12. From the Tidy Data Set file, extract only the column names which contains means or standard deviation

13. The file generated as a part of #12 will be merged with Activity data file to include the activity description 
column 

14. All the columns in the file generated as a part of step 13 will be names with descriptive variable names 

15. The mean and standard deviation column in the dataset in step 14 is calculated grouping by Activity and Subject 

16. The file generated in Step 15 is written as the text file in the specified directory  