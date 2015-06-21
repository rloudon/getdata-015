library(data.table)

setwd("C:/Users/rloudon86/Desktop/R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
training_data <- read.csv("X_train.txt", sep="", header=FALSE)
training_labels <- read.csv("Y_train.txt", sep="", header=FALSE)
training_subject <- read.csv("subject_train.txt", sep="", header=FALSE)

training_data[,562]<-training_labels
training_data[,563]<-training_subject
rm(training_labels)
rm(training_subject)
names(training_data)

setwd("C:/Users/rloudon86/Desktop/R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
testing_data <- read.csv("X_test.txt", sep="", header=FALSE)
testing_labels <- read.csv("Y_test.txt", sep="", header=FALSE)
testing_subject <- read.csv("subject_test.txt", sep="", header=FALSE)

testing_data[,562]<-testing_labels
testing_data[,563]<-testing_subject
rm(testing_labels)
rm(testing_subject)

setwd("C:/Users/rloudon86/Desktop/R/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
activity_labels <-read.csv("activity_labels.txt", sep="", header=FALSE)
features <-read.csv("features.txt", sep="", header=FALSE)

combined_data <- rbind(training_data,testing_data)
rm(training_data)
rm(testing_data)
names(combined_data)[562:563]<- c("labels","subject")
names(combined_data)

mean_std_match <- grep("mean\\()|std\\()", features[,2])

features_select <- features[mean_std_match,]

features_select[,2]<-gsub("\\()","",features_select[,2])
features_select[,2]<-gsub("std","Standard_Deviation",features_select[,2])
features_select[,2]<-gsub("mean","Mean",features_select[,2])
features_select

cols_select <- c(mean_std_match, 562, 563)
combined_data_select <- combined_data[,cols_select]
names(combined_data_select) <- c(as.character(features_select$V2), "Activity", "Subject")

for (x in 1:6) {
  combined_data_select$Activity <- gsub(x, activity_labels[x,2], combined_data_select$Activity)
}
#View(combined_data_select)

combined_datat<- data.table(combined_data_select)
tidy_datat <- combined_datat[,lapply(.SD,mean),by=list(Activity,Subject)]


write.table(tidy_datat,file = "UCI_HAR_Dataset_Tidy.txt",sep="\t",row.names = FALSE)

