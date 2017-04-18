## Code Book

This code book describes the variables, the data, and any transformations or work that I performed to clean up the data.

### Variables
* Train variables (x_train, y_train, subject_train) - raw datasets containing train data
* Test variables (x_test, y_test, subject_test) - raw datasets containing test data
* Dataset variables (x_dataset, y_dataset, subject_dataset) - raw datasets of the merged train and test datasets

* features - raw dataset containing the features dataset
* mean_and_std_features - the "features" dataset trimmed for only the mean and std, used to modify col2 of the x_dataset

* activites - raw dataset containing the activites dataset, used to modify col2 of the y_dataset

* masterdata - tidy dataset, the merging of x, y, and subject datasets after they have been modified per the project specifications
* averages_dataset - tidy dataset, takes the average of each variable for each activity and subject
