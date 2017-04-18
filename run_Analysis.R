# Set up
# Load necessary packages
library(plyr)

# Download and unzip datafile

filename <- "UCI HAR Dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Project Begin
# 1. Merges the training and the test sets to create one data set.

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_dataset <- rbind(x_train, x_test)
y_dataset <- rbind(y_train,y_test)
subject_dataset <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

x_dataset <- x_dataset[, mean_and_std_features]
names(x_dataset) <- features[mean_and_std_features, 2]

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
y_dataset[, 1] <- activities[y_dataset[, 1], 2]
names(y_dataset) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names.

names(subject_dataset) <- "subject"
master_data <- cbind(x_dataset, y_dataset, subject_dataset)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# includes all columns except final two (activity and subject)
averages_dataset <- ddply(master_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

#create tidy.txt file
write.table(averages_dataset, "tidy.txt", row.name=FALSE)
