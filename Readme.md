
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Codebooks
The codebook ```Codebook.md``` is included in this repo.

# Run
Use the following commands in R to run the analysis

```
source("analysisFinal.R")
ejecutaranalisis()
```

### Output
The analysis will result in a file called tidy_data_final.txt


### processed data
The tidy_data_final.txt dataset can be read using

```
data <- read.table(file_path, header = TRUE)
