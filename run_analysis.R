library(reshape2)

# read activities and features
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt') 
features = read.table('./UCI HAR Dataset/features.txt')

# considering only mean and std dev values, cleaning up the names
featuresMeanAndStdDev <- grep(".*mean.*|.*std.*", features[,2])
featuresMeanAndStdDevNames <- features[featuresMeanAndStdDev,2]
featuresMeanAndStdDevNames <- gsub('[-()]', '', featuresMeanAndStdDevNames)
featuresMeanAndStdDevNames = gsub('mean', 'Mean', featuresMeanAndStdDevNames)
featuresMeanAndStdDevNames = gsub('std', 'StdDev', featuresMeanAndStdDevNames)

#reading train and test datasets and merging them
subjectTrain = read.table('./UCI HAR Dataset/train/subject_train.txt') 
yTrain = read.table('./UCI HAR Dataset/train/y_train.txt')
xTrain = read.table('./UCI HAR Dataset/train/x_train.txt')[featuresMeanAndStdDev] 
trainData <- cbind(subjectTrain, yTrain, xTrain)
subjectTest = read.table('./UCI HAR Dataset/test/subject_test.txt');
yTest = read.table('./UCI HAR Dataset/test/y_test.txt');
xTest = read.table('./UCI HAR Dataset/test/x_test.txt') [featuresMeanAndStdDev] 
testData <- cbind(subjectTest, yTest, xTest)
mergedData <- rbind(trainData, testData)

#using cleaned up feature names as column names
colnames(mergedData) <- c("subject", "activity", featuresMeanAndStdDevNames)

#melting merged data to create tidy data set with average values
mergedData$activity <- factor(mergedData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mergedData$subject <- as.factor(mergedData$subject)
meltedMergedData <- melt(mergedData, id = c("subject", "activity"))
meanMergedData <- dcast(meltedMergedData, subject + activity ~ variable, mean)
write.table(meanMergedData, "tidy.txt", row.names = FALSE, quote = FALSE)
