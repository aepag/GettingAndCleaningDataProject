This is the Course Project for the "Getting and Cleaning Data" course. The R file "run_analysis.R" does the following:

0) Considers the zipped dataset already downloaded into the working directory
1) Reads activity labels and features
2) Filters only the mean and std dev features, and cleans up the names, making them more descriptive
3) Reads train and test datasets (from the features above only) and merges them into one dataset
4) Melts merged data to create the tidy data set with averages to be put into a .txt file
