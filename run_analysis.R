library(plyr)


## Path where the files are present
setwd("C:/Users/dinesh.kotti/Desktop/Personal/Career/JHMacLearning/Getting_and_Cleaning_Data/data/Project/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/")
data_dir <- getwd()

## Set paths to the files
x_train_p <- paste(data_dir, "/train/X_train.txt", sep="")
x_test_p  <- paste(data_dir, "/test/X_test.txt", sep="")
y_train_p <- paste(data_dir, "/train/y_train.txt", sep="")
y_test_p  <- paste(data_dir, "/test/y_test.txt", sep="")
subject_train_p <- paste(data_dir, "/train/subject_train.txt", sep="")
subject_test_p  <- paste(data_dir, "/test/subject_test.txt", sep="")

features_p  <- paste(data_dir, "./features.txt", sep="")
activities_p <- paste(data_dir, "./activity_labels.txt", sep="")

## Read the files and store in data frames
x_train <- read.table(x_train_p, header=FALSE, sep=" ", fill=TRUE)
x_test  <- read.table(x_test_p, header=FALSE, sep=" ", fill=TRUE)
y_train <- read.table(y_train_p, header=FALSE, sep=" ", fill=TRUE)
y_test  <- read.table(y_test_p, header=FALSE, sep=" ", fill=TRUE)
subject_train <- read.table(subject_train_p, header=FALSE, sep=" ", fill=TRUE)
subject_test  <- read.table(subject_test_p, header=FALSE, sep=" ", fill=TRUE)

## Merge training data and test dat to one data frame
##x_merge <- merge(x_train, x_test, by=intersect(colnames(x_train), colnames(x_test)), all=TRUE)
x_merge <- rbind(x_train[,1:662], x_test[,1:662])
y_merge <- rbind(y_train, y_test)
subject_merge <- rbind(subject_train, subject_test)

## Create label names from activities_labels.txt
for(i in 1:dim(y_merge)) { 
  if(y_merge[i,1] == 1) { y_merge[i,1] <- "WALKING"}
  if(y_merge[i,1] == 2) { y_merge[i,1] <- "WALKING_UPSTAIRS" }
  if(y_merge[i,1] == 3) { y_merge[i,1] <- "WALKING_DOWNSTAIRS" }
  if(y_merge[i,1] == 4) { y_merge[i,1] <- "SITTING" }
  if(y_merge[i,1] == 5) { y_merge[i,1] <- "STANDING" }
  if(y_merge[i,1] == 6) { y_merge[i,1] <- "LAYING" }
}

## Read features from features.txt file and replace (,),,,- with "."
features <- read.csv(features_p, sep=" ",header=FALSE)
features$V2<-gsub("[),-]", ".", features$V2)
features$V2<-gsub("[(]", ".", features$V2)
activities <- read.csv(activities_p, sep=" ",header=FALSE)

## name the columns
names(y_merge) <- "activity"
names(subject_merge) <- "subject"
for(i in 3:dim(x_merge)[2]) { names(x_merge)[i] <- as.character(features[,2][i-2])}

View(x_merge)
View(y_merge)
View(subject_merge)


## dim(x_train)       ## [1] 11228   662
## dim(x_test)        ## [1] 4312    667
## dim(y_train)       ## [1] 7352    1
## dim(y_test)        ## [1] 2947    1
## dim(subject_train) ## [1] 7352    1
## dim(subject_test)  ## [1] 2947    1

## rbind was not working as expected so creating extra 
## variable to match the length of x_merge rows
y_merge2 <- rbind(y_merge, y_merge)
subject_merge2 <- rbind(subject_merge, subject_merge)

mean_std_df <- cbind(y_merge2[1:15540,], subject_merge2[1:15540,],
                      x_merge[,grep("mean",colnames(x_merge),ignore.case=TRUE)], 
                        x_merge[,grep("std",colnames(x_merge),ignore.case=TRUE)])
names(mean_std_df)[1] <- "activity"
names(mean_std_df)[2] <- "subjects"

clean_data <- ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,3], na.rm=TRUE))

## I though a for loop will work here but it did not. So ended up with the clumpsy code.
## Also going on vacation and do not have time to clean the below code. Another day I 
## could have cleaned the code

## Below code to calculate column wise average of all the categories listed in "activity" and "subjects" columns
clean_data_full <- cbind(clean_data, ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,5], na.rm=TRUE))[,3],
                                     ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,6], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,6], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,7], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,8], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,9], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,10], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,11], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,12], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,13], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,14], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,15], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,16], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,17], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,18], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,19], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,20], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,21], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,22], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,23], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,24], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,25], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,26], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,27], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,28], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,29], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,30], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,31], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,32], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,33], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,34], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,35], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,36], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,37], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,38], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,39], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,40], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,41], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,42], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,43], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,44], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,45], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,46], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,47], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,48], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,49], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,50], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,51], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,52], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,53], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,54], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,55], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,56], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,57], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,58], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,59], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,60], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,61], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,62], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,63], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,64], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,65], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,66], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,67], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,68], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,69], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,70], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,71], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,72], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,73], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,74], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,75], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,76], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,77], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,78], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,79], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,80], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,81], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,82], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,83], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,84], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,85], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,86], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,87], na.rm=TRUE))[,3],
                         ddply(mean_std_df, .(activity, subjects), summarize, mean=mean(mean_std_df[,88], na.rm=TRUE))[,3]
                         )
names(clean_data_full) <- names(mean_std_df)

## print the clean_data_full to a text file for submission
write.table(clean_data_full, file = "project_output.txt", sep = " ", row.names=FALSE, col.names=TRUE, fileEncoding= "")
