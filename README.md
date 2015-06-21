# Coursera Getting and Cleaning Data getdata-015 Course Project

The script imports previously downloaded sets of UCI Human Activity Recognition data, one training and one testing data.
Corresponding activity label and subject keys are joined to the respective data set.

Activity label names and feature names for the activity measurement variables are read into R.

The training and testing data are combined into a single data set.

The feature names are matched against patterns to identify the mean and standard deviation measurement variables.  
The feature name data is subsetted for only these indices.
The feature names are cleaned up to remove parentheses and clarify the measurement as either Mean or Standard Deviation.

The combined data set is subsetted for the matching indices and the variable field names renamed with the respective feature name.

The activity names are renamed to the descriptive labels.  

The combined data set is converted to a data.table.  

The mean is calculated for each variable for each activity for each subject.

The tidy data output is written to a .txt file.
