# GettingAndCleaningData
library(plyr)


data_dir : Variable that sets the path to the working directory where all the files are present

## Set paths to the files
x_train_p 	: Path to x_train file
x_test_p  	:  Path to x_test file
y_train_p 	:  Path to y_train file
y_test_p  	:  Path to y_test  file
subject_train_p :  Path to subject_train file
subject_test_p  :  Path to subject_test file

features_p      : Path to features.txt file
activities_p    :  Path to activity_labels.txt file

x_train 	: Data frame that stores read.table x_train Data
x_test  	: Data frame that stores read.table x_test Data
y_train 	: Data frame that stores read.table y_train Data
y_test  	: Data frame that stores read.table y_test Data
subject_train 	: Data frame that stores subject_train Data
subject_test  	: Data frame that stores subject_test Data

## Merge training data and test dat to one data frame
x_merge : Merged x Data
y_merge : Merged y Data
subject_merge : Merged subject Data

## Read features from features.txt file and replace (,),,,- with "."
features : Data frame that stores features.txt data
activities : Data frame that stores activity_labels.txt

## variable to match the length of x_merge rows
y_merge2 : Rbind was not working as expected so ended up creating this variable
           Used for recycling purpose
subject_merge2 : Rbind was not working as expected so ended up creating this variable
           Used for recycling purpose

mean_std_df : Merged data frame containg y_merge, subject_merge, x_merge

clean_data : Data frame to get the activity, subject and mean of x_merge$tBodyAcc.mean...X column

## I though a for loop will work here but it did not. So ended up with the clumpsy code.
## Also going on vacation and do not have time to clean the below code. Another day I 
## could have cleaned the code

## Below code to calculate column wise average of all the categories listed in "activity" and "subjects" columns
clean_data_full : Complete Data frame with means of all x_merge data


How the code works
==================

1) Read x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt, subject_test.txt
   from the respective directories
2) Merge training data and test dat to one data frame(for the the 3 data cases)
3) Create label names from activities_labels.txt
4) Read features from features.txt file and replace (,),,,- with "."
5) Merge x_merge(get only mean, std columns), y_merge and subject_merge by recycling whereever necessary
6) Calculate means of x_merge bases on categories defined by y_merge and subject_merge 
