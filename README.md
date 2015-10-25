# run_analysis
Includes the run_analysis code, readme file and codebook

This includes a reorganization of data from the UCI HAR Dataset.

The dataset includes the following files:
README.md
run_analysis.R
run_analysis Code Book

The run_analysis code creates two dataframes named df and df2 and one table.
df creates a large, organized database that combines the subject number and activity for all test and train data that measures means and standard deviations. The database includes descriptive activity labels and labels the data with the feature label. The activity and feature labels are pulled from the original data source, from the files activity_labels.txt and features.txt. df2 is a dataframe that present a tidy dataset that includes for each subject and activity the mean value for each feature. 

The following steps were used to create the df dataframe:
1. X_test was renamed to testData and labeled using features.txt from original data
2. X_training was renamed to trainingData and labeled using features.txt from original data
3. Test and training activities (y_test and y_train files) were merged and labeled using activity_labels.txt
4. testData and trainingData columns not related to the means and standard deviations were removed
5. The df dataframe was createdusing the now filtered testData and trainingData 
6. Activity labels and subject numbers were added to the dataframe to better label the data

Upon completion of these steps df2 was greated by grouping by subject and activity and summarizing with the mean function.

The run_analysis function also writes a table of the df2 data. This table is titled "tidyData.txt"

