#################   CLASS PROJECT  ###############
### The following packages are needed in order to run this script
install.packages("dplyr")
library(dplyr)

#################        STEP 1    ###############
################# Download rawdata ###############
### There is no need to run this step if the data is already downloaded ####

if(!file.exists("./rawdata")){dir.create("./rawdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./rawdata/UCI_HAR_Dataset.zip", method="curl")
unzip("./rawdata/UCI_HAR_Dataset.zip",overwrite=TRUE, exdir="./rawdata")
dateDownloaded <- date()
dateDownloaded

################# STEP 2 - CLEAN TRAIN DATA ######
#################        STEP 2A    ##############
### Load up the train files needed for analysis###

X_train <- read.table("./rawdata/UCI HAR Dataset/train/X_train.txt")
dim(X_train)
subject_train <- read.table("./rawdata/UCI HAR Dataset/train/subject_train.txt")
dim(subject_train)
head(subject_train)
y_train <- read.table("./rawdata/UCI HAR Dataset/train/y_train.txt")
dim(y_train)
head(y_train)

#################        STEP 2B    ##############
### Assign variable names to various datasets ####

        ###Assign detailed variable names to X_train dataset
        features <- read.table("./rawdata/UCI HAR Dataset/features.txt")
        features <- features[[2]]
        colnames(X_train)<-features

        ### Assign variable names to subject_train and y_train datasets
        colnames(subject_train)[1] <- "Subject"
        colnames(y_train)[1] <- "Activity"
        
        ### At this points the datasets subject_train and y_train are ready to be merged#

#################        STEP 2C    ##############
####### Clean up the X_train dataset #############

        ## Select only the variables that have mean or standard deviation info
        x<- X_train[,grep("std()", names(X_train), ignore.case=FALSE, value=TRUE)] #selects standard deviation variables
        y<- X_train[,grep("mean()", names(X_train), ignore.case=FALSE, value=TRUE)] #selects mean value variables
        X_train <- cbind(x,y) #binds the two datasets created above
        X_train<- subset(X_train, select= !grepl("Freq()", names(X_train) ) ) #excludes variables for mean frequency
        
        ## modify the variable names as 
        names(X_train) <- gsub("tBody", "TimeBody", names(X_train))
        names(X_train) <- gsub("tGravity", "TimeGravity", names(X_train))        
        names(X_train) <- gsub("fBody", "FastFourierTransformBody", names(X_train))
        names(X_train) <- gsub("Acc", "Accelerometer", names(X_train))
        names(X_train) <- gsub("Jerk", "JerkSignal", names(X_train))
        names(X_train) <- gsub("Gyro", "Gyroscope", names(X_train))
        names(X_train) <- gsub("Mag", "Magnitude", names(X_train))
        names(X_train) <- gsub("mean[(][)]", "MeanValue", names(X_train))
        names(X_train) <- gsub("std[(][)]", "StdDeviation", names(X_train))
        names(X_train) <- gsub("-X", "_axial_X", names(X_train))
        names(X_train) <- gsub("-Y", "_axial_Y", names(X_train))
        names(X_train) <- gsub("-Z", "_axial_Z", names(X_train))
        names(X_train) <- gsub("-", "_", names(X_train))

        ### At this points the dataset X_train (from step 2C) is subject_train and y_train (from step 2B) are ready to be merged#

#################        STEP 2D    ##############
############### Merge 'clean' datasets  ##############
train_data <-cbind(subject_train,y_train,X_train)

###At this point the train data is ready to be merged, but the activy labels still need to be designated

################# STEP 3 - CLEAN TEST DATA #######
#################        STEP 3A    ##############
### Load up the TEST files needed for analysis###

X_test <- read.table("./rawdata/UCI HAR Dataset/test/X_test.txt")
dim(X_test)
subject_test <- read.table("./rawdata/UCI HAR Dataset/test/subject_test.txt")
dim(subject_test)
head(subject_test)
y_test <- read.table("./rawdata/UCI HAR Dataset/test/y_test.txt")
dim(y_test)
head(y_test)

#################        STEP 3B    ##############
### Assign variable names to various datasets ####

###Assign detailed variable names to X_test dataset
features <- read.table("./rawdata/UCI HAR Dataset/features.txt")
features <- features[[2]]
colnames(X_test)<-features

### Assign variable names to subject_test and y_test datasets
colnames(subject_test)[1] <- "Subject"
colnames(y_test)[1] <- "Activity"

### At this points the datasets subject_test and y_test are ready to be merged#

#################        STEP 3C    ##############
####### Clean up the X_test dataset #############

## Select only the variables that have mean or standard deviation info
x<- X_test[,grep("std()", names(X_test), ignore.case=FALSE, value=TRUE)] #selects standard deviation variables
y<- X_test[,grep("mean()", names(X_test), ignore.case=FALSE, value=TRUE)] #selects mean value variables
X_test <- cbind(x,y) #binds the two datasets created above
X_test<- subset(X_test, select= !grepl("Freq()", names(X_test) ) ) #excludes variables for mean frequency

## modify the variable names as 
names(X_test) <- gsub("tBody", "TimeBody", names(X_test))
names(X_test) <- gsub("tGravity", "TimeGravity", names(X_test))        
names(X_test) <- gsub("fBody", "FastFourierTransformBody", names(X_test))
names(X_test) <- gsub("Acc", "Accelerometer", names(X_test))
names(X_test) <- gsub("Jerk", "JerkSignal", names(X_test))
names(X_test) <- gsub("Gyro", "Gyroscope", names(X_test))
names(X_test) <- gsub("Mag", "Magnitude", names(X_test))
names(X_test) <- gsub("mean[(][)]", "MeanValue", names(X_test))
names(X_test) <- gsub("std[(][)]", "StdDeviation", names(X_test))
names(X_test) <- gsub("-X", "_axial_X", names(X_test))
names(X_test) <- gsub("-Y", "_axial_Y", names(X_test))
names(X_test) <- gsub("-Z", "_axial_Z", names(X_test))
names(X_test) <- gsub("-", "_", names(X_test))

### At this point the dataset X_test (from step 3C) is subject_test and y_test (from step 3B) are ready to be merged#

####################     STEP 3D    #################
############### Merge 'clean' datasets  ##############

test_data <-cbind(subject_test,y_test,X_test)

### At this point the TEST dataset is ready to be merged with the train data from steps 2D

#################### STEP 4 - CREATE TIDY SET ##########
####################     STEP 4A    #################
############### Merge clean TEST and TRAIN datasets created in Steps 2D and 3D  ##############

Tidy_Data <- rbind(test_data, train_data)
dim(Tidy_Data)

####################     STEP 4B    #################
#####    Add Labels to "Activity" Variable ##########
Tidy_Data$Activity <- factor(Tidy_Data$Activity, labels=c('Walking','Walking_Upstairs','Walking_Donwstairs','Sitting','Standing','Laying'))

###################    STEP 4C
#####   Create the Tidy_Dataset in txt format ####
write.table(Tidy_Data, "./Tidy_Dataset.txt", row.name=FALSE)

################### STEP 5 - DATASETS WITH AVERAGES ########
##### The following script creates a dataset with the average by subject and activity 
##### for each of the variables in the dataset

x <- tbl_df(Tidy_Data)
grouped <- group_by(x, Subject, Activity)
means_data <- summarise(grouped,
        TimeBodyAccelerometer_StdDeviation_axial_X = mean(TimeBodyAccelerometer_StdDeviation_axial_X),
        TimeBodyAccelerometer_StdDeviation_axial_Y = mean(TimeBodyAccelerometer_StdDeviation_axial_Y),
        TimeBodyAccelerometer_StdDeviation_axial_Z = mean(TimeBodyAccelerometer_StdDeviation_axial_Z),
        TimeGravityAccelerometer_StdDeviation_axial_X = mean(TimeGravityAccelerometer_StdDeviation_axial_X),
        TimeGravityAccelerometer_StdDeviation_axial_Y = mean(TimeGravityAccelerometer_StdDeviation_axial_Y),
        TimeGravityAccelerometer_StdDeviation_axial_Z = mean(TimeGravityAccelerometer_StdDeviation_axial_Z),
        TimeBodyAccelerometerJerkSignal_StdDeviation_axial_X = mean(TimeBodyAccelerometerJerkSignal_StdDeviation_axial_X),
        TimeBodyAccelerometerJerkSignal_StdDeviation_axial_Y = mean(TimeBodyAccelerometerJerkSignal_StdDeviation_axial_Y),
        TimeBodyAccelerometerJerkSignal_StdDeviation_axial_Z = mean(TimeBodyAccelerometerJerkSignal_StdDeviation_axial_Z),
        TimeBodyGyroscope_StdDeviation_axial_X = mean(TimeBodyGyroscope_StdDeviation_axial_X),
        TimeBodyGyroscope_StdDeviation_axial_Y = mean(TimeBodyGyroscope_StdDeviation_axial_Y),
        TimeBodyGyroscope_StdDeviation_axial_Z = mean(TimeBodyGyroscope_StdDeviation_axial_Z),
        TimeBodyGyroscopeJerkSignal_StdDeviation_axial_X = mean(TimeBodyGyroscopeJerkSignal_StdDeviation_axial_X),
        TimeBodyGyroscopeJerkSignal_StdDeviation_axial_Y = mean(TimeBodyGyroscopeJerkSignal_StdDeviation_axial_Y),
        TimeBodyGyroscopeJerkSignal_StdDeviation_axial_Z = mean(TimeBodyGyroscopeJerkSignal_StdDeviation_axial_Z),
        TimeBodyAccelerometerMagnitude_StdDeviation = mean(TimeBodyAccelerometerMagnitude_StdDeviation),
        TimeGravityAccelerometerMagnitude_StdDeviation = mean(TimeGravityAccelerometerMagnitude_StdDeviation),
        TimeBodyAccelerometerJerkSignalMagnitude_StdDeviation = mean(TimeBodyAccelerometerJerkSignalMagnitude_StdDeviation),
        TimeBodyGyroscopeMagnitude_StdDeviation = mean(TimeBodyGyroscopeMagnitude_StdDeviation),
        TimeBodyGyroscopeJerkSignalMagnitude_StdDeviation = mean(TimeBodyGyroscopeJerkSignalMagnitude_StdDeviation),
        FastFourierTransformBodyAccelerometer_StdDeviation_axial_X = mean(FastFourierTransformBodyAccelerometer_StdDeviation_axial_X),
        FastFourierTransformBodyAccelerometer_StdDeviation_axial_Y = mean(FastFourierTransformBodyAccelerometer_StdDeviation_axial_Y),
        FastFourierTransformBodyAccelerometer_StdDeviation_axial_Z = mean(FastFourierTransformBodyAccelerometer_StdDeviation_axial_Z),
        FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_X = mean(FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_X),
        FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_Y = mean(FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_Y),
        FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_Z = mean(FastFourierTransformBodyAccelerometerJerkSignal_StdDeviation_axial_Z),
        FastFourierTransformBodyGyroscope_StdDeviation_axial_X = mean(FastFourierTransformBodyGyroscope_StdDeviation_axial_X),
        FastFourierTransformBodyGyroscope_StdDeviation_axial_Y = mean(FastFourierTransformBodyGyroscope_StdDeviation_axial_Y),
        FastFourierTransformBodyGyroscope_StdDeviation_axial_Z = mean(FastFourierTransformBodyGyroscope_StdDeviation_axial_Z),
        FastFourierTransformBodyAccelerometerMagnitude_StdDeviation = mean(FastFourierTransformBodyAccelerometerMagnitude_StdDeviation),
        FastFourierTransformBodyBodyAccelerometerJerkSignalMagnitude_StdDeviation = mean(FastFourierTransformBodyBodyAccelerometerJerkSignalMagnitude_StdDeviation),
        FastFourierTransformBodyBodyGyroscopeMagnitude_StdDeviation = mean(FastFourierTransformBodyBodyGyroscopeMagnitude_StdDeviation),
        FastFourierTransformBodyBodyGyroscopeJerkSignalMagnitude_StdDeviation = mean(FastFourierTransformBodyBodyGyroscopeJerkSignalMagnitude_StdDeviation),
        TimeBodyAccelerometer_MeanValue_axial_X = mean(TimeBodyAccelerometer_MeanValue_axial_X),
        TimeBodyAccelerometer_MeanValue_axial_Y = mean(TimeBodyAccelerometer_MeanValue_axial_Y),
        TimeBodyAccelerometer_MeanValue_axial_Z = mean(TimeBodyAccelerometer_MeanValue_axial_Z),
        TimeGravityAccelerometer_MeanValue_axial_X = mean(TimeGravityAccelerometer_MeanValue_axial_X),
        TimeGravityAccelerometer_MeanValue_axial_Y = mean(TimeGravityAccelerometer_MeanValue_axial_Y),
        TimeGravityAccelerometer_MeanValue_axial_Z = mean(TimeGravityAccelerometer_MeanValue_axial_Z),
        TimeBodyAccelerometerJerkSignal_MeanValue_axial_X = mean(TimeBodyAccelerometerJerkSignal_MeanValue_axial_X),
        TimeBodyAccelerometerJerkSignal_MeanValue_axial_Y = mean(TimeBodyAccelerometerJerkSignal_MeanValue_axial_Y),
        TimeBodyAccelerometerJerkSignal_MeanValue_axial_Z = mean(TimeBodyAccelerometerJerkSignal_MeanValue_axial_Z),
        TimeBodyGyroscope_MeanValue_axial_X = mean(TimeBodyGyroscope_MeanValue_axial_X),
        TimeBodyGyroscope_MeanValue_axial_Y = mean(TimeBodyGyroscope_MeanValue_axial_Y),
        TimeBodyGyroscope_MeanValue_axial_Z = mean(TimeBodyGyroscope_MeanValue_axial_Z),
        TimeBodyGyroscopeJerkSignal_MeanValue_axial_X = mean(TimeBodyGyroscopeJerkSignal_MeanValue_axial_X),
        TimeBodyGyroscopeJerkSignal_MeanValue_axial_Y = mean(TimeBodyGyroscopeJerkSignal_MeanValue_axial_Y),
        TimeBodyGyroscopeJerkSignal_MeanValue_axial_Z = mean(TimeBodyGyroscopeJerkSignal_MeanValue_axial_Z),
        TimeBodyAccelerometerMagnitude_MeanValue = mean(TimeBodyAccelerometerMagnitude_MeanValue),
        TimeGravityAccelerometerMagnitude_MeanValue = mean(TimeGravityAccelerometerMagnitude_MeanValue),
        TimeBodyAccelerometerJerkSignalMagnitude_MeanValue = mean(TimeBodyAccelerometerJerkSignalMagnitude_MeanValue),
        TimeBodyGyroscopeMagnitude_MeanValue = mean(TimeBodyGyroscopeMagnitude_MeanValue),
        TimeBodyGyroscopeJerkSignalMagnitude_MeanValue = mean(TimeBodyGyroscopeJerkSignalMagnitude_MeanValue),
        FastFourierTransformBodyAccelerometer_MeanValue_axial_X = mean(FastFourierTransformBodyAccelerometer_MeanValue_axial_X),
        FastFourierTransformBodyAccelerometer_MeanValue_axial_Y = mean(FastFourierTransformBodyAccelerometer_MeanValue_axial_Y),
        FastFourierTransformBodyAccelerometer_MeanValue_axial_Z = mean(FastFourierTransformBodyAccelerometer_MeanValue_axial_Z),
        FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_X = mean(FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_X),
        FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_Y = mean(FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_Y),
        FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_Z = mean(FastFourierTransformBodyAccelerometerJerkSignal_MeanValue_axial_Z),
        FastFourierTransformBodyGyroscope_MeanValue_axial_X = mean(FastFourierTransformBodyGyroscope_MeanValue_axial_X),
        FastFourierTransformBodyGyroscope_MeanValue_axial_Y = mean(FastFourierTransformBodyGyroscope_MeanValue_axial_Y),
        FastFourierTransformBodyGyroscope_MeanValue_axial_Z = mean(FastFourierTransformBodyGyroscope_MeanValue_axial_Z),
        FastFourierTransformBodyAccelerometerMagnitude_MeanValue = mean(FastFourierTransformBodyAccelerometerMagnitude_MeanValue),
        FastFourierTransformBodyBodyAccelerometerJerkSignalMagnitude_MeanValue = mean(FastFourierTransformBodyBodyAccelerometerJerkSignalMagnitude_MeanValue),
        FastFourierTransformBodyBodyGyroscopeMagnitude_MeanValue = mean(FastFourierTransformBodyBodyGyroscopeMagnitude_MeanValue),
        FastFourierTransformBodyBodyGyroscopeJerkSignalMagnitude_MeanValue = mean(FastFourierTransformBodyBodyGyroscopeJerkSignalMagnitude_MeanValue)
        )

##Since the assigment instruction do not stipulate whether an output file should be csv or txt for this step, the program creates both

write.csv(means_data, "./means_dataset.csv")
write.table(means_data, "./means_dataset.txt", row.name=FALSE)          
          
          
