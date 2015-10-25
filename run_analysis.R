run_analysis<-function(){
      
      #read global docs
      activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
      Features <- read.table("./UCI HAR Dataset/features.txt")
      
      #read test files
      subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
      testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
      testActivity <- read.table("./UCI HAR Dataset/test/Y_test.txt")
      colnames(testActivity)<-"Activity"
      
      #label X_test with features
      X_test_headers <- Features[,2]
      colnames(testData)<-X_test_headers
      
      #read training docs
      trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
      trainingActivity <- read.table("./UCI HAR Dataset/train/Y_train.txt")
      colnames(trainingActivity)<-"Activity"
      
      #label X_train(trainingData) with features
      X_test_headers <- Features[,2]
      colnames(trainingData)<-X_test_headers
      
      #merge test and train activities and label
      allActivity <- rbind(testActivity,trainingActivity)
      allActivity[allActivity$Activity == 1,] <- "WALKING"
      allActivity[allActivity$Activity == 2,] <- "WALKING_UPSTAIRS"
      allActivity[allActivity$Activity == 3,] <- "WALKING_DOWNSTAIRS"
      allActivity[allActivity$Activity == 4,] <- "SITTING"
      allActivity[allActivity$Activity == 5,] <- "STANDING"
      allActivity[allActivity$Activity == 6,] <- "LAYING"
            
      #Remove testDF columns not relating to means and standard deviations
      testSubset<-testData[ ,grepl( "mean|std", names(testData))]
      
      #Remove trainDF columns not relating to means and standard deviations
      trainSubset<-trainingData[ ,grepl( "mean|std", names(trainingData))]
      
      #create DF using test and training data subsets
      df <- rbind(testSubset,trainSubset)
      
      
      #Add activities to dataframe
      df <- cbind(allActivity, df)
      
      #Add subjects to dataframe
      testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
      trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
      allSubjects <- rbind(testSubjects,trainSubjects)
      colnames(allSubjects)<-"Subject"
      df <- cbind(allSubjects, df)

      #Create second dataframe with the average of each variable 
      #for each activity and each subject
      library(dplyr)
      df2 <- df %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
      write.table(df2, "tidyData.txt", sep="\t", row.names=FALSE, col.names=TRUE) 

      
}