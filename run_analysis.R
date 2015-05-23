library (dplyr)
library(stringr)

# Reading in the feature table and getting it prepped to be column header for combined table later

feature=read.table("UCI HAR Dataset\\features.txt")
features=tbl_df(feature)
features_do=select(features, V2)
x_features=t(features_do)

# This section reads in the text data for all the Test and Train files

testX=read.table("\\UCI HAR Dataset\\test\\X_test.txt",)
x_test=tbl_df(testX)

trainX=read.table("\\UCI HAR Dataset\\train\\X_train.txt",)
x_train=tbl_df(trainX)

testY=read.table("\\UCI HAR Dataset\\test\\y_test.txt",)
y_test=tbl_df(testY)

trainY=read.table("\\UCI HAR Dataset\\train\\y_train.txt",)
y_train=tbl_df(trainY)

subject_test=read.table("\\UCI HAR Dataset\\test\\subject_test.txt",)
s_test=tbl_df(subject_test)

subject_train=read.table("\\UCI HAR Dataset\\train\\subject_train.txt",)
s_train=tbl_df(subject_train)

#  This section couples each of the Test and Train data frames by type

x_bind=rbind(x_test, x_train)
s_data=rbind(s_test, s_train)
y_data=rbind(y_test, y_train)

# This section attaches descriptive activity names to the data sets

colnames(x_bind)=x_features[1,]
colnames(s_data)="Subject"
colnames(y_data)="Activities"

# This section splits removes all columns that do not have either "mean" or "std" 

x_bind_sub1=x_bind[,grepl("mean()", names(x_bind), fixed=TRUE)]
x_bind_sub1=cbind("Index" = sprintf("%03d", 1:nrow(x_bind_sub1)), x_bind_sub1)
x_bind_sub2=x_test[,grepl("std()", names(x_bind), fixed=TRUE)]
x_bind_sub2=cbind("Index" = sprintf("%03d", 1:nrow(x_bind_sub2)), x_bind_sub2)

#  This section pulls all the "x" data back together

x_final=merge(x_bind_sub1, x_bind_sub2, by="Index", all=TRUE)

#  This just removes the "Index" column

x_final$Index=NULL

#  This combines all of the data together in a single data set

total_data=cbind(x_final, y_data, s_data)

#  This section creates a tidy set with the average of each variable in total_data table

Average_Data=lapply(total_data, mean)
View(Average_Data)
