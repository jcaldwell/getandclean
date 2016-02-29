# getandclean


The following files are read from the UCI HAR Dataset.

+ activity_labels.txt
+ features.txt
+ test/subject_test.txt
+ test/X_test.txt
+ test/y_test.txt
+ train/subject_train.txt
+ train/X_train.txt
+ train/y_train.txt

The script tidy_proj.R will combine these into a sigle merged data frames.
The merged data frame only contains the std and mean fields.
The lables of the new data frame are matched from the features labels.
The activities are converted to a factor.

The final merged data set contains the subject, the activity, and the std and mean values relating to that event.
